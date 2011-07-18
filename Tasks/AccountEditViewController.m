//
//  AccountEditViewController.m
//  Tasks
//
//  Created by Hieu Bui on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AccountEditViewController.h"
#import "EditAccountComplete.h"
#import "Account.h"


@implementation AccountEditViewController

@synthesize account=_account;
@synthesize name=_name;
@synthesize type=_type;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setAccount:(Account *)account
{
    if(_account!=account) {
        [_account release];
        [account retain];
        _account=account;
    }
    NSLog(@"AccountEditViewController setAccount: %@\n",_account);
    self.name.text=_account.name;
    self.userName.text=_account.userName;
    self.password.text=_account.password;
    //self.type.text=_account.type;
}


- (IBAction)save:(id)sender
{
    NSLog(@"AccountEditViewController save");
    self.account.name=self.name.text;
    self.account.userName=self.userName.text;
    self.account.password=self.password.text;
    //self.account.type=self.type.text;
    [self.account save];
    [self.delegate saveComplete:self.account];
}

- (void)dealloc
{
    [_account release];
    [_name release];
    [_type release];
    [_userName release];
    [_password release];
    [_delegate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
