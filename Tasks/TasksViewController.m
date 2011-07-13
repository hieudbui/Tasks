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
#import "Account.h"

@implementation TasksViewController

@synthesize detailViewController;
@synthesize bottomToolbar=_bottomToolbar;
@synthesize accounts=_accounts;
@synthesize tableView=_tableView;
@synthesize accountsToTaskLists=_accountsToTaskLists;

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
    [_accounts release];
    [_tableView release];
    [_accountsToTaskLists release];
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
    
    NSLog(@"TasksViewController.viewDidLoad invoked");
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Edit" 
                                   style: UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(editButtonTapped)];
    self.navigationItem.rightBarButtonItem=editButton;
    [editButton release];
    self.title=@"Tasks";
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView setEditing:NO animated:NO];
    self.navigationItem.rightBarButtonItem.title=@"Edit";
}

- (void) editButtonTapped
{
    NSLog(@"edit button tapped.  Switch to edit mode");
    
    UIBarButtonItem *editButton=self.navigationItem.rightBarButtonItem;
    if(editButton.title==@"Edit") {
        editButton.title=@"Done";
        [self.tableView setEditing:YES animated:YES];
    }
    else {
        editButton.title=@"Edit";
        [self.tableView setEditing:NO animated:YES];
    }
    //GenericViewController *genericViewController=[[GenericViewController alloc] init];
    //[self.navigationController pushViewController:genericViewController animated:true];
    //[genericViewController release];
}

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setAccounts:(NSArray *)accounts
{
        [_accounts release];
        _accounts = [accounts retain];
        NSLog(@"TasksViewController.setAccounts: %@", _accounts);
        
        NSMutableArray *accountsToTaskLists=[NSMutableArray arrayWithCapacity:[_accounts count]];
        for(Account *account in _accounts) {
            NSArray *taskLists=account.taskLists;
            NSDictionary *accountToTaskLists=[NSDictionary dictionaryWithObjectsAndKeys:
                    taskLists, account.name, nil];
            [accountsToTaskLists addObject:accountToTaskLists];
        }
        self.accountsToTaskLists=accountsToTaskLists;
    [self.tableView reloadData];
          
}

- (NSArray *)getTaskLists:(NSIndexPath *)indexPath
{
    return [[[self.accountsToTaskLists objectAtIndex:indexPath.section] allValues] objectAtIndex:0];
}

- (Account *)getAccount:(NSIndexPath *)indexPath
{
    id key=[[[self.accountsToTaskLists objectAtIndex:indexPath.section] allKeys] objectAtIndex:0];
    for(Account *account in _accounts) {
        if(account.name==key) {
            return account;
        }
    }
    return nil;
}

-(TaskList *)getTaskList:(NSIndexPath *)indexPath
{
    return [[self getTaskLists:indexPath] objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"sections: %u\n", [self.accountsToTaskLists count]);
    return [self.accountsToTaskLists count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section: %u rows: %u\n",section, [[[[self.accountsToTaskLists objectAtIndex:section] allValues] objectAtIndex:0] count]);
    return [[[[self.accountsToTaskLists objectAtIndex:section] allValues] objectAtIndex:0] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[self getTaskList:indexPath] name];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[self.accountsToTaskLists objectAtIndex:section] allKeys] objectAtIndex:0];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willBeginEditingRowAtIndexPath: %@\n",indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commitEditingStyle: %u forRowAtIndexPath: %@\n",editingStyle,indexPath);
    //gotta remove the tasklist first
    TaskList *toBeRemovedTaskList=[self getTaskList:indexPath];
    if(detailViewController.detailItem==toBeRemovedTaskList) {
        detailViewController.detailItem=nil;
    }
    [[self getAccount:indexPath] removeTaskList:toBeRemovedTaskList];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationFade];
   
}
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
    detailViewController.detailItem=[self getTaskList:indexPath];
    
    //TODO
    //This is not clean
    //this controller should not have a reference to the detailviewcontroller
    //it is better to come up with a delegate
    //then pass the delegate to this controller
    //This controller will then call the delegate to do work
    //the delegate can then call the detailviewcontroller as part of its work
}


- (void)viewDidUnload
{
    
    NSLog(@"view unload");
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
