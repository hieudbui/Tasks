//
//  InMemoryAccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountStorage.h"

@interface InMemoryAccountStorage : NSObject<AccountStorage> {
    NSArray *_accounts;
}

-(void) setAccounts:(NSArray *)accounts;
-(InMemoryAccountStorage *) initWithAccounts:(NSArray *) accounts;
@end
