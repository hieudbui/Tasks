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
#import "SettingsViewController.h"
#import "Account.h"
#import "AccountStorage.h"
#import "AccountEditViewController.h"
#import "SettingsCompleteDelegate.h"
#import "GTMOAuthViewControllerTouch.h"

static NSString *const kKeychainItemName = @"AgileSoft Google Tasks";
static NSString *const kShouldSaveInKeychainKey = @"shouldSaveInKeychain";

@implementation RootViewController
		
@synthesize detailViewController=_detailViewController;
@synthesize bottomToolbar=_bottomToolbar;
@synthesize accounts=_accounts;
@synthesize taskListsViewController=_taskListsViewController;
@synthesize accountEditViewController=_accountEditViewController;
@synthesize settingsViewController=_settingsViewController;
@synthesize tableView=_tableView;
@synthesize accountStorage=_accountStorage;



- (void)awakeFromNib {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(incrementNetworkActivity:) name:kGTMOAuthFetchStarted object:nil];
    [nc addObserver:self selector:@selector(decrementNetworkActivity:) name:kGTMOAuthFetchStopped object:nil];
    [nc addObserver:self selector:@selector(signInNetworkLostOrFound:) name:kGTMOAuthNetworkLost  object:nil];
    [nc addObserver:self selector:@selector(signInNetworkLostOrFound:) name:kGTMOAuthNetworkFound object:nil];
    
    // Get the saved authentication, if any, from the keychain.
    //
    // The view controller supports methods for saving and restoring
    // authentication under arbitrary keychain item names; see the
    // "keychainForName" methods in the interface.  The keychain item
    // names are up to the application, and may reflect multiple accounts for
    // one or more services.
    //
    // This sample app may have saved one Google authentication and one Twitter
    // auth.  First, we'll try to get the saved Google authentication, if any.
    GTMOAuthAuthentication *auth;
    auth = [GTMOAuthViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName];
    // save the authentication object, which holds the auth tokens
    [self setAuthentication:auth];
}

- (void)setAuthentication:(GTMOAuthAuthentication *)auth {
    [mAuth autorelease];
    mAuth = [auth retain];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    
    Account *allAccount=[self.accountStorage allAccount];
    
    self.accounts=[NSMutableArray arrayWithObjects: 
               [NSMutableArray arrayWithObjects:allAccount, nil], 
               [self.accountStorage accounts],
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


- (void) settingsCompleteViewController:(SettingsViewController *)settingsViewController
                               settings:(Settings *)settings;
{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)settings
{
    self.settingsViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    [self presentModalViewController:self.settingsViewController animated:YES];   
}

-(IBAction)sync
{
    
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
    if(indexPath.row == [[self getAccounts:indexPath.section] count]) {
        return nil;
    }
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
        cell.textLabel.text=@"add new account";
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
    
    Account *account=[self getAccount:indexPath];
    if(account!=nil && account.type==Local) {
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
        
        // For GTM applications, the scope is available as
        //   NSString *scope = [[service class] authorizationScope]
        NSString *scope = @"http://www.google.com/m8/feeds/";
        
        // ### Important ###
        // GTMOAuthViewControllerTouch is not designed to be reused. Make a new
        // one each time you are going to show it.
        
        // Display the autentication view.
        GTMOAuthViewControllerTouch *viewController = [[[GTMOAuthViewControllerTouch alloc]
                                                        initWithScope:scope
                                                        language:nil
                                                        appServiceName:kKeychainItemName
                                                        delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)] autorelease];
        
        // You can set the title of the navigationItem of the controller here, if you want.
        
        // Optional: display some html briefly before the sign-in page loads
        NSString *html = @"<html><body bgcolor=silver><div align=center>Loading sign-in page...</div></body></html>";
        [viewController setInitialHTMLString:html];
            
        [self.detailViewController pushViewController:viewController];
        
        //[self.detailViewController setViewController:self.accountEditViewController];  
        //self.accountEditViewController.account=[self.accountStorage newAccount];
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
    [_settingsViewController release];
    [_bottomToolbar release];
    [_accounts release];
    [_tableView release];
    [_accountStorage release];
    [super dealloc];
}

@end
