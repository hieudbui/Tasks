//
//  InMemoryAccountStorage.h
//  Tasks
//
//  Created by Hieu Bui on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountStorage.h"


@interface InMemoryAccountStorage : NSObject<AccountStorage> {
}

@property (nonatomic, retain) NSMutableArray *accounts;
@end
