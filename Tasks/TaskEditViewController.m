//
//  TaskEditViewController.m
//  Tasks
//
//  Created by Hieu Bui on 7/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskEditViewController.h"
#import "Task.h"
#import "TaskEditComplete.h"

@implementation TaskEditViewController

@synthesize task=_task;
@synthesize name=_name;
@synthesize dueDate=_dueDate;
@synthesize delegate=_delegate;

- (IBAction)save:(id)sender
{
    self.task.name=self.name.text;
    self.task.dueDate=[NSDate date];
    [self.name resignFirstResponder];
    [self.dueDate resignFirstResponder];
    [self.delegate saveComplete:self.task];
    //TODO
    //need to do date assignment
    //self.task.dueDate=self.dueDate.text;
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
    [_name release];
    [_dueDate release];
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
    NSLog(@"TaskEditViewController viewDidUnload");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"TaskEditViewController viewDidDisappear");
	[super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"TaskEditViewController viewDidAppear");
    self.name.text=nil;
    self.dueDate.text=nil;
	[super viewDidAppear:animated];    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

@end
