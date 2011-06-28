//
//  Task.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Task.h"
#import "TaskList.h"


@implementation Task

@synthesize name=_name;
@synthesize note=_note;
@synthesize dueDate=_dueDate;
@synthesize taskList=_taskList;

-(NSString *) description {
    return [NSString stringWithFormat:
            @"name: %@\nnote: %@\ndueDate: %@\ntaskList: %@\n",_name, _note,_dueDate, _taskList];
}

-(void) dealloc
{
    [_name release];
    [_note release];
    [_dueDate release];
    [_taskList release];
    [super dealloc];
}
@end
