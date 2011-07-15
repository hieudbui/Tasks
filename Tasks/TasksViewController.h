//
//  TasksViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskCell;

@interface TasksViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    
}
- (IBAction) checkButtonTapped:(id)sender event:(id)event;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet TaskCell *taskCell;
@property (nonatomic, retain) id detailItem;

@end

