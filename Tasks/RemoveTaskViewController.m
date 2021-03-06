//
//  RemoveTaskViewController.m
//  Tasks
//
//  Created by Hieu Bui on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoveTaskViewController.h"
#import "RemoveTaskDelegate.h"

@implementation RemoveTaskViewController

@synthesize delegate=_delegate;
@synthesize task=_task;

- (IBAction)remove:(id)sender
{
    [self.delegate removeTask:YES];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate removeTask:NO];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [_delegate release];
    [_task release];
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
