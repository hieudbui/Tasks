//
//  DiskStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DiskStorage : NSObject {
    
}
+ (NSString *)tasksPath;
+ (NSString *)privateDir;

@end
