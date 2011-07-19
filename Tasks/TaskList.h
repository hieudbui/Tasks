//
//  TaskList.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class Task;
@protocol TaskStorage;

@interface TaskList : NSObject {
}

-(void) addTask:(Task *)task;
-(void) save;

@property(nonatomic,retain) NSString *taskListId;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) Account *account;
@property(nonatomic,retain) NSArray *tasks;
@property (nonatomic) BOOL new;
@property(nonatomic,retain) NSObject<TaskStorage> *taskStorage;

@end
