//
//  AccountEditViewController.h
//  Tasks
//
//  Created by Hieu Bui on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditAccountComplete;
@class Account;

@interface AccountEditViewController : UIViewController {
    
}


@property (nonatomic, retain) Account *account;
@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UITextField *type;
@property (nonatomic, retain) IBOutlet UITextField *userName;
@property (nonatomic, retain) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet NSObject<EditAccountComplete> *delegate;

- (IBAction)save:(id)sender;

@end
