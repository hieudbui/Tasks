//
//  ClearTasksDelegate.h
//  Tasks
//
//  Created by Hieu Bui on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ClearTasksDelegate <NSObject>

- (void) clearTasks:(BOOL)actionFlag;
@end
