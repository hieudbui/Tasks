//
//  TaskEditComplete.h
//  Tasks
//
//  Created by Hieu Bui on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;

@protocol TaskEditComplete <NSObject>


- (void) saveComplete:(Task *)task;

@end
