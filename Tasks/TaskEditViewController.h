//
//  TaskEditViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskEditComplete.h"

@class Task;

@interface TaskEditViewController : UIViewController {
    
}


@property (nonatomic, retain) IBOutlet NSObject<TaskEditComplete> *delegate;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *dueDate;
@property (nonatomic, retain) Task *task;


- (IBAction)save:(id)sender;

@end
