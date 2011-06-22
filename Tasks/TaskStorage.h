//
//  NoteStorage.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;
@class Task;

@protocol TaskStorage <NSObject> 
- (NSArray *)getTasks:(Account *)account;
- (NSArray *)getTasks:(TaslList *)taskList:
- (NSArray *)getTaskList:(Account *)account;
- (void) saveTask:(Task *)task;
@end
