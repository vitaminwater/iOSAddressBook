//
//  CCOutputView.h
//  Linotte
//
//  Created by stant on 12/05/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCOutputViewDelegate.h"

@interface CCOutputView : UIView<UITabBarDelegate>

@property(nonatomic, readonly)NSString *currentColor;

@property(nonatomic, weak)id <CCOutputViewDelegate>delegate;

- (instancetype)initWithDelegate:(id<CCOutputViewDelegate>)delegate;
- (void)updateValues;

@end
