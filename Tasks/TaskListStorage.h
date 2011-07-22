//
//  TaskListStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskList;
@class Account;

@protocol TaskListStorage <NSObject>

- (NSArray *)getTaskListsForAccount:(Account *)account;
- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account;
- (void) addTaskList:(TaskList *)taskList forAccount:(Account *)account;
- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account;

@end
