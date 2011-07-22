//
//  EditTaskListComplete.h
//  Tasks
//
//  Created by Hieu Bui on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskList;

@protocol EditTaskListComplete <NSObject>


- (void) saveComplete:(TaskList *)taskList;

@end
