//
//  CCUserDefaults.m
//  Linotte
//
//  Created by stant on 20/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import "CCCurrentUserData.h"

#define kCCLastUserEventDate @"kCCLastUserEventDate"
#define kCCLastUserEventUpdate @"kCCLastUserEventUpdate"
#define kCCPushNotificationDeviceToken @"kCCPushNotificationDeviceToken"
#define kCCPushNotificationDeviceTokenSent @"kCCPushNotificationDeviceTokenSent"

@implementation CCCurrentUserData
{
    NSDateFormatter *_dateFormatter;
}

@dynamic lastUserEventDate;
@dynamic lastUserEventUpdate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setDateFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss'.'SSS"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    return self;
}

- (NSDate *)lastUserEventDate
{
    NSString *lastUserEventDateString = [[NSUserDefaults standardUserDefaults] valueForKey:kCCLastUserEventDate];
    
    if (lastUserEventDateString == nil)
        return nil;
    
    return [_dateFormatter dateFromString:lastUserEventDateString];
}

- (void)setLastUserEventDate:(NSDate *)lastEventDate
{
    NSString *lastEventDateString = [_dateFormatter stringFromDate:lastEventDate];
    
    [[NSUserDefaults standardUserDefaults] setValue:lastEventDateString forKey:kCCLastUserEventDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)lastUserEventUpdate
{
    NSString *lastUserEventDateString = [[NSUserDefaults standardUserDefaults] valueForKey:kCCLastUserEventUpdate];
    
    if (lastUserEventDateString == nil)
        return nil;
    
    return [_dateFormatter dateFromString:lastUserEventDateString];
}

- (void)setLastUserEventUpdate:(NSDate *)lastEventUpdate
{
    NSString *lastEventUpdateString = [_dateFormatter stringFromDate:lastEventUpdate];
    
    [[NSUserDefaults standardUserDefaults] setValue:lastEventUpdateString forKey:kCCLastUserEventUpdate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSData *)pushNotificationDeviceToken
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:kCCPushNotificationDeviceToken];
}

- (void)setPushNotificationDeviceToken:(NSData *)deviceToken
{
    [[NSUserDefaults standardUserDefaults] setValue:deviceToken forKey:kCCPushNotificationDeviceToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.pushNotificationDeviceTokenSent = NO;
}

- (BOOL)pushNotificationDeviceTokenSent
{
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kCCPushNotificationDeviceTokenSent] boolValue];
}

- (void)setPushNotificationDeviceTokenSent:(BOOL)pushNotificationDeviceTokenSent
{
    [[NSUserDefaults standardUserDefaults] setValue:@(pushNotificationDeviceTokenSent) forKey:kCCPushNotificationDeviceTokenSent];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)totallyKillCurrentSession
{
    self.lastUserEventDate = nil;
    self.lastUserEventUpdate = nil;
    self.pushNotificationDeviceToken = nil;
    self.pushNotificationDeviceTokenSent = NO;
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

#pragma mark - Singleton method

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [self new];
    });
    
    return instance;
}

@end
