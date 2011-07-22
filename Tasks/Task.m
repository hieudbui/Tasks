//
//  Task.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Task.h"
#import "TaskList.h"
#import "TaskStorage.h"


@implementation Task

@synthesize taskId=_taskId;
@synthesize name=_name;
@synthesize note=_note;
@synthesize dueDate=_dueDate;
@synthesize taskList=_taskList;
@synthesize completed=_completed;
@synthesize taskStorage=_taskStorage;
@synthesize new=_new;

-(Task *) init
{
    self=[super init];
    if(self) {
        self.new=YES;
    }
    return self;
}


-(NSString *) description {
    return [NSString stringWithFormat:
            @"id: %@, name: %@ note: %@ dueDate: %@ completed: %i new: %i created: %@ changed: %@ taskList: %@\n",
            _taskId, _name, _note,_dueDate,_completed,_new, _created, _changed, _taskList];
}

-(void)save
{
    if(self.new) {
        _created=[[NSDate date] retain];
    }
    _changed=[[NSDate date] retain];
    [self.taskStorage saveTask:self forTaskList:self.taskList];
    self.new=NO;
}

-(void) dealloc
{
    [_taskId release];
    [_name release];
    [_note release];
    [_dueDate release];
    [_taskList release];
    [_taskStorage release];
    [_changed release];
    [_created release];
    [super dealloc];
}

#pragma mark NSCoding

#define kTaskId         @"taskId"
#define kName           @"name"
#define kNote           @"note"
#define kDueDate        @"dueDate"
#define kNew            @"new"
#define kCompleted      @"completed"
#define kCreated        @"created"
#define kChanged        @"changed"

- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.taskId forKey:kTaskId];
    [encoder encodeObject:self.name forKey:kName];
    [encoder encodeObject:self.note forKey:kNote];
    [encoder encodeObject:self.dueDate forKey:kDueDate];
    [encoder encodeBool:self.new forKey:kNew];
    [encoder encodeBool:self.completed forKey:kCompleted];
    [encoder encodeObject:_created forKey:kCreated];
    [encoder encodeObject:_changed forKey:kChanged];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.taskId=[decoder decodeObjectForKey:kTaskId];
    self.name=[decoder decodeObjectForKey:kName];
    self.note=[decoder decodeObjectForKey:kNote];
    self.dueDate=[decoder decodeObjectForKey:kDueDate];
    self.new=[decoder decodeBoolForKey:kNew];
    self.completed=[decoder decodeBoolForKey:kCompleted];
    _created=[decoder decodeObjectForKey:kCreated];
    _changed=[decoder decodeObjectForKey:kChanged];
    return self;
}

@end
