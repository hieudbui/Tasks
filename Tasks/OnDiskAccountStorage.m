//
//  OnDiskAccountStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnDiskAccountStorage.h"
#import "Account.h"
#import "InMemoryTaskStorage.h"
#import "NetworkTaskStorage.h"

@implementation OnDiskAccountStorage

@synthesize accounts=_accounts;


- (NSString *) accountsDataFilePath
{
    return [[NSBundle mainBundle] pathForResource:@"accounts" ofType:@"json"];
}

- (OnDiskAccountStorage *) init
{
    self=[super init];
    if(self) {
        _adapter = [[SBJsonStreamParserAdapter alloc] init];
        _adapter.delegate = self;
        _parser = [[SBJsonStreamParser alloc] init];
        _parser.delegate = _adapter;
        _parser.supportMultipleDocuments = YES;
        
        NSString *filePath = [self accountsDataFilePath];
        NSData *accountsData = [NSData dataWithContentsOfFile:filePath];  
        SBJsonStreamParserStatus status = [_parser parse:accountsData];
        
        if (status == SBJsonStreamParserError) {
        	NSLog(@"Parser error: %@", _parser.error);
            
        } else if (status == SBJsonStreamParserWaitingForData) {
            NSLog(@"Parser waiting for more data");
        }
        
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
    account.accountId=[[NSProcessInfo processInfo] globallyUniqueString];
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
    account.accountId=[[NSProcessInfo processInfo] globallyUniqueString];
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
    account.accountId=[[NSProcessInfo processInfo] globallyUniqueString];
    account.type=Google;
    account.userName=@"hieu.bui";
    account.password=@"tobefilledinlater";
    account.name=@"hieu.bui@gmail.com";
    account.new=NO;
    account.accountStorage=self;
    account.taskStorage=[[[NetworkTaskStorage alloc] init] autorelease];
    return [account autorelease];    
}


#pragma mark SBJsonStreamParserAdapterDelegate methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
     NSLog(@"found object: %@\n",array);
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
    [NSException raise:@"unexpected" format:@"Should not get here"];
}


-(void) dealloc
{
    [_parser release];
    [_adapter release];
    [_accounts release];
    [super dealloc];
}


@end
