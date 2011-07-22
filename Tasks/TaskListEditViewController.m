//
//  TaskListEditViewController.m
//  Tasks
//
//  Created by Hieu Bui on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TaskListEditViewController.h"
#import "TaskList.h"
#import "EditTaskListComplete.h"

@implementation TaskListEditViewController

@synthesize name=_name;
@synthesize taskList=_taskList;
@synthesize delegate=_delegate;

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
    [_name release];
    [_taskList release];
    [_delegate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)save:(id)sender
{
    NSLog(@"TaskListEditViewController save");
    self.taskList.name=self.name.text;
    [self.taskList save];
    [self.delegate saveComplete:self.taskList];
}


- (void) setTaskList:(TaskList *)taskList
{
    if(_taskList!=taskList) {
        [_taskList release];
        [taskList retain];
        _taskList=taskList;
    }
    NSLog(@"TaskListEditViewController setTaskList: %@\n",_taskList);
    self.name.text=_taskList.name;
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
