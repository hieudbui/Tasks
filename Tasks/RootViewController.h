//
//  RootViewController.h
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {

}

		
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) NSMutableArray *taskGroups;
@property (nonatomic, retain) IBOutlet UIToolbar *bottomToolbar;

@end
