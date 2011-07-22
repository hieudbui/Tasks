//
//  OnDiskAccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InMemoryAccountStorage.h"
#import "SBJson.h"

@class SBJsonStreamParser;
@class SBJsonStreamParserAdapter;

@interface OnDiskAccountStorage : InMemoryAccountStorage<SBJsonStreamParserAdapterDelegate> {
    
    SBJsonStreamParser *_parser;
    SBJsonStreamParserAdapter *_adapter;
}


@end
