//
//  DetailViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskCell;

@interface DetailViewController : UIViewController 
<UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    UIViewController *_viewController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (IBAction) setViewController:(UIViewController *)viewController;
- (void) pushViewController:(UIViewController *)viewController;

@end
