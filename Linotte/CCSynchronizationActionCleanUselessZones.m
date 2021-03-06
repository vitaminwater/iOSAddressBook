//
//  CCSynchronizationActionCleanUselessZones.m
//  Linotte
//
//  Created by stant on 10/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCSynchronizationActionCleanUselessZones.h"

#import "CCLinotteCoreDataStack.h"
#import "CCModelChangeMonitor.h"

#import "CCList.h"
#import "CCListZone.h"
#import "CCAddress.h"

@implementation CCSynchronizationActionCleanUselessZones

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[CCModelChangeMonitor sharedInstance] addDelegate:self];
    }
    return self;
}

- (BOOL)listNeedProcess:(CCList *)list
{
    NSUInteger totalNAddresses = [[list.zones valueForKeyPath:@"@sum.nAddresses"] unsignedIntegerValue];
    NSUInteger currentNaddresses = [list.addresses count];
    return currentNaddresses < totalNAddresses && currentNaddresses >= kCCMaxAddressesForList;
}

- (CCList *)findNextListToProcess:(CLLocationCoordinate2D)coordinates
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [CCLinotteCoreDataStack sharedInstance].managedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[CCList entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier != nil and addresses.@count < zones.@sum.nAddresses and addresses.@count >= %@", @(kCCMaxAddressesForList)];
    [fetchRequest setPredicate:predicate];
    NSMutableArray *lists = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (error != nil) {
        CCLog(@"%@", error);
        return nil;
    }
    
    if ([lists count] == 0)
        return nil;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinates.latitude longitude:coordinates.longitude];
    
    NSMutableArray *farLists = [@[] mutableCopy];
    for (CCList *list in lists) {
        CLLocation *listLocation = [[CLLocation alloc] initWithLatitude:list.lastZoneCleaningLatitudeValue longitude:list.lastZoneCleaningLongitudeValue];
        CLLocationDistance distance1 = [listLocation distanceFromLocation:location];
        
        if (distance1 >= 1000)
            [farLists addObject:list];
    }
    
    if ([farLists count] == 0)
        return nil;
    
    [farLists sortUsingComparator:^NSComparisonResult(CCList *list1, CCList *list2) {
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:list1.lastZoneCleaningLatitudeValue longitude:list1.lastZoneCleaningLongitudeValue];
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:list2.lastZoneCleaningLatitudeValue longitude:list2.lastZoneCleaningLongitudeValue];
        
        CLLocationDistance distance1 = [location1 distanceFromLocation:location];
        CLLocationDistance distance2 = [location2 distanceFromLocation:location];
        
        if (distance1 > distance2)
            return NSOrderedAscending;
        else if (distance1 < distance2)
            return NSOrderedDescending;
        return NSOrderedSame;
    }];
    
    return [farLists firstObject];
}

- (void)triggerWithList:(CCList *)list coordinates:(CLLocationCoordinate2D)coordinates completionBlock:(CCSynchronizationCompletionBlock)completionBlock
{
    if (list != nil && [self listNeedProcess:list] == NO) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(NO, NO);
        });
        return;
    }
    
    list = list ?: [self findNextListToProcess:coordinates];
    if (list == nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(NO, NO);
        });
        return;
    }
    
    CCLog(@"Starting CCListSynchronizationActionCleanUselessZones job");
    NSManagedObjectContext *managedObjectContext = [CCLinotteCoreDataStack sharedInstance].managedObjectContext;
    NSArray *sortedZones = [list getListZonesSortedByDistanceFromLocation:coordinates];
    
    NSUInteger addressCounter = 0;
    BOOL cleaned = NO;
    NSMutableArray *removedAddresses = [@[] mutableCopy];
    for (CCListZone *listZone in sortedZones) {
        if (addressCounter > kCCMaxAddressesForList && (listZone.firstFetchValue == NO || listZone.lastAddressFirstFetchDate != nil)) {
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[CCAddress entityName]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ANY lists = %@) AND (geohash BEGINSWITH %@)", list, listZone.geohash];
            [fetchRequest setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *addresses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
            if (error != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(NO, NO);
                });
                CCLog(@"%@", error);
                continue;
            }
            
            cleaned = YES;
            
            CCLog(@"Cleaning %@ zone", listZone.geohash);
            [removedAddresses addObjectsFromArray:addresses];
            
            listZone.firstFetch = @YES;
            listZone.lastAddressFirstFetchDate = nil;
            listZone.lastEventDate = nil;
            listZone.lastUpdate = nil;
        }/* else if (addressCounter < kCCMaxAddressesForList) {
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[CCAddress entityName]];
            [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(ANY lists = %@) AND (geohash BEGINSWITH %@)", list, listZone.geohash]];
            NSUInteger count = [managedObjectContext countForFetchRequest:fetchRequest error:NULL];
            NSLog(@"%@ %d %d", listZone.geohash, listZone.nAddressesValue, (unsigned int)count);
        }*/
        addressCounter += listZone.nAddressesValue;
    }
    
    list.lastZoneCleaningLatitudeValue = coordinates.latitude;
    list.lastZoneCleaningLongitudeValue = coordinates.longitude;

    if (cleaned == NO) {
        [[CCLinotteCoreDataStack sharedInstance] saveContext];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(NO, NO);
        });
        return;
    }
    
    [[CCModelChangeMonitor sharedInstance] addresses:removedAddresses willMoveFromList:list send:NO];
    [list removeAddresses:[NSSet setWithArray:removedAddresses]];
    [[CCLinotteCoreDataStack sharedInstance] saveContext];
    [[CCModelChangeMonitor sharedInstance] addresses:removedAddresses didMoveFromList:list send:NO];
    
    for (CCAddress *address in removedAddresses) {
        if ([address.lists count] == 0)
            [managedObjectContext deleteObject:address];
    }
    [[CCLinotteCoreDataStack sharedInstance] saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(YES, NO);
    });
}

@end
