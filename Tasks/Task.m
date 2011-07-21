//
//  Task.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Task.h"
#import "TaskList.h"
#import "TaskStorage.h"


@implementation Task

@synthesize taskId=_taskId;
@synthesize name=_name;
@synthesize note=_note;
@synthesize dueDate=_dueDate;
@synthesize taskList=_taskList;
@synthesize completed=_completed;
@synthesize taskStorage=_taskStorage;
@synthesize new=_new;

-(Task *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
    }
    return self;
}


-(NSString *) description {
    return [NSString stringWithFormat:
            @"id: %@, name: %@ note: %@ dueDate: %@ completed: %i new: %i taskList: %@\n",
            _taskId, _name, _note,_dueDate,_completed,_new, _taskList];
}

-(void)save
{
    [self.taskStorage saveTask:self forTaskList:self.taskList];
    self.new=NO;
}

-(void) dealloc
{
    [_taskId release];
    [_name release];
    [_note release];
    [_dueDate release];
    [_taskList release];
    [_taskStorage release];
    [super dealloc];
}
@end
