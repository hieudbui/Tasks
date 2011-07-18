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

@implementation Account

@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize name=_name;
@synthesize taskLists=_taskLists;
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
    return [NSString stringWithFormat:@"name: %@ userName: %@ password: %@ type: %d new: %i", _name, _userName, _password,_type, _new];
}

-(NSArray *)taskLists
{
    if(_taskLists == nil) {
        _taskLists=[_taskStorage getAllTaskListsForAccount:self];
        [_taskLists retain];
    }
    return _taskLists;
}

-(void)removeTaskList:(TaskList *)taskList
{
    NSLog(@"remove taskList: %@\n",taskList);
    //TODO
    //revisit this code
    //we should remove the tasklist from the taskstorage
    //and reload the tasklists
    [((NSMutableArray *)self.taskLists) removeObject:taskList];
    [_taskStorage removeTaskList:taskList];
}

-(void)addTaskList:(TaskList *)taskList
{
    NSLog(@"Account addTaskList: %@\n",taskList);
    [_taskStorage addTaskList:taskList];
}

-(void)save
{
    [self.accountStorage saveAccount:self];
    self.new=NO;
}

- (void)dealloc
{
    [_userName release];
    [_password release];
    [_name release];
    [_taskStorage release];
    [_accountStorage release];
    [_taskLists release];
    [super dealloc];
}

@end
