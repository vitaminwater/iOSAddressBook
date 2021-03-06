//
//  CCServerEventListMetaDeletedConsumer.m
//  Linotte
//
//  Created by stant on 12/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCServerEventListMetaDeletedConsumer.h"

#import "CCLinotteCoreDataStack.h"
#import "CCModelChangeMonitor.h"

#import "CCServerEvent.h"

#import "CCListMeta.h"
#import "CCList.h"

@implementation CCServerEventListMetaDeletedConsumer
{
    NSArray *_events;
}

@dynamic event;

- (CCServerEventEvent)event
{
    return CCServerEventListMetaDeleted;
}

- (BOOL)hasEventsForList:(CCList *)list
{
    _events = [CCServerEvent eventsWithEventType:[self event] list:list];
    return [_events count] != 0;
}

- (void)triggerWithList:(CCList *)list completionBlock:(void(^)(BOOL goOnSyncing, BOOL error))completionBlock
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [CCLinotteCoreDataStack sharedInstance].managedObjectContext;
    
    NSArray *identifiers = [_events valueForKeyPath:@"@distinctUnionOfObjects.objectIdentifier"];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[CCListMeta entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier in %@", identifiers];
    [fetchRequest setPredicate:predicate];
    NSArray *metas = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        CCLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(NO, NO);
        });
        return;
    }
    
    CCLog(@"Removing %lu metas for list %@", [metas count], list.identifier);
    [[CCModelChangeMonitor sharedInstance] addressMetasRemove:metas];
    for (CCListMeta *meta in metas) {
        [managedObjectContext deleteObject:meta];
    }
    
    [CCServerEvent deleteEvents:_events];
    _events = nil;
    
    [[CCLinotteCoreDataStack sharedInstance] saveContext];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(YES, NO);
    });
}

@end
