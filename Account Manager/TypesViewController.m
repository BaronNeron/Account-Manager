//
//  TypeViewController.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "Account.h"
#import "AccountsViewController.h"
#import "LocalizationHelper.h"
#import "Type.h"
#import "TypesViewController.h"
#import "ResizeImageHelper.h"

@interface TypesViewController ()

@end

@implementation TypesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Locale(@"Types_Navigation_Item_Title");
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Type" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"accounts.@count > %u", 0];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
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
    Type *type = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:type.name];
    [cell.detailTextLabel setText:type.defaultAccount.username];
    cell.imageView.image = [ResizeImageHelper resizeImage:[UIImage imageNamed:type.name] :CGSizeMake(35, 35)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"accountsSegue"]){
        Type *type = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        AccountsViewController *accountsViewController = [segue destinationViewController];
        accountsViewController.navigationItem.title = type.name;
        accountsViewController.type = type;
    }
}

@end
