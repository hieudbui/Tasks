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

- (InMemoryTaskStorage *) init
{
    self=[super init];
    
    if(self) {
        self.accountToTaskLists=[NSMutableDictionary dictionary];
    }
    
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

- (NSMutableArray *)getTaskListsForAccount:(Account *)account {
    return [self.accountToTaskLists valueForKey:account.accountId];
}

- (NSArray *)getAllTaskListsForAccount:(Account *)account
{
    NSMutableArray *taskLists=[self getTaskListsForAccount:account];
    
    if(taskLists==nil) {
        taskLists=[NSMutableArray arrayWithObjects:nil];
        [self.accountToTaskLists setValue:taskLists forKey:account.accountId];
        
        
        for(int i=0;i<5;i++) {
            TaskList *taskList=[[TaskList alloc] init];
            NSString *taskListName=@"taskList";
            taskList.name=[taskListName stringByAppendingFormat:@"%i",i];
            taskList.taskListId=[[NSProcessInfo processInfo] globallyUniqueString];
            taskList.account=account;
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
    }
    return taskLists;
}

- (void) saveTask:(Task *)task
{
    NSLog(@"InMemoryTaskStorage Save task: %@",task);
}

- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"InMemoryTaskStorage removeTaskList: %@ forAccount: %@\n",taskList,account);
    NSMutableArray *taskLists=[self getTaskListsForAccount:account];
    [taskLists removeObject:taskList];
}

- (void) addTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    NSLog(@"InMemoryTaskStorage addTaskList: %@ forAccount: %@\n",taskList, account);
    NSMutableArray *taskLists=[self getTaskListsForAccount:account];
    [taskLists addObject:taskList];
    
}

- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    if(taskList.new) {
        NSMutableArray *taskLists=[self getTaskListsForAccount:account];
        [taskLists addObject:taskList];
    }
}

- (void) dealloc
{
    [_accountToTaskLists release];
    [super dealloc];
}

@end
