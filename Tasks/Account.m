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
#import "InMemoryAccountStorage.h"
#import "AccountStorage.h"

@implementation Account

@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize name=_name;
@synthesize taskLists=_taskLists;
@synthesize taskStorage=_taskStorage;
@synthesize accountStorage=_accountStorage;

-(NSString *) description {
    return [NSString stringWithFormat:@"name: %@ userName: %@ password: %@ type: %d", _name, _userName, _password,_type];
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

-(void)save
{
    [_accountStorage saveAccount:self];
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

+(Account *) localAccount
{
    Account *account=[[Account alloc] init];
    account.type=Local;
    account.userName=@"local";
    account.password=@"local";
    account.name=@"local";
    account.taskStorage=[[[InMemoryTaskStorage alloc] init] autorelease];
    account.accountStorage=[[[InMemoryAccountStorage alloc] init] autorelease];
    return [account autorelease];
}

+(Account *) allAccount
{
    Account *account=[[Account alloc] init];
    account.type=All;
    account.userName=@"all";
    account.password=@"all";
    account.name=@"all";
    return [account autorelease];
}


+(Account *) googleAccount
{
    Account *account=[[Account alloc] init];
    account.type=Google;
    account.userName=@"hieu.bui";
    account.password=@"tobefilledinlater";
    account.name=@"hieu.bui@gmail.com";
    account.taskStorage=[[[NetworkTaskStorage alloc] init] autorelease];
    account.accountStorage=[[[InMemoryAccountStorage alloc] init] autorelease];
    return [account autorelease];    
}

@end
