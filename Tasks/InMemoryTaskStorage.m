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
        
        for(int j=0;j<20;j++) {
            Task *task=[[Task alloc] init ];
            NSString *taskName=@"task";
            task.taskStorage=self;
            task.dueDate=[NSDate date];
            task.name=[taskName stringByAppendingFormat:@"%i%i",i,j];
            if(j%2==0) {
                task.completed=true;
            }
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
    NSLog(@"InMemoryTaskStorage Save task: %@",task);
}

- (void) removeTaskList:(TaskList *)taskList
{
    NSLog(@"InMemoryTaskStorage removeTaskList: %@\n",taskList);
}

- (void) addTaskList:(TaskList *)taskList
{
    NSLog(@"InMemoryTaskStorage addTaskList: %@\n",taskList);
}
@end
