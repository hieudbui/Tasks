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

-(NSString *) description {
    return [NSString stringWithFormat:@"userName: %@\npassword: %@\ntype: %d\n",_userName, _password,_type];
}

- (void)dealloc
{
    [_userName release];
    [_password release];
    _type=-1;
    [super dealloc];
}

+(Account *) localAccount
{
    Account *account=[[Account alloc] init];
    account.type=Local;
    account.userName=@"local";
    account.password=@"local";
    return [account autorelease];
}

+(Account *) googleAccount
{
    Account *account=[[Account alloc] init];
    account.type=Google;
    account.userName=@"Hieu.Bui";
    account.password=@"tobefilledinlater";
    return [account autorelease];    
}

@end
