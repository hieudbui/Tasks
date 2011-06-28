//
//  TaskTests.m
//  Tasks
//
//  Created by Hieu Bui on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskTests.h"

#import "Task.h"
#import "TaskList.h"

@implementation TaskTests

- (void)setUp
{
    
    _task=[[Task alloc] init ];
    [super setUp];
}

- (void)tearDown
{
    [_task release];
    [super tearDown];
}

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void)testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void)testTask {
    _task.name=@"name";
    _task.note=@"note";
    _task.dueDate=[NSDate dateWithTimeIntervalSinceNow:0];
    
    TaskList *taskList=[[TaskList alloc] init];
    _task.taskList=taskList;
    
    NSLog(@"task=%@",_task);
    
    [taskList release];
}

#endif

@end
