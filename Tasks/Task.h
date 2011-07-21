//
//  Task.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskList;
@protocol TaskStorage;

@interface Task : NSObject {
    
}

@property(nonatomic,retain) NSString *taskId;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *note;
@property(nonatomic,retain) NSDate *dueDate;
@property(nonatomic,retain) TaskList *taskList;
@property(nonatomic) BOOL completed;
@property (nonatomic) BOOL new;
@property(nonatomic,retain) NSObject<TaskStorage> *taskStorage;

-(void)save;
@end
