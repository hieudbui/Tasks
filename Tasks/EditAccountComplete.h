//
//  EditAccountComplete.h
//  Tasks
//
//  Created by Hieu Bui on 7/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@protocol EditAccountComplete <NSObject>

- (void) saveComplete:(Account *)account;
@end
