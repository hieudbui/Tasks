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
#import "Account.h"


@implementation InMemoryTaskStorage

@synthesize accountToTaskLists=_accountToTaskLists;
@synthesize taskListToTasks=_taskListToTasks;

- (InMemoryTaskStorage *) init
{
    self=[super init];
    
    if(self) {
        self.accountToTaskLists=[NSMutableDictionary dictionary];
        self.taskListToTasks=[NSMutableDictionary dictionary];
    }
    
    return self;
}

- (NSArray *)tasksForTaskList:(TaskList *)taskList
{
    NSMutableArray *tasks= [self.taskListToTasks valueForKey:taskList.taskListId];
    if(tasks==nil) {
        tasks=[NSMutableArray arrayWithObjects:nil];
        [self.taskListToTasks setValue:tasks forKey:taskList.taskListId];
        for(int j=0;j<5;j++) {
            Task *task=[[Task alloc] init ];
            task.taskId=[[NSProcessInfo processInfo] globallyUniqueString];
            NSString *taskName=@"task";
            task.taskStorage=self;
            task.dueDate=[NSDate date];
            task.taskList=taskList;
            task.name=[taskName stringByAppendingFormat:@"%i",j];
            if(j%2==0) {
                task.completed=YES;
            }
            task.new=NO;
            [tasks addObject:task];
            [task release];
        }
    }
    return tasks;
    
}

- (NSArray *)getTaskListsForAccount:(Account *)account
{
    NSMutableArray *taskLists=[self.accountToTaskLists valueForKey:account.accountId];
    
    if(taskLists==nil) {
        taskLists=[NSMutableArray arrayWithObjects:nil];
        [self.accountToTaskLists setValue:taskLists forKey:account.accountId];
        for(int i=0;i<5;i++) {
            TaskList *taskList=[[TaskList alloc] init];
            NSString *taskListName=@"taskList";
            taskList.name=[taskListName stringByAppendingFormat:@"%i",i];
            taskList.taskListId=[[NSProcessInfo processInfo] globallyUniqueString];
            taskList.account=account;
            taskList.taskStorage=self;
            taskList.new=NO;
            [taskLists addObject:taskList];
            [taskList release];
        }
    }
    return taskLists;
}

- (void) saveTask:(Task *)task forTaskList:(TaskList *)taskList
{
    NSLog(@"InMemoryTaskStorage Save task: %@",task);
    if(task.new) {
        [((NSMutableArray *)[self tasksForTaskList:taskList]) addObject:task];
    }
}

- (void) removeTask:(Task *)task forTaskList:(TaskList *)taskList
{
    NSLog(@"InMemoryTaskStorage removeTask: %@ forTaskList: %@\n",task,taskList);  
    NSMutableArray *tasks=(NSMutableArray *)[self tasksForTaskList:taskList];
    [tasks removeObject:task];
}

- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"InMemoryTaskStorage removeTaskList: %@ forAccount: %@\n",taskList,account);
    NSMutableArray *taskLists=(NSMutableArray *)[self getTaskListsForAccount:account];
    [taskLists removeObject:taskList];
}

- (void) addTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"InMemoryTaskStorage addTaskList: %@ forAccount: %@\n",taskList, account);
    NSMutableArray *taskLists=(NSMutableArray *)[self getTaskListsForAccount:account];
    [taskLists addObject:taskList];
    
}

- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    if(taskList.new) {
        NSMutableArray *taskLists=(NSMutableArray *)[self getTaskListsForAccount:account];
        [taskLists addObject:taskList];
    }
}

- (void) dealloc
{
    [_accountToTaskLists release];
    [_taskListToTasks release];
    [super dealloc];
}

@end
