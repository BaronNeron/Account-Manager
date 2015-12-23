//
//  TypeViewController.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "Account.h"
#import "AccountsViewController.h"
#import "CustomColorHelper.h"
#import "DataManager.h"
#import "LocalizationHelper.h"
#import "SWRevealViewController.h"
#import "TimerManager.h"
#import "Type.h"
#import "TypesViewController.h"
#import "TWMessageBarManager.h"
#import "ResizeImageHelper.h"

@interface TypesViewController ()

@end

@implementation TypesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"masterKey"])
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Первый запуск приложения"
                                              message:@"Введите свой мастер-ключ"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.secureTextEntry = YES;
        }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       [[NSUserDefaults standardUserDefaults] setObject:alertController.textFields.firstObject.text forKey:@"masterKey"];
                                   }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    self.navigationItem.title = Locale(@"Types_Navigation_Item_Title");
    self.navigationController.navigationBar.tintColor = [CustomColorHelper greenColor];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBarButton setTarget: self.revealViewController];
        [self.menuBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
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

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    Account *account = [[self.fetchedResultsController objectAtIndexPath:indexPath] defaultAccount];
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Locale(@"More_Action_Title") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIAlertController * actionSheet = [UIAlertController alertControllerWithTitle:@"" message:Locale(@"Select_Action_Message")preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction* copyUsername = [UIAlertAction actionWithTitle:Locale(@"Copy_Username_Alert_Action_Title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            UIPasteboard *pb = [UIPasteboard generalPasteboard];
            [pb setString:account.username];
            NSString *newHistoryDetail = [NSString stringWithFormat:@"%@ %@ %@", Locale(@"Username_For"), account.defaultToType.name, Locale(@"Was_Copy")];
            [[DataManager sharedManager]addHistoryWithDetail:newHistoryDetail];
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Success_Message_Title") description:Locale(@"Username_Was_Copy") type:TWMessageBarMessageTypeSuccess];
        }];

        UIAlertAction* copyPassword = [UIAlertAction actionWithTitle:Locale(@"Copy_Password_Alert_Action_Title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Требуется проверка"
                                                  message:@"Введите свой мастер-ключ"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                 textField.secureTextEntry = YES;
             }];
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           if([alertController.textFields.firstObject.text  isEqual: [[NSUserDefaults standardUserDefaults] objectForKey:@"masterKey"]]) {
                                               UIPasteboard *pb = [UIPasteboard generalPasteboard];
                                               NSData *data = [account.password aes256DecryptWithKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"aes256key"]];
                                               NSString* password = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                               [pb setString:password];
                                               NSString *newHistoryDetail = [NSString stringWithFormat:@"%@ %@ %@", Locale(@"Password_For"), account.defaultToType.name, Locale(@"Was_Copy")];
                                               [[DataManager sharedManager]addHistoryWithDetail:newHistoryDetail];
                                               NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                               bool clearBuffer = [defaults boolForKey:@"clear_buffer"];
                                               if(clearBuffer == YES) {
                                                   [[TimerManager sharedManager] clearBufferAfter:20.0f];
                                               }
                                               [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                               [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Success_Message_Title") description:Locale(@"Password_Was_Copy") type:TWMessageBarMessageTypeSuccess];
                                           }
                                           else {
                                               [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Cancel_Message_Title") description:Locale(@"Wrong_Master_Key") type:TWMessageBarMessageTypeError];
                                           }
                                       }];
            UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Cancel_Message_Title") description:Locale(@"Password_Copy_Was_Cancel") type:TWMessageBarMessageTypeError];
                                       }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];

        UIAlertAction* cancel = [UIAlertAction actionWithTitle:Locale(@"Cancel_Alert_Action_Title") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [actionSheet dismissViewControllerAnimated:YES completion:nil];
        }];
        [actionSheet addAction:copyUsername];
        [actionSheet addAction:copyPassword];
        [actionSheet addAction:cancel];
        [self presentViewController:actionSheet animated:YES completion:nil];
    }];
    moreAction.backgroundColor = [CustomColorHelper greenColor];
    
    return @[moreAction];
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
