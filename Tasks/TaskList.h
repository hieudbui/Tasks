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

@interface TaskList : NSObject {
}

-(void) addTask:(Task *)task;
-(void) remove;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) Account *account;
@property(nonatomic,retain) NSArray *tasks;

@end
