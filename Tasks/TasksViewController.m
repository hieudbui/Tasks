//
//  TasksController.m
//  Tasks
//
//  Created by Hieu Bui on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TasksViewController.h"
#import "DetailViewController.h"
#import "Task.h"
#import "TaskList.h"
#import "InMemoryTaskStorage.h"

@implementation TasksViewController

@synthesize detailViewController;
@synthesize bottomToolbar=_bottomToolbar;
@synthesize taskStorage=_taskStorage;
@synthesize accounts=_accounts;
@synthesize tableView=_tableView;

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
    [detailViewController release];
    [_bottomToolbar release];
    [_taskStorage release];
    [_accounts release];
    [_tableView release];
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
    
    NSLog(@"viewDidLoad invoked");
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Edit" 
                                   style: UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(editButtonTapped)];
    self.navigationItem.rightBarButtonItem=editButton;
    [editButton release];
    self.title=@"Tasks";
    
}

- (void) editButtonTapped
{
    NSLog(@"edit button tapped.  Switch to edit mode");
    //GenericViewController *genericViewController=[[GenericViewController alloc] init];
    //[self.navigationController pushViewController:genericViewController animated:true];
    //[genericViewController release];
}

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setAccounts:(NSArray *)accounts
{
    if (_accounts != accounts) {
        [_accounts release];
        _accounts = [accounts retain];
        NSLog(@"accounts: %@", _accounts);
        
        for(Account *account in _accounts) {
             [self.taskStorage getAllTaskListsForAccount:account];
        }
        [self.tableView reloadData];
    }
          
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.accounts objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [[[self.accounts objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] name];
    return cell;
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
    //detailViewController.detailItem=[[self.accounts objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
