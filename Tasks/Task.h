//
//  Task.h
//  Tasks
//
//  Created by Hieu Bui on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Task : NSObject {
    
}

@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *note;
@property(nonatomic,retain) NSDate *dueDate;
@end
