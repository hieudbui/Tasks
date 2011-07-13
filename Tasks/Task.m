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

@synthesize name=_name;
@synthesize note=_note;
@synthesize dueDate=_dueDate;
@synthesize taskList=_taskList;
@synthesize completed=_completed;
@synthesize taskStorage=_taskStorage;

-(NSString *) description {
    return [NSString stringWithFormat:
            @"name: %@\nnote: %@\ndueDate: %@\ncompleted: %i\ntaskList: %@\n",
            _name, _note,_dueDate,_completed,_taskList];
}

-(void)save
{
    [self.taskStorage saveTask:self];
}

-(void) dealloc
{
    [_name release];
    [_note release];
    [_dueDate release];
    [_taskList release];
    [_taskStorage release];
    [super dealloc];
}
@end
