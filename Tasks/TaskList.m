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
@synthesize new=_new;
@synthesize taskStorage=_taskStorage;


-(TaskList *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
        _completedTasks=[[NSMutableArray arrayWithObjects:nil] retain];
    }
    return self;
}

-(void) save
{
    [self.taskStorage saveTaskList:self forAccount:self.account];
    self.new=NO;
}

-(Task *)newTask
{
    Task *task=[[[Task alloc] init] autorelease];
    task.taskId=[[NSProcessInfo processInfo] globallyUniqueString];
    task.taskList=self;
    task.taskStorage=self.taskStorage;
    return task;
}

-(NSArray *)tasks
{
    return [self.taskStorage getTasksForTaskList:self];
}

-(void) clearCompletedTasks
{
    for(Task *task in self.tasks) {
        if(task.completed) {
            [_completedTasks addObject:task];
        }
    }
    
    for(Task *task in _completedTasks) {
        [((NSMutableArray *) self.tasks) removeObject:task];
    }
    
    NSLog(@"TaskList clearCompetedTasks: %@ tasks: %@\n",_completedTasks,self.tasks);
}


-(NSString *) description {
    return [NSString stringWithFormat:@"taskListId: %@ name: %@ new: %i", _taskListId, _name, _new];
}


-(void) dealloc
{
    [_taskListId release];
    [_completedTasks release];
    [_account release];
    [_name release];
    [_taskStorage release];
    [super dealloc];
}
@end
