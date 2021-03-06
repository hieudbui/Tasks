//
//  RootViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditAccountComplete.h"
#import "SettingsCompleteDelegate.h"

@class DetailViewController;
@class TaskListsViewController;
@class AccountEditViewController;
@class SettingsViewController;
@protocol AccountStorage;
@class GTMOAuthAuthentication;

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EditAccountComplete,SettingsCompleteDelegate> {
    
    GTMOAuthAuthentication *mAuth;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet TaskListsViewController *taskListsViewController;
@property (nonatomic, retain) IBOutlet AccountEditViewController *accountEditViewController;
@property (nonatomic, retain) IBOutlet SettingsViewController *settingsViewController;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolbar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *accounts;
@property(nonatomic,retain) IBOutlet NSObject<AccountStorage> *accountStorage;


- (void)setAuthentication:(GTMOAuthAuthentication *)auth;
- (IBAction)sync;
- (IBAction)settings;
@end
