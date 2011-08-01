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
#import "SelectADateViewController.h"

@implementation TaskEditViewController

@synthesize task=_task;
@synthesize name=_name;
@synthesize datePicker=_datePicker;
@synthesize dueDate=_dueDate;
@synthesize delegate=_delegate;
@synthesize selectADateViewController=_selectADateViewController;


- (void) animateDatePicker:(int)yIndex;
{
    CGRect datePickerFrame=self.datePicker.frame;
    NSLog(@"datePickerFrame %@",NSStringFromCGRect(datePickerFrame));
    datePickerFrame.origin.y=yIndex;
    NSLog(@"datePickerFrame after change %@",NSStringFromCGRect(datePickerFrame));
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    self.datePicker.frame=datePickerFrame;
    
    [UIView commitAnimations];    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing");
    [self animateDatePicker:self.view.bounds.size.height];
    return YES;
}

- (IBAction)getDateSelection:(id)sender
{
    NSLog(@"getDateSelection");
    NSDate *pickerDate = [self.datePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:pickerDate];
    self.dueDate.titleLabel.text = dateString;
    [dateFormat release];
   
}

- (IBAction)selectDate:(id)sender
{
    NSLog(@"selectDate");
    if(self.task.dueDate!=nil) {
        self.datePicker.date=self.task.dueDate;
    }
    else {
        self.task.dueDate=[NSDate date];
        self.datePicker.date=self.task.dueDate;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];	
        [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
        NSString *dateString = [dateFormat stringFromDate:self.task.dueDate];
        [self.dueDate setTitle:dateString forState:UIControlStateNormal];
        [dateFormat release];
    }
    [self.name resignFirstResponder];
    [self animateDatePicker:164];
    //[self.datePicker setNeedsDisplay];
    //self.selectADateViewController.modalPresentationStyle=UIModalPresentationPageSheet;
    //[self.parentViewController presentModalViewController:self.selectADateViewController animated:YES]; 
}

- (IBAction)save:(id)sender
{
    self.task.name=self.name.text;
    self.task.dueDate=[NSDate date];
    [self.name resignFirstResponder];
    [self.dueDate resignFirstResponder];
    [self.delegate saveComplete:self.task];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSDate *date = [dateFormat dateFromString:self.dueDate.titleLabel.text]; 
    if(date==nil) {
        date=[NSDate date];
    }
    self.task.dueDate=date;
    [dateFormat release];
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
    [_datePicker release];
    [_dueDate release];
    [_task release];
    [_selectADateViewController release];
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
    NSLog(@"TaskEditViewController viewDidLoad");
    [super viewDidLoad];
    //[self.name addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchDown];
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
    //self.datePicker.hidden=YES;
    NSLog(@"TaskEditViewController viewDidDisappear");
	[super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"TaskEditViewController viewDidAppear");
	[super viewDidAppear:animated];    
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"TaskEditViewController viewWillAppear");
    
    CGRect datePickerFrame=self.datePicker.frame;
    NSLog(@"datePickerFrame: %@", NSStringFromCGRect(datePickerFrame));
    datePickerFrame.origin.y=datePickerFrame.origin.y=self.view.bounds.size.height;
    NSLog(@"datePickerFrame after changed: %@", NSStringFromCGRect(datePickerFrame));
    self.datePicker.frame=datePickerFrame;
    
    self.name.text=self.task.name;
    [self.dueDate setTitle:@"Click here to select a date" forState:UIControlStateNormal];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    NSString *dateString = [dateFormat stringFromDate:self.task.dueDate];
    
    if(dateString!=nil) {
        [self.dueDate setTitle:dateString forState:UIControlStateNormal];
    }
    [dateFormat release];
    
    [super viewWillAppear:animated];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

@end
