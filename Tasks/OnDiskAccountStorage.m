//
//  OnDiskAccountStorage.m
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnDiskAccountStorage.h"
#import "Account.h"

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
        
    }
    return self;
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
