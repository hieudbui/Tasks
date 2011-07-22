//
//  OnDiskTaskStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnDiskTaskStorage.h"
#import "TaskList.h"
#import "Task.h"
#import "Account.h"
#import "DiskStorage.h"

#define kTaskListsKey  @"TaskLists"
#define kTasksKey       @"Tasks"
#define kTaskListsFile       @"taskLists.plist"
#define kTasksFile       @"tasks.plist"

@implementation OnDiskTaskStorage


- (NSString *) taskListsDataFilePath
{
    return [[DiskStorage tasksPath] stringByAppendingPathComponent:kTaskListsFile];
}


- (NSString *) tasksDataFilePath
{
    return [[DiskStorage tasksPath] stringByAppendingPathComponent:kTasksFile];
}

- (void) loadTaskListsData 
{
    NSString *taskListsDataFilePath = [self taskListsDataFilePath];
    NSLog(@"OnDiskTaskStorage taskListsDataFilePath: %@",taskListsDataFilePath);
    NSData *taskListsData = [NSData dataWithContentsOfFile:taskListsDataFilePath]; 
    if (taskListsData != nil) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:taskListsData];
        id data = [unarchiver decodeObjectForKey:kTaskListsKey];  
        NSLog(@"OnDiskAccountStorage taskListData: %@", data);
        self.accountToTaskLists=data;
        [unarchiver finishDecoding];
        [unarchiver release];
    }    
}

- (void) loadTasksData 
{
    NSString *tasksDataFilePath = [self tasksDataFilePath];
    NSLog(@"OnDiskTaskStorage tasksDataFilePath: %@",tasksDataFilePath);
    NSData *tasksData = [NSData dataWithContentsOfFile:tasksDataFilePath]; 
    if (tasksData != nil) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:tasksData];
        id data = [unarchiver decodeObjectForKey:kTasksKey];  
        NSLog(@"OnDiskAccountStorage tasksData: %@", data);
        self.taskListToTasks=data;
        [unarchiver finishDecoding];
        [unarchiver release];
    }    
}


- (OnDiskTaskStorage *) init
{
    self=[super init];
    if(self) {
        [self loadTaskListsData];
        [self loadTasksData];
    }
    
    return self;
}

- (NSArray *)getTaskListsForAccount:(Account *)account
{
    NSMutableArray *taskLists=[self.accountToTaskLists valueForKey:account.accountId];
    if(taskLists==nil) {
        taskLists=[NSMutableArray arrayWithObjects:nil];
        [self.accountToTaskLists setValue:taskLists forKey:account.accountId];
    }
    else {
        for(TaskList *taskList in taskLists) {
            taskList.taskListStorage=self;
            taskList.taskStorage=self;
        }
    }
    return taskLists;
}

- (NSArray *)tasksForTaskList:(TaskList *)taskList
{
    NSMutableArray *tasks=[self.taskListToTasks valueForKey:taskList.taskListId];
    if(tasks==nil) {
        tasks=[NSMutableArray arrayWithObjects:nil];
        [self.taskListToTasks setValue:tasks forKey:taskList.taskListId];
    }
    else {
        for(Task *task in tasks) {
            task.taskStorage=self;
        }
    }
    return tasks;    
}

- (void) writeTaskListsToFile
{
    NSString *filePath = [self taskListsDataFilePath];
    NSLog(@"OnDiskTaskStorage writeTaskListsToFile: %@",filePath);
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];          
    [archiver encodeObject:self.accountToTaskLists forKey:kTaskListsKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    [archiver release];
    [data release];    
}


- (void) writeTasksToFile
{
    NSString *filePath = [self tasksDataFilePath];
    NSLog(@"OnDiskTaskStorage writeTasksToFile: %@",filePath);
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];          
    [archiver encodeObject:self.taskListToTasks forKey:kTasksKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    [archiver release];
    [data release];    
}


- (void) saveTask:(Task *)task forTaskList:(TaskList *)taskList
{
    [super saveTask:task forTaskList:taskList];
    [self writeTasksToFile];
}

- (void) removeTask:(Task *)task forTaskList:(TaskList *)taskList
{
    [super removeTask:task forTaskList:taskList];
    [self writeTasksToFile];
}

- (void) saveTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    [super saveTaskList:taskList forAccount:account];
    [self writeTaskListsToFile];
}

- (void) removeTaskList:(TaskList *)taskList forAccount:(Account *)account
{
    [super removeTaskList:taskList forAccount:account];
    [self writeTaskListsToFile];
}


- (void) dealloc
{
    [super dealloc];
}

@end
