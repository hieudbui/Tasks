//
//  Account.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "InMemoryTaskStorage.h"
#import "NetworkTaskStorage.h"
#import "AccountStorage.h"
#import "TaskList.h"

@implementation Account

@synthesize accountId=_accountId;
@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize name=_name;
@synthesize taskStorage=_taskStorage;
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
    return [NSString stringWithFormat:@"accountId: %@ name: %@ userName: %@ password: %@ type: %d new: %i", _accountId, _name, _userName, _password,_type, _new];
}

-(NSArray *)taskLists
{
    return [_taskStorage getAllTaskListsForAccount:self];
}

-(void)removeTaskList:(TaskList *)taskList
{
    NSLog(@"remove taskList: %@\n",taskList);
    [_taskStorage removeTaskList:taskList forAccount:self];
}

-(void)addTaskList:(TaskList *)taskList
{
    NSLog(@"Account addTaskList: %@\n",taskList);
    [_taskStorage addTaskList:taskList forAccount:self];
}

-(void)save
{
    [self.accountStorage saveAccount:self];
    self.new=NO;
}

-(TaskList *) newTaskList
{
    TaskList *taskList=[[[TaskList alloc] init] autorelease];
    taskList.taskListId=[[NSProcessInfo processInfo] globallyUniqueString];
    taskList.account=self;
    taskList.taskStorage=self.taskStorage;
    return taskList;
}

- (void)dealloc
{
    [_accountId release];
    [_userName release];
    [_password release];
    [_name release];
    [_taskStorage release];
    [_accountStorage release];
    [super dealloc];
}

@end
