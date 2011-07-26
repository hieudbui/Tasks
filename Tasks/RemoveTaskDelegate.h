//
//  RemoveTaskDelegate.h
//  Tasks
//
//  Created by Hieu Bui on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RemoveTaskDelegate <NSObject>

- (void) removeTask:(BOOL)actionFlag;

@end
