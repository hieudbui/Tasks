//
//  Account.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "TaskListStorage.h"
#import "TaskStorage.h"
#import "AccountStorage.h"
#import "TaskList.h"

@implementation Account

@synthesize accountId=_accountId;
@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize name=_name;
@synthesize taskStorage=_taskStorage;
@synthesize taskListStorage=_taskListStorage;
@synthesize accountStorage=_accountStorage;
@synthesize new=_new;


-(Account *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
    }
    return self;
}

-(NSString *) description {
    return [NSString stringWithFormat:@"accountId: %@ name: %@ userName: %@ password: %@ type: %d new: %i created: %@ changed: %@", _accountId, _name, _userName, _password,_type, _new, _created, _changed];
}

-(NSArray *)taskLists
{
    return [_taskListStorage getTaskListsForAccount:self];
}

-(void)removeTaskList:(TaskList *)taskList
{
    NSLog(@"remove taskList: %@\n",taskList);
    [_taskListStorage removeTaskList:taskList forAccount:self];
}

-(void)addTaskList:(TaskList *)taskList
{
    NSLog(@"Account addTaskList: %@\n",taskList);
    [_taskListStorage addTaskList:taskList forAccount:self];
}

-(void)save
{
    if(self.new) {
        _created=[[NSDate date] retain];
    }
    _changed=[[NSDate date] retain];
    [self.accountStorage saveAccount:self];
    self.new=NO;
}

-(TaskList *) newTaskList
{
    TaskList *taskList=[[[TaskList alloc] init] autorelease];
    taskList.taskListId=[[NSProcessInfo processInfo] globallyUniqueString];
    taskList.account=self;
    taskList.taskStorage=self.taskStorage;
    taskList.taskListStorage=self.taskListStorage;
    return taskList;
}

- (void)dealloc
{
    [_accountId release];
    [_userName release];
    [_password release];
    [_name release];
    [_taskStorage release];
    [_taskListStorage release];
    [_accountStorage release];
    [_changed release];
    [_created release];
    [super dealloc];
}

@end
