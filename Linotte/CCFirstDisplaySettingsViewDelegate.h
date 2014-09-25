//
//  CCFirstDisplaySettingsViewDelegate.h
//  Linotte
//
//  Created by stant on 19/09/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCFirstDisplaySettingsViewDelegate <NSObject>

- (void)setNotificationEnabled:(BOOL)enabled;

- (void)showListSetting;

@end
