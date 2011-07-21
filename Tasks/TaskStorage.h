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
- (NSArray *)getTasksForTaskList:(TaskList *)taskList;
- (NSArray *)getTaskListsForAccount:(Account *)account;
- (void) saveTask:(Task *)task forTaskList:(TaskList *)taskList;
- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account;
- (void) addTaskList:(TaskList *)taskList forAccount:(Account *)account;
- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account;
@end
