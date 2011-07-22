//
//  InMemoryAccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountStorage.h"

@protocol TaskStorage;
@protocol TaskListStorage;

@interface InMemoryAccountStorage : NSObject<AccountStorage> {
}

@property (nonatomic, retain) NSMutableArray *accounts;

- (Account *) localAccount;
- (Account *) googleAccount;
- (void) initializeStorage:(Account *)account;


@property(nonatomic,retain) IBOutlet NSObject<TaskListStorage> *taskListStorage;
@property(nonatomic,retain) IBOutlet NSObject<TaskStorage> *taskStorage;

@end
