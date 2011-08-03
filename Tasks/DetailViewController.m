//
//  DetailViewController.m
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "Task.h"
#import "TaskList.h"
#import "TaskCell.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize popoverController=_myPopoverController;
@synthesize navigationController=_navigationController;

- (void) pushViewController:(UIViewController *)viewController
{
    [_navigationController popToRootViewControllerAnimated:NO];
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    [self.view addSubview:_navigationController.view];
    
    [_navigationController pushViewController:viewController animated:YES];
    /*
    if(_viewController !=viewController) {
        [_viewController release];
        _viewController=[[UINavigationController alloc] initWithRootViewController:viewController];
        for (UIView *view in [self.view subviews]) {
            [view removeFromSuperview];
        }
        [self.view addSubview:_viewController.view];
        [viewController viewWillAppear:YES];

    }
     */
}

- (void) setViewController:(UIViewController *)viewController
{
    
    if(_viewController !=viewController) {
        [_viewController release];
        [viewController retain];
        _viewController=viewController;
        for (UIView *view in [self.view subviews]) {
            [view removeFromSuperview];
        }
        [self.view addSubview:_viewController.view];
    }
}

- (void) configureView
{
    
}

- (void) loadView
{
    if(_viewController!=nil) {
        NSLog(@"load delegate view\n");
        NSLog(@"delegate view: %@\n",_viewController.view);
        //self.view=_viewController.view;
        //[super loadView];
        //[self.view setNeedsDisplay];
        //[self.view.superview setNeedsDisplay];
    }
    else {
        NSLog(@"load default view");
        [super loadView];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.popoverController = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_myPopoverController release];
    [_viewController release];
    [_navigationController release];
    [super dealloc];
}

@end
