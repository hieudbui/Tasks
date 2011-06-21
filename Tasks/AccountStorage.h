//
//  AccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@protocol AccountStorage <NSObject>
- (NSArray *)getAccounts;
- (void)saveAccounts:(Account *)account;
@end
