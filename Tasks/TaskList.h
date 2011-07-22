//
//  TaskList.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class Task;
@protocol TaskStorage;
@protocol TaskListStorage;

@interface TaskList : NSObject {
    NSMutableArray *_completedTasks;
}

-(void) save;
-(void) clearCompletedTasks;
-(Task *)newTask;
-(NSArray *)tasks;

@property(nonatomic,retain) NSString *taskListId;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) Account *account;
@property (nonatomic) BOOL new;
@property(nonatomic,retain) NSObject<TaskStorage> *taskStorage;
@property(nonatomic,retain) NSObject<TaskListStorage> *taskListStorage;
@end
