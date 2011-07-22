//
//  OnDiskAccountStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnDiskAccountStorage.h"
#import "Account.h"
#import "DiskStorage.h"

#define kDataKey        @"Accounts"
#define kDataFile       @"account.plist"

@implementation OnDiskAccountStorage

@synthesize accounts=_accounts;


- (NSString *) accountsDataFilePath
{
    //return [[NSBundle mainBundle] pathForResource:@"accounts" ofType:@"json"];
    return [[NSBundle mainBundle] pathForResource:@"accounts" ofType:@"plist"];

}

- (OnDiskAccountStorage *) init
{
    if(self) {
        //NSString *path=[DiskStorage tasksPath];
        // NSLog(@"OnDiskAccountStorage path: %@", path);
        //NSString *dataPath = [path stringByAppendingPathComponent:kDataFile];
        //NSData *codedData = [[[NSData alloc] initWithContentsOfFile:dataPath] autorelease];
                
        _adapter = [[SBJsonStreamParserAdapter alloc] init];
        _adapter.delegate = self;
        _parser = [[SBJsonStreamParser alloc] init];
        _parser.delegate = _adapter;
        _parser.supportMultipleDocuments = YES;
        
        //HB
        //7-22-2011
        //Read data using JSON
        //SBJsonStreamParserStatus status = [_parser parse:accountsData];
        
        //if (status == SBJsonStreamParserError) {
        //	NSLog(@"Parser error: %@", _parser.error);
        //} else if (status == SBJsonStreamParserWaitingForData) {
        //    NSLog(@"Parser waiting for more data");
        //}
        
    }
    return self;
}

-(NSArray *) accounts
{
    if(_accounts==nil) {
        NSString *filePath = [self accountsDataFilePath];
        NSLog(@"ONDiskAccountStorage filePath: %@",filePath);
        NSData *accountsData = [NSData dataWithContentsOfFile:filePath]; 
        //HB
        //7-22-2011
        //Read data using plist
        if (accountsData != nil) {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:accountsData];
            id data = [unarchiver decodeObjectForKey:kDataKey];  
            NSLog(@"OnDiskAccountStorage decodedData: %@", data);
            self.accounts=data;
            [unarchiver finishDecoding];
            [unarchiver release];
            for(Account *account in self.accounts) {
                [self initializeStorage:account];
            }
        }
    }
    return _accounts;
}

- (void) writeToFile
{
    NSString *filePath = [self accountsDataFilePath];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];          
    [archiver encodeObject:self.accounts forKey:kDataKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
    [archiver release];
    [data release];    
}

-(void) removeAccount:(Account *)account
{
    [super removeAccount:account];
    [self writeToFile];
}

-(void)saveAccount:(Account *)account 
{
    [super saveAccount:account];
    [self writeToFile];
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
