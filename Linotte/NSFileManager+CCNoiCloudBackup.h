//
//  NSFileManager+CCNoiCloudBackup.h
//  Linotte
//
//  Created by stant on 11/03/15.
//  Copyright (c) 2015 CCSAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CCNoiCloudBackup)

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
