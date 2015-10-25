//
//  AddAccountViewController.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AddAccountViewController.h"
#import "DataManager.h"
#import "LocalizationHelper.h"
#import "SelectTypeViewController.h"
#import "TypesViewController.h"

@interface AddAccountViewController ()

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Locale(@"Add_Account_Navigation_Item_Title");
    self.usernameLabel.text = Locale(@"Username_Label_Text");
    self.passwordLabel.text = Locale(@"Password_Label_Text");
    self.defaultAccountLabel.text = Locale(@"Default_Account_Label_Text");
    if(!self.type.defaultAccount){
        [self.defaultAccountSwitch setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveAccount:(id)sender {
    Account* newAccount = [[DataManager sharedManager] addAccountWithType:self.type username:self.usernameTextField.text password:self.passwordTextField.text];
    if(self.defaultAccountSwitch.isOn){
        [[DataManager sharedManager]changeDefaultAccountForType:self.type :newAccount];
    }
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TypesViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Types"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
