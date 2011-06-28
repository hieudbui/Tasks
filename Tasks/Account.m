//
//  Account.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Account.h"


@implementation Account

@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize name=_name;
@synthesize taskLists=_taskLists;

-(NSString *) description {
    return [NSString stringWithFormat:@"name: %@ userName: %@ password: %@ type: %d", _name, _userName, _password,_type];
}

- (void)dealloc
{
    [_userName release];
    [_password release];
    [_name release];
    [_taskLists release];
    [super dealloc];
}

+(Account *) localAccount
{
    Account *account=[[Account alloc] init];
    account.type=Local;
    account.userName=@"local";
    account.password=@"local";
    account.name=@"local";
    return [account autorelease];
}

+(Account *) allAccount
{
    Account *account=[[Account alloc] init];
    account.type=All;
    account.userName=@"all";
    account.password=@"all";
    account.name=@"all";
    return [account autorelease];
}


+(Account *) googleAccount
{
    Account *account=[[Account alloc] init];
    account.type=Google;
    account.userName=@"hieu.bui";
    account.password=@"tobefilledinlater";
    account.name=@"hieu.bui@gmail.com";
    return [account autorelease];    
}

@end
