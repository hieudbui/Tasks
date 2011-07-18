//
//  RootViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditAccountComplete.h"

@class DetailViewController;
@class TaskListsViewController;
@class AccountEditViewController;
@protocol AccountStorage;

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EditAccountComplete> {
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet TaskListsViewController *taskListsViewController;
@property (nonatomic, retain) IBOutlet AccountEditViewController *accountEditViewController;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *accounts;
@property(nonatomic,retain) IBOutlet NSObject<AccountStorage> *accountStorage;
@end
