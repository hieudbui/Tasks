//
//  Task.m
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Task.h"


@implementation Task

@synthesize name=_name;
@synthesize note=_note;
@synthesize dueDate=_dueDate;

-(NSString *) description {
    return [NSString stringWithFormat:@"name: %@\nnote: %@\ndueDate: %@\n",_name, _note,_dueDate];
}

-(void) dealloc
{
    [_name release];
    [_note release];
    [_dueDate release];
    [super dealloc];
}
@end
