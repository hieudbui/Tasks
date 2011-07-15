//
//  TasksViewController.m
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TasksViewController.h"
#import "RootViewController.h"
#import "Task.h"
#import "TaskList.h"
#import "TaskCell.h"

@interface TasksViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation TasksViewController

@synthesize toolbar=_toolbar;
@synthesize tableView=_tableView;
@synthesize detailItem=_detailItem;
@synthesize popoverController=_myPopoverController;
@synthesize taskCell=_taskCell;

#pragma mark - Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    [self.tableView reloadData];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.detailItem name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.detailItem tasks] count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TaskCell";
    
    TaskCell *cell = (TaskCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSLog(@"Cell Identifier not found.  Creating one from nib");
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [[NSBundle mainBundle] loadNibNamed:@"TaskCell" owner:self options:nil];
        cell=_taskCell;
    }
    else {
        NSLog(@"Cell Identifier found.  Skipping creating one from nib");
    }
    /*
     
     UIImage *image = [UIImage imageNamed:@"unchecked.png"]; 
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom]; 
     CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height); 
     button.frame = frame;	// match the button's size with the image size	
     [button setBackgroundImage:image forState:UIControlStateNormal]; 
     
     // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet 
     [button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside]; 
     button.backgroundColor = [UIColor clearColor]; 
     cell.editingAccessoryView = button;
     cell.textLabel.text = @"text";
     */
    //change the button color to done or not done depend on wheher the task is completed
    [cell initialize:[[self.detailItem tasks] objectAtIndex:indexPath.row]];
    return cell;
}



- (IBAction)checkButtonTapped:(id)sender event:(id)event 
{ 
    
    TaskCell *cell=(TaskCell *)[[sender superview] superview];
    [cell toggle];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    // NSLog(@"row=%i\n",indexPath.row);
    [[[self.detailItem tasks] objectAtIndex:indexPath.row] save];
    //change the button color to done
    
    /*
     Use the code below to find the indexpath given a click
     NSSet *touches = [event allTouches]; 
     UITouch *touch = [touches anyObject]; 
     CGPoint currentTouchPosition = [touch locationInView:self.tableView]; 
     NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition]; 
     
     if (indexPath != nil) {
     NSLog(@"IndexPathFound %i", indexPath.row);
     //this code does not work
     //it always create a new cell
     TaskCell *cell=(TaskCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
     cell.textLabel.text= @"something else";
     //    [self accessoryButtonTappedForRowWithIndexPath:indexPath];
     
     }
     */
} 


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Events";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
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
    [_toolbar release];
    [_detailItem release];
    [_tableView release];
    [_taskCell release];
    [super dealloc];
}

@end
