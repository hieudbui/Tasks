//
//  NetworkTaskStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NetworkTaskStorage.h"
#import "Task.h"
#import "TaskList.h"

@implementation NetworkTaskStorage


-(id) init
{   
    self =[super init];
    return self;
}
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
    NSLog(@"NetWorkTaskStorage Save task: %@",task);
}

- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    
}

- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"NetWorkTaskStorage removeTaskList: %@\n",taskList);
}

- (void) addTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"NetWorkTaskStorage addTaskList: %@ forAccount: %@\n",taskList,account);
}

@end
