//
//  CCViewControllerSwiperViewControllerDelegate.h
//  Linotte
//
//  Created by stant on 23/11/14.
//  Copyright (c) 2014 CCSAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCViewControllerSwiperViewControllerDelegate <NSObject>

- (void)viewControllerShown:(UIViewController *)viewController;
- (void)viewControllerHidden:(UIViewController *)viewController;

@end
