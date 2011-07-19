//
//  EditListComplete.h
//  Tasks
//
//  Created by Hieu Bui on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

;
@class TaskList;


@protocol EditListComplete <NSObject>

- (void) saveComplete:(TaskList *)account;

@end
