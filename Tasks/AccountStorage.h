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
- (void)saveAccount:(Account *)account;
- (void)removeAccount:(Account *)account;
- (NSArray *)accounts;
- (Account *)newAccount;
- (Account *) allAccount;
@end
