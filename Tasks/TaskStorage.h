//
//  NoteStorage.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class Task;
@class TaskList;

@protocol TaskStorage <NSObject> 
- (NSArray *)getAllTasksForAccount:(Account *)account;
- (NSArray *)getTasksForTaskList:(TaskList *)taskList;
- (NSArray *)getAllTaskListsForAccount:(Account *)account;
- (void) saveTask:(Task *)task;
- (void) removeTaskList:(TaskList *)taskList;
- (void) addTaskList:(TaskList *)taskList;
@end
