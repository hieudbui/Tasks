//
//  ClearTasksViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClearTasksDelegate;

@interface ClearTasksViewController : UIViewController {
    
}


@property (nonatomic, retain) IBOutlet NSObject<ClearTasksDelegate> *delegate;

- (IBAction)clear:(id)sender;
- (IBAction)cancel:(id)sender;

@end
