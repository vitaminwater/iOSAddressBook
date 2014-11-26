//
//  CCAddAddressByAddressViewController.m
//  Linotte
//
//  Created by stant on 25/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCAddAddressByAddressViewController.h"

#import <Mixpanel/Mixpanel.h>

#import "CCGeohashHelper.h"
#import "CCCoreDataStack.h"

#import "CCAddAddressByAddressView.h"

#import "CCStreetAddressAutoComplete.h"
#import "CCAddressAutocompletionResult.h"

#import "CCAddress.h"

@implementation CCAddAddressByAddressViewController

- (instancetype)init
{
    self = [super initWithAutocompleter:[CCStreetAddressAutoComplete new]];
    if (self) {
        self.title = NSLocalizedString(@"BY_ADDRESS", @"");
    }
    return self;
}

- (void)loadView
{
    CCAddAddressByAddressView *view = [CCAddAddressByAddressView new];
    view.delegate = self;
    self.view = view;
}

#pragma mark - CCAddAddressViewDelegate methods

- (void)autocompletionResultSelectedAtIndex:(NSUInteger)index
{
    CCStreetAddressAutoComplete *autoComplete = (CCStreetAddressAutoComplete *)self.autoComplete;
    
    [autoComplete fetchCompleteInfosForResultAtIndex:index completionBlock:^(CCAddressAutocompletionResult *result) {
        if (result == nil)
            return;
        
        NSManagedObjectContext *managedObjectContext = [CCCoreDataStack sharedInstance].managedObjectContext;
        CCAddress *address = [CCAddress insertInManagedObjectContext:managedObjectContext];
        CCAddressAutocompletionResult *autocompletionResult = [self.autoComplete autocompletionResultAtIndex:index];
        
        address.name = ((CCAddAddressByAddressView *)self.view).addressName;
        address.address = autocompletionResult.address;
        address.provider = autocompletionResult.provider;
        address.providerId = autocompletionResult.providerId;
        address.date = [NSDate date];
        address.latitude = @(autocompletionResult.coordinates.latitude);
        address.longitude = @(autocompletionResult.coordinates.longitude);
        address.isAuthorValue = YES;
        
        address.geohash = [CCGeohashHelper geohashFromCoordinates:autocompletionResult.coordinates];
        
        [self.delegate addAddressViewController:self preSaveAddress:address];
        [[CCCoreDataStack sharedInstance] saveContext];
        [self.delegate addAddressViewController:self postSaveAddress:address];
        
        [self reduceAddView];
        @try {
            [[Mixpanel sharedInstance] track:@"Address added" properties:@{@"name": address.name, @"address": address.address, @"provider": address.provider, @"providerId": address.providerId}];
        }
        @catch(NSException *e) {
            CCLog(@"%@", e);
        }
    }];
}

@end
