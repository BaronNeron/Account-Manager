//
//  AccountsViewController.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "Account.h"
#import "AccountsViewController.h"
#import "AddAccountViewController.h"
#import "CustomColorHelper.h"
#import "DataManager.h"
#import "LocalizationHelper.h"
#import "Type.h"
#import "TWMessageBarManager.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type.name == %@", self.type.name];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Core Data error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    Account *account = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:account.username];
    [cell.detailTextLabel setText:nil];
    if(account.defaultToType){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    Account *currentAccount = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Locale(@"Delete_Action_Title") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [[DataManager sharedManager]deleteAccount:currentAccount];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Success_Message_Title") description:Locale(@"Account_Was_Delete") type:TWMessageBarMessageTypeError];
    }];
    deleteAction.backgroundColor = [CustomColorHelper redColor];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Locale(@"Edit_Action_Title") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddAccountViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"addAccount"];
        vc.account = currentAccount;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    editAction.backgroundColor = [CustomColorHelper yellowColor];
    
    return currentAccount.defaultToType == nil ? @[deleteAction, editAction] : @[editAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool changeByTouch = [defaults boolForKey:@"change_by_touch"];
    if(changeByTouch == YES) {
        Account *account = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [[DataManager sharedManager]changeDefaultAccountForType:account.type :account];
        [self.tableView reloadData];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"addAccountSegue"]){
        AddAccountViewController *addAccountViewController = [segue destinationViewController];
        addAccountViewController.type = self.type;
    }
}


@end
