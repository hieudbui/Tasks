//
//  OnDiskAccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountStorage.h"
#import "SBJson.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@interface OnDiskAccountStorage : NSObject<AccountStorage,SBJsonStreamParserAdapterDelegate> {
    
    SBJsonStreamParser *_parser;
    SBJsonStreamParserAdapter *_adapter;
}

@property (nonatomic, retain) NSMutableArray *accounts;
@end
