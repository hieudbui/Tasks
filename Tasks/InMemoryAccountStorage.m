//
//  InMemoryAccountStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InMemoryAccountStorage.h"
#import "Account.h"
#import "InMemoryTaskStorage.h"

@implementation InMemoryAccountStorage

@synthesize accounts=_accounts;
@synthesize taskStorage=_taskStorage;
@synthesize taskListStorage=_taskListStorage;

- (InMemoryAccountStorage *) init
{
    self=[super init];
    if(self) {
    }
    return self;
}

-(void) initializeStorage:(Account *)account
{
    account.accountStorage=self;
    account.taskStorage=self.taskStorage;
    account.taskListStorage=self.taskListStorage;    
}

-(NSArray *) accounts
{
    if(_accounts==nil) {
        Account *localAccount=[self localAccount];
        Account *googleAccount=[self googleAccount];
        self.accounts=[[[NSMutableArray alloc] initWithObjects:localAccount, googleAccount, nil] autorelease];
    }
    return _accounts;
}

-(void) removeAccount:(Account *)account
{
    [self.accounts removeObject:account];
}

-(Account *)newAccount
{
    Account *account=[[[Account alloc] init] autorelease];
    account.accountId=[[NSProcessInfo processInfo] globallyUniqueString];
    [self initializeStorage:account];
    return account;
}

-(void)saveAccount:(Account *)account 
{
    NSLog(@"InMemoryAccountStorage save account: %@\n", account);
    if(account.new) {
        [self.accounts addObject:account]; 
    }
    NSLog(@"AccountStorage accounts:%@\n",self.accounts);
}


- (Account *) localAccount
{
    Account *account=[self newAccount];
    account.type=Local;
    account.userName=@"local2";
    account.password=@"local2";
    account.name=@"local";
    account.new=NO;
    return account;
}

- (Account *) allAccount
{
    Account *account=[self newAccount];
    account.type=All;
    account.userName=@"all";
    account.password=@"all";
    account.name=@"all";
    account.new=NO;
    return account;
}


- (Account *) googleAccount
{
    Account *account=[self newAccount];
    account.type=Google;
    account.userName=@"hieu.bui";
    account.password=@"tobefilledinlater";
    account.name=@"hieu.bui@gmail.com";
    account.new=NO;
    return account;
}

-(void) dealloc
{
    [_accounts release];
    [_taskStorage release];
    [_taskListStorage release];
    [super dealloc];
}

@end
