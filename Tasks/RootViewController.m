//
//  RootViewController.m
//  Tasks
//
//  Created by Hieu Bui on 6/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "TaskListsViewController.h"
#import "Account.h"
#import "AccountStorage.h"
#import "AccountEditViewController.h"

@implementation RootViewController
		
@synthesize detailViewController=_detailViewController;
@synthesize bottomToolbar=_bottomToolbar;
@synthesize accounts=_accounts;
@synthesize taskListsViewController=_taskListsViewController;
@synthesize accountEditViewController=_accountEditViewController;
@synthesize tableView=_tableView;
@synthesize accountStorage=_accountStorage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    
    Account *allAccount=[self.accountStorage allAccount];
    
    self.accounts=[NSMutableArray arrayWithObjects: 
               [NSMutableArray arrayWithObjects:allAccount, nil], 
               [self.accountStorage getAccounts],
                   nil,
               nil];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Edit" 
                                   style: UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(editButtonTapped)];
    self.navigationItem.rightBarButtonItem=editButton;
    [editButton release];
    self.title=@"Accounts";
    self.tableView.allowsSelectionDuringEditing=YES;
}

- (void) editButtonTapped
{
    NSLog(@"edit button tapped.  Switch to edit mode");
    
    UIBarButtonItem *editButton=self.navigationItem.rightBarButtonItem;
    if(editButton.title==@"Edit") {
        editButton.title=@"Done";
        [self.tableView setEditing:YES animated:YES];
        //TODO do an alpha fade out animation
        self.bottomToolbar.hidden=YES;
    }
    else {
        editButton.title=@"Edit";
        [self.detailViewController setViewController:nil];
        [self.tableView setEditing:NO animated:YES];
        //TODO do an alpha fade in animation
        self.bottomToolbar.hidden=NO;
    }
    [self.tableView reloadData];
    
    //GenericViewController *genericViewController=[[GenericViewController alloc] init];
    //[self.navigationController pushViewController:genericViewController animated:true];
    //[genericViewController release];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Unselect the selected row if any
	NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
	if (selection) {
		[self.tableView deselectRowAtIndexPath:selection animated:animated];
    }
    [self.tableView setEditing:NO animated:NO];
    self.navigationItem.rightBarButtonItem.title=@"Edit";
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"RootViewController viewWillDisappear");
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    NSLog(@"RootViewController viewDidDisappear");
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSArray *)getAccounts:(NSInteger)section
{
    return [self.accounts objectAtIndex:section];
}

- (Account *) getAccount:(NSIndexPath *)indexPath
{
    return [[self getAccounts:indexPath.section] objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.accounts count];
}

		
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count=[[self getAccounts:section] count];
    
    if(section!=0 && self.tableView.editing) {
        count++;
    }
    NSLog(@"section: %u rows: %u\n",section, count);
    return count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    if(indexPath.row==[[self getAccounts:indexPath.section] count] && self.tableView.editing) {
        cell.textLabel.text=@"add new row";
    }
    else {
        cell.textLabel.text = [[self getAccount:indexPath] name];
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing) {
        if(indexPath.row==[[self getAccounts:indexPath.section] count]) {
            return UITableViewCellEditingStyleInsert;
        }
        else {
            return UITableViewCellEditingStyleDelete;
        }
    }
    return UITableViewCellEditingStyleNone;
}


- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willBeginEditingRowAtIndexPath: %@\n",indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"commitEditingStyle: %u forRowAtIndexPath: %@\n",editingStyle,indexPath);
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        //gotta remove the account first
        [self.accountStorage removeAccount:[self getAccount:indexPath]];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                              withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert) {
        //display the option to create the new task list
         [self.detailViewController setViewController:self.accountEditViewController];  
    }
}


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
    //TODO
    //additional work to check if it is all index then pass all the accounts
    if(self.tableView.editing==NO) {
        [self.navigationController pushViewController:self.taskListsViewController animated:YES];
        Account *selectedAccount=[self getAccount:indexPath];
        self.taskListsViewController.detailViewController=self.detailViewController;
        self.taskListsViewController.accounts=
        selectedAccount.type==All?[self getAccounts:indexPath.section+1]:[NSArray arrayWithObjects:selectedAccount,nil];
        NSLog(@"selected accounts: %@", self.taskListsViewController.accounts);
    }
    else {
        //set the account into the view controller
        [self.detailViewController setViewController:self.accountEditViewController]; 
        Account *account=nil;
        if(indexPath.row==[[self getAccounts:indexPath.section] count]) {
            account=[self.accountStorage newAccount];
        }
        else {
            account=[self getAccount:indexPath];
        }
        self.accountEditViewController.account=account;
    }
   
}

- (void) saveComplete:(Account *)account
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [_detailViewController release];
    [_taskListsViewController release];
    [_accountEditViewController release];
    [_bottomToolbar release];
    [_accounts release];
    [_tableView release];
    [_accountStorage release];
    [super dealloc];
}

@end
