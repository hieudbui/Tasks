//
//  RemoveTaskViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RemoveTaskDelegate;
@class Task;

@interface RemoveTaskViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet NSObject<RemoveTaskDelegate> *delegate;
@property (nonatomic, retain) Task *task;

- (IBAction)remove:(id)sender;
- (IBAction)cancel:(id)sender;


@end
