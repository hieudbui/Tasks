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


@implementation TaskList

@synthesize name=_name;
@synthesize account=_account;
@synthesize tasks=_tasks;

-(void) addTask:(Task *)task
{
    if(_tasks == nil) {
        NSLog(@"tasks is nil. initialize to empty");
        self.tasks=[NSMutableArray arrayWithObjects:nil]; 
    }
    task.taskList=self;
    [_tasks addObject:task];
    
}
-(void) dealloc
{
    [_account release];
    [_name release];
    [_tasks release];
    [super dealloc];
}
@end
