//
//  CCServerEventListUserDataUpdatedConsumer.m
//  Linotte
//
//  Created by stant on 20/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCServerEventListUserDataUpdatedConsumer.h"

#import "CCLinotteAPI.h"
#import "CCModelChangeMonitor.h"
#import "CCLinotteCoreDataStack.h"
#import "CCLinotteEngineCoordinator.h"

#import "CCServerEvent.h"
#import "CCList.h"

@implementation CCServerEventListUserDataUpdatedConsumer
{
    NSArray *_events;
    
    CCList *_currentList;
    NSURLSessionTask *_currentConnection;
}

@dynamic event;

- (CCServerEventEvent)event
{
    return CCServerEventListUserDataUpdated;
}

- (BOOL)hasEventsForList:(CCList *)list
{
    _events = [CCServerEvent eventsWithEventType:[self event] list:list];
    return [_events count] != 0;
}

- (void)triggerWithList:(CCList *)list completionBlock:(void(^)(BOOL goOnSyncing, BOOL error))completionBlock
{
    NSArray *eventIds = [_events valueForKeyPath:@"@unionOfObjects.eventId"];
    _currentList = list;
    _currentConnection = [CCLEC.linotteAPI fetchListUserDataForEventIds:eventIds success:^(NSArray *userDatas) {
        _currentList = nil;
        _currentConnection = nil;
        
        NSManagedObjectContext *managedObjectContext = [CCLinotteCoreDataStack sharedInstance].managedObjectContext;
        
        NSArray *lists = [CCList updateUserDatasInManagedObjectContext:managedObjectContext fromLinotteAPIDictArray:userDatas shittyBlock:^(NSArray *lists) {
            [[CCModelChangeMonitor sharedInstance] listsWillUpdateUserData:lists send:NO];
        }];
        
        [CCServerEvent deleteEvents:_events];
        _events = nil;
        
        [[CCLinotteCoreDataStack sharedInstance] saveContext];
        
        [[CCModelChangeMonitor sharedInstance] listsDidUpdateUserData:lists send:NO];
        completionBlock(YES, NO);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        _currentList = nil;
        _currentConnection = nil;
        
        completionBlock(NO, YES);
    }];
}

#pragma mark - CCModelChangeMonitorDelegate

- (void)listWillRemove:(CCList *)list send:(BOOL)send
{
    if (_currentList == list)
        [_currentConnection cancel];
}

@end
