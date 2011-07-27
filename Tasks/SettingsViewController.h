//
//  SettingsViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsCompleteDelegate;

@interface SettingsViewController : UIViewController

@property (nonatomic, retain) IBOutlet NSObject<SettingsCompleteDelegate> *delegate;

- (IBAction)save:(id)sender;

@end
