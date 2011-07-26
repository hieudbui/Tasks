//
//  TasksViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClearTasksDelegate.h"
#import "TaskEditComplete.h"
#import "RemoveTaskDelegate.h"

@class TaskCell;
@class TaskEditViewController;
@class ClearTasksViewController;
@class RemoveTaskViewController;
@class TaskList;

@interface TasksViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource,
    ClearTasksDelegate,TaskEditComplete,UIGestureRecognizerDelegate, RemoveTaskDelegate> {
    
}
- (IBAction) checkButtonTapped:(id)sender event:(id)event;


@property (nonatomic, retain) IBOutlet TaskEditViewController *taskEditViewController;
@property (nonatomic, retain) IBOutlet ClearTasksViewController *clearTasksViewController;
@property (nonatomic, retain) IBOutlet RemoveTaskViewController *removeTaskViewController;
@property (nonatomic, retain) UIPopoverController *clearTasksPopoverController;
@property (nonatomic, retain) UIPopoverController *addTaskPopoverController;
@property (nonatomic, retain) UIPopoverController *editTaskPopoverController;
@property (nonatomic, retain) UIPopoverController *removeTaskPopoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet TaskCell *taskCell;
@property (nonatomic, retain) TaskList *taskList;

- (IBAction)add:(id)sender;
- (IBAction)clear:(id)sender;
@end

