//
//  InMemoryAccountStorage.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InMemoryAccountStorage.h"
#import "Account.h"

@implementation InMemoryAccountStorage

-(id) init
{   
    Account *localAccount=Account.localAccount;
    Account *googleAccount=Account.googleAccount;
    NSMutableArray *accounts=[[NSMutableArray alloc] initWithObjects:localAccount, googleAccount, nil];
    [self initWithAccounts:accounts];
    [accounts release];
    return self;
}

-(InMemoryAccountStorage *) initWithAccounts:(NSArray *) accounts
{
    self=[super init];
    if(self) {
        [self setAccounts:accounts];
    }
    return self;
}

- (NSArray *)getAccounts
{
    NSLog(@"getAccounts called");
    return _accounts;
}

-(void) setAccounts:(NSArray *)accounts 
{
    [_accounts release];
    [accounts retain];
    _accounts=accounts;
}

- (void)saveAccounts:(Account *)account 
{
    
}

-(void) dealloc
{
    [_accounts dealloc];
    [super dealloc];
}

@end
