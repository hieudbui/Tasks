//
//  Account.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskListStorage;
@protocol TaskStorage;
@protocol AccountStorage;
@class TaskList;

typedef enum {
    Local=0,
    Google=1,
    All=3
} AccountType;

@interface Account : NSObject<NSCoding> {
    NSDate *_created;
    NSDate *_changed;
}

@property AccountType type;
@property(nonatomic,retain) NSString *accountId;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *name;
@property (nonatomic) BOOL new;

@property(nonatomic,retain) NSObject<TaskListStorage> *taskListStorage;
@property(nonatomic,retain) NSObject<TaskStorage> *taskStorage;

@property(nonatomic,retain) NSObject<AccountStorage> *accountStorage;


-(NSArray *)taskLists;
-(void) removeTaskList:(TaskList *)taskList;
-(void) addTaskList:(TaskList *)taskList;
-(TaskList *) newTaskList;
-(void) save;


@end
