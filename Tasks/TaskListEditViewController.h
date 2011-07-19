//
//  TaskListEditViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditListComplete;
@class TaskList;

@interface TaskListEditViewController : UIViewController {
    
}
@property (nonatomic, retain) TaskList *taskList;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet NSObject<EditListComplete> *delegate;

- (IBAction)save:(id)sender;

@end
