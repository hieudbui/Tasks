//
//  InMemoryTaskStorage.m
//  Tasks
//
//  Created by Hieu Bui on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InMemoryTaskStorage.h"
#import "Task.h"
#import "TaskList.h"


@implementation InMemoryTaskStorage

- (NSArray *)getAllTasksForAccount:(Account *)account
{
    return nil;
}

- (NSArray *)getTasksForTaskList:(TaskList *)taskList
{
    return nil;
}

- (NSArray *)getAllTaskListsForAccount:(Account *)account
{
    NSMutableArray *taskLists=[NSMutableArray arrayWithObjects:nil];
    
    for(int i=0;i<5;i++) {
        TaskList *taskList=[[TaskList alloc] init];
        NSString *taskListName=@"taskList";
        taskList.name=[taskListName stringByAppendingFormat:@"%i",i];
        
        for(int j=0;j<10;j++) {
            Task *task=[[Task alloc] init ];
            NSString *taskName=@"task";
            task.name=[taskName stringByAppendingFormat:@"%i%i",i,j];
            [taskList addTask: task];
            [task release];
            
        }
        [taskLists addObject:taskList];
        [taskList release];
    }
    return taskLists;
}

- (void) saveTask:(Task *)task
{
    
}


@end
