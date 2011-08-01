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
@class SelectADateViewController;

@interface TaskEditViewController : UIViewController<UITextFieldDelegate> {
    
}


@property (nonatomic, retain) IBOutlet SelectADateViewController *selectADateViewController;
@property (nonatomic, retain) IBOutlet NSObject<TaskEditComplete> *delegate;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UIButton *dueDate;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) Task *task;


- (IBAction)selectDate:(id)sender;
- (IBAction)getDateSelection:(id)sender;
- (IBAction)save:(id)sender;

@end
