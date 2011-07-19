//
//  TaskListsViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditListComplete.h"

@class DetailViewController;
@class TasksViewController;
@class TaskListEditViewController;

@interface TaskListsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EditListComplete> {
}

@property (nonatomic, retain) DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet TasksViewController *tasksViewController;
@property (nonatomic, retain) IBOutlet TaskListEditViewController *taskListEditViewController;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolbar;
@property (nonatomic, retain) NSArray *accounts;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *accountsToTaskLists;
@end