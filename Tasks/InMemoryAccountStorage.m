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
#import "NetworkTaskStorage.h"

@implementation InMemoryAccountStorage

@synthesize accounts=_accounts;

- (InMemoryAccountStorage *) init
{
    self=[super init];
    if(self) {
        Account *localAccount=[self localAccount];
        Account *googleAccount=[self googleAccount];
        self.accounts=[[[NSMutableArray alloc] initWithObjects:localAccount, googleAccount, nil] autorelease];
    }
    return self;
}

-(NSArray *) getAccounts
{
    return self.accounts;
}

-(void) removeAccount:(Account *)account
{
    [_accounts removeObject:account];
}

-(Account *)newAccount
{
    Account *account=[[[Account alloc] init] autorelease];
    account.accountStorage=self;
    account.taskStorage=[[[InMemoryTaskStorage alloc] init] autorelease];
    return account;
}

-(void)saveAccount:(Account *)account 
{
    NSLog(@"Save account: %@\n", account);
    if(account.new) {
        [_accounts addObject:account]; 
    }
    NSLog(@"AccountStorage accounts:%@\n",_accounts);
}


- (Account *) localAccount
{
    Account *account=[[Account alloc] init];
    account.type=Local;
    account.userName=@"local";
    account.password=@"local";
    account.name=@"local";
    account.new=NO;
    account.accountStorage=self;
    account.taskStorage=[[[InMemoryTaskStorage alloc] init] autorelease];
    return [account autorelease];
}

- (Account *) allAccount
{
    Account *account=[[Account alloc] init];
    account.type=All;
    account.userName=@"all";
    account.password=@"all";
    account.name=@"all";
    account.new=NO;
    account.accountStorage=self;
    return [account autorelease];
}


- (Account *) googleAccount
{
    Account *account=[[Account alloc] init];
    account.type=Google;
    account.userName=@"hieu.bui";
    account.password=@"tobefilledinlater";
    account.name=@"hieu.bui@gmail.com";
    account.new=NO;
    account.accountStorage=self;
    account.taskStorage=[[[NetworkTaskStorage alloc] init] autorelease];
    return [account autorelease];    
}

-(void) dealloc
{
    [_accounts release];
    [super dealloc];
}

@end
