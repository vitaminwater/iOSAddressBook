//
//  CCAddressListViewModel.m
//  Linotte
//
//  Created by stant on 24/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCAddressListViewModel.h"

#import "CCLinotteCoreDataStack.h"
#import "CCDictStackCache.h"

#import "CCListViewContentProvider.h"

#import "CCAddress.h"
#import "CCList.h"

@implementation CCAddressListViewModel

@synthesize provider;

#pragma mark CCListViewModelProtocol methods

- (void)loadListItems
{
    NSManagedObjectContext *managedObjectContext = [CCLinotteCoreDataStack sharedInstance].managedObjectContext;
    
    // Addresses
    {
        NSError *error = nil;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[CCAddress entityName]];
        
        NSPredicate *predicate;
        predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@", @YES];
        [fetchRequest setPredicate:predicate];
        
        NSArray *addresses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (error != nil)
            CCLog(@"%@", error);
        else
            [self.provider addAddresses:addresses filteredList:nil];
    }
}

#pragma mark CCModelChangeMonitorDelegate methods

- (void)addressesDidUpdate:(NSArray *)addresses send:(BOOL)send
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@", @YES];
    NSArray *myAddresses = [addresses filteredArrayUsingPredicate:predicate];
    [self.provider refreshListItemContentsForObjects:myAddresses];
}

- (void)addressesDidUpdateUserData:(NSArray *)addresses send:(BOOL)send
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@", @YES];
    NSArray *myAddresses = [addresses filteredArrayUsingPredicate:predicate];
    [self.provider refreshListItemContentsForObjects:myAddresses];
}

- (void)addresses:(NSArray *)addresses didMoveToList:(CCList *)list send:(BOOL)send
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@", @YES];
    NSPredicate *toAddPredicate = [NSPredicate predicateWithFormat:@"lists.@count = 1"];
    NSMutableArray *myAddresses = [[addresses filteredArrayUsingPredicate:predicate] mutableCopy];
    NSArray *toAddAddresses = [myAddresses filteredArrayUsingPredicate:toAddPredicate];
    
    [myAddresses removeObjectsInArray:toAddAddresses];
    [self.provider refreshListItemContentsForObjects:myAddresses];
    [self.provider addAddresses:toAddAddresses filteredList:nil];
}

- (void)addresses:(NSArray *)addresses didMoveFromList:(CCList *)list send:(BOOL)send
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@", @YES];
    NSPredicate *toDeletePredicate = [NSPredicate predicateWithFormat:@"lists.@count = 0"];
    NSMutableArray *myAddresses = [[addresses filteredArrayUsingPredicate:predicate] mutableCopy];
    NSArray *toDeleteAddresses = [myAddresses filteredArrayUsingPredicate:toDeletePredicate];
    
    [myAddresses removeObjectsInArray:toDeleteAddresses];
    [self.provider refreshListItemContentsForObjects:myAddresses];
    [self.provider removeAddresses:toDeleteAddresses];
}

- (void)listsWillRemove:(NSArray *)lists send:(BOOL)send
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAuthor = %@ and lists.@count = 1", @YES];
    NSMutableArray *toDeleteAddresses = [@[] mutableCopy];
    
    for (CCList *list in lists) {
        NSArray *tmp = [[list.addresses filteredSetUsingPredicate:predicate] allObjects];
        [toDeleteAddresses addObjectsFromArray:tmp];
    }
    [self.provider removeAddresses:toDeleteAddresses];
}

@end
