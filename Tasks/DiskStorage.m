//
//  DiskStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DiskStorage.h"

@implementation DiskStorage

#pragma mark Storage

+ (NSString *)tasksPath 
{
    NSString *documentsDirectory = [DiskStorage privateDir];
    NSError *error;
    NSString *tasksDirectory=[documentsDirectory stringByAppendingPathComponent:@"tasks"];
    BOOL success=[[NSFileManager defaultManager] createDirectoryAtPath:tasksDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    if (!success) {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    return tasksDirectory;
}

+ (NSString *)privateDir 
{    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];   
    return documentsDirectory;
}

@end
