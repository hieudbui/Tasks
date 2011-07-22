//
//  OnDiskTaskStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnDiskTaskStorage.h"
#import "TaskList.h"
#import "Account.h"
#import "DiskStorage.h"

#define kTaskListsKey  @"TaskLists"
#define kTasksKey       @"Tasks"

#define kTaskListFile       @"taskLists.plist"


@implementation OnDiskTaskStorage


- (NSString *) taskListsDataFilePath
{
    return [[DiskStorage tasksPath] stringByAppendingPathComponent:kTaskListFile];
    //return [[NSBundle mainBundle] pathForResource:@"taskLists" ofType:@"plist"];
}

- (OnDiskTaskStorage *) init
{
    self=[super init];
    if(self) {
        NSString *filePath = [self taskListsDataFilePath];
        NSLog(@"OnDiskTaskStorage filePath: %@",filePath);
        NSData *taskListsData = [NSData dataWithContentsOfFile:filePath]; 
        if (taskListsData != nil) {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:taskListsData];
            id data = [unarchiver decodeObjectForKey:kTaskListsKey];  
            NSLog(@"OnDiskAccountStorage decodedData: %@", data);
            self.accountToTaskLists=data;
            [unarchiver finishDecoding];
            [unarchiver release];
        }
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

- (void) saveTask:(Task *)task forTaskList:(TaskList *)taskList
{
    [super saveTask:task forTaskList:taskList];
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
