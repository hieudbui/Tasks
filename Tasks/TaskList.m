//
//  TaskList.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskList.h"
#import "Account.h"
#import "Task.h"
#import "TaskStorage.h"


@implementation TaskList

@synthesize taskListId=_taskListId;
@synthesize name=_name;
@synthesize account=_account;
@synthesize tasks=_tasks;
@synthesize new=_new;
@synthesize taskStorage=_taskStorage;


-(TaskList *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
    }
    return self;
}


-(void) addTask:(Task *)task
{
    if(_tasks == nil) {
        NSLog(@"tasks is nil. initialize to empty");
        self.tasks=[NSMutableArray arrayWithObjects:nil]; 
    }
    task.taskList=self;
    [(NSMutableArray *)_tasks addObject:task];
    
}

-(void) save
{
    [self.taskStorage saveTaskList:self forAccount:self.account];
    self.new=NO;
}


-(NSString *) description {
    return [NSString stringWithFormat:@"taskListId: %@ name: new: %i", _taskListId, _name, _new];
}


-(void) dealloc
{
    [_taskListId release];
    [_account release];
    [_name release];
    [_tasks release];
    [_taskStorage release];
    [super dealloc];
}
@end
