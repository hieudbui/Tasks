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
#import "TaskStorage.h"
#import "TaskListStorage.h"


@implementation TaskList

@synthesize taskListId=_taskListId;
@synthesize name=_name;
@synthesize account=_account;
@synthesize new=_new;
@synthesize taskStorage=_taskStorage;
@synthesize taskListStorage=_taskListStorage;


-(TaskList *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
        _completedTasks=[[NSMutableArray arrayWithObjects:nil] retain];
    }
    return self;
}

-(void) save
{
    if(self.new) {
        _created=[[NSDate date] retain];
    }
    _changed=[[NSDate date] retain];
    [self.taskListStorage saveTaskList:self forAccount:self.account];
    self.new=NO;
}

-(Task *)newTask
{
    Task *task=[[[Task alloc] init] autorelease];
    task.taskId=[[NSProcessInfo processInfo] globallyUniqueString];
    task.taskList=self;
    task.taskStorage=self.taskStorage;
    return task;
}

-(NSArray *)tasks
{
    return [self.taskStorage getTasksForTaskList:self];
}

-(void) clearCompletedTasks
{
    for(Task *task in self.tasks) {
        if(task.completed) {
            [_completedTasks addObject:task];
        }
    }
    
    for(Task *task in _completedTasks) {
        [((NSMutableArray *) self.tasks) removeObject:task];
    }
    
    NSLog(@"TaskList clearCompetedTasks: %@ tasks: %@\n",_completedTasks,self.tasks);
}


-(NSString *) description {
    return [NSString stringWithFormat:@"taskListId: %@ name: %@ new: %i created: %@ changed: %@", _taskListId, _name, _new, _created, _changed];
}


-(void) dealloc
{
    [_taskListId release];
    [_completedTasks release];
    [_account release];
    [_name release];
    [_taskStorage release];
    [_taskListStorage release];
    [_changed release];
    [_created release];
    [super dealloc];
}

#pragma mark NSCoding

#define kTaskListId     @"taskListId"
#define kName           @"name"
#define kNew            @"new"
#define kCreated        @"created"
#define kChanged        @"changed"

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.taskListId forKey:kTaskListId];
    [encoder encodeObject:self.name forKey:kName];
    [encoder encodeBool:self.new forKey:kNew];
    [encoder encodeObject:_created forKey:kCreated];
    [encoder encodeObject:_changed forKey:kChanged];
 
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.taskListId=[decoder decodeObjectForKey:kTaskListId];
    self.name=[decoder decodeObjectForKey:kName];
    self.new=[decoder decodeBoolForKey:kNew];
    _created=[[decoder decodeObjectForKey:kCreated] retain];
    _changed=[[decoder decodeObjectForKey:kChanged] retain];
    return self;
}

@end
