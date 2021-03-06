//
//  CCFirstAddressDisplaySettingsViewController.m
//  Linotte
//
//  Created by stant on 19/09/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCFirstAddressDisplaySettingsViewController.h"

#import <Mixpanel/Mixpanel.h>

#import "CCLinotteCoreDataStack.h"
#import "CCModelChangeMonitor.h"

#import "CCFirstAddressDisplaySettingsView.h"

#import "CCAddress.h"


@implementation CCFirstAddressDisplaySettingsViewController
{
    CCAddress *_address;
}

- (instancetype)initWithAddress:(CCAddress *)address
{
    self = [super init];
    if (self) {
        _address = address;
    }
    return self;
}

- (void)loadContentView
{
    CCFirstAddressDisplaySettingsView *view = [CCFirstAddressDisplaySettingsView new];
    view.delegate = self;
    self.contentView = view;
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
}

#pragma mark - CCFirstAddressDisplaySettingsViewDelegate methods

- (void)setNotificationEnabled:(BOOL)enabled
{
    [[CCModelChangeMonitor sharedInstance] addressesWillUpdateUserData:@[_address] send:YES];
    _address.notify = @(enabled);
    
    [[CCLinotteCoreDataStack sharedInstance] saveContext];
    [[CCModelChangeMonitor sharedInstance] addressesDidUpdateUserData:@[_address] send:YES];
    NSString *identifier = _address.identifier ?: @"NEW";
    @try {
        [[Mixpanel sharedInstance] track:@"Notification enable" properties:@{@"name": _address.name, @"address": _address.address, @"identifier": identifier, @"enabled": _address.notify}];
    }
    @catch(NSException *e) {
        CCLog(@"%@", e);
    }
}

- (void)showListSetting
{
    [self.delegate showListSettings];
}

@end
