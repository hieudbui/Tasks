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


+(NSArray *)getAccounts
{
    Account *localAccount=Account.localAccount;
    Account *googleAccount=Account.googleAccount;
    return [[[NSMutableArray alloc] initWithObjects:localAccount, googleAccount, nil] autorelease]; 
}

- (void)saveAccount:(Account *)account 
{
    NSLog(@"Save account");
}

-(void) dealloc
{
    [super dealloc];
}

@end
