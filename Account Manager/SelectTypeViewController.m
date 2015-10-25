//
//  SelectTypeViewController.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AddAccountViewController.h"
#import "LocalizationHelper.h"
#import "SelectTypeViewController.h"
#import "ResizeImageHelper.h"

@interface SelectTypeViewController ()

@end

@implementation SelectTypeViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Locale(@"Select_Type_Navigation_Item_Title");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [[self tableView]reloadData];
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
    Type *objectType = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.textLabel setText:objectType.name];
    [cell.detailTextLabel setText:nil];
    cell.imageView.image = [ResizeImageHelper resizeImage:[UIImage imageNamed:objectType.name] :CGSizeMake(35, 35)];
    if(objectType.name == self.type.name){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"addAccountSegue"]){
        self.type = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        AddAccountViewController *addAccountViewController = [segue destinationViewController];
        addAccountViewController.type = self.type;
    }
}

@end
