//
//  TaskList.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskList.h"


@implementation TaskList

@synthesize name=_name;

-(void) dealloc
{
    [_name dealloc];
    [super dealloc];
}
@end
