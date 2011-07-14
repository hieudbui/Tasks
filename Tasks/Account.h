//
//  Account.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskStorage;
@protocol AccountStorage;
@class TaskList;

typedef enum {
    Local=0,
    Google=1,
    All=3
} AccountType;

@interface Account : NSObject {
    
}

+(Account *) localAccount;
+(Account *) googleAccount;
+(Account *) allAccount;

@property AccountType type;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSString *name;
@property(readwrite,nonatomic,retain) NSArray *taskLists;
-(void) removeTaskList:(TaskList *)taskList;
-(void) addTaskList:(TaskList *)taskList;
-(void) save;
@property(nonatomic,retain) NSObject<TaskStorage> *taskStorage;
@property(nonatomic,retain) NSObject<AccountStorage> *accountStorage;


@end
