//
//  MenuViewController.m
//  Account Manager
//
//  Created by Admin on 26/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "CustomColorHelper.h"
#import "LocalizationHelper.h"
#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

NSArray *menu;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [CustomColorHelper grayColor];
    menu = @[@"Accounts", @"History", @"Settings", @"About", @"Animation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [CustomColorHelper grayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    NSString *localizationString = [NSString stringWithFormat:@"%@_Menu_Item",[menu objectAtIndex:indexPath.row]];
    cell.textLabel.text = Locale(localizationString);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    if([selectedCell.reuseIdentifier isEqualToString:@"Settings"]){
        if (!UIApplicationOpenSettingsURLString) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url];
        }
        else{
            NSLog(@"Setting is not support");
        }
    }
}


@end
