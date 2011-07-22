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
- (NSArray *)tasksForTaskList:(TaskList *)taskList;
- (void) saveTask:(Task *)task forTaskList:(TaskList *)taskList;
- (void) removeTask:(Task *)task forTaskList:(TaskList *)taskList;

@end
