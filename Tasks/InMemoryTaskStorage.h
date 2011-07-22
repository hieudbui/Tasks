//
//  InMemoryTaskStorage.h
//  Tasks
//
//  Created by Hieu Bui on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskStorage.h"
#import "TaskListStorage.h"

@interface InMemoryTaskStorage : NSObject<TaskStorage, TaskListStorage> {
}

@property (nonatomic, retain) NSDictionary *accountToTaskLists;
@property (nonatomic, retain) NSDictionary *taskListToTasks;


@end
