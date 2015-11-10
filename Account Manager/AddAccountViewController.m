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
#import "TWMessageBarManager.h"

@interface AddAccountViewController () <UITextFieldDelegate>

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Locale(@"Add_Account_Navigation_Item_Title");
    self.usernameLabel.text = Locale(@"Username_Label_Text");
    self.passwordLabel.text = Locale(@"Password_Label_Text");
    self.defaultAccountLabel.text = Locale(@"Default_Account_Label_Text");

    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    if(self.account){
        self.usernameTextField.text = self.account.username;
        self.passwordTextField.text = self.account.password;
        if(self.account.defaultToType){
            self.defaultAccountSwitch.on = YES;
        }
        else{
            self.defaultAccountSwitch.on = NO;
        }
    }
    else{
        if(self.type.defaultAccount){
            self.defaultAccountSwitch.on = NO;
        }
        else{
            self.defaultAccountSwitch.enabled = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveAccount:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    TypesViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Types"];
    [self.navigationController pushViewController:vc animated:YES];
    if(!self.account){
        Account* newAccount = [[DataManager sharedManager] addAccountWithType:self.type username:self.usernameTextField.text password:self.passwordTextField.text];
        if(self.defaultAccountSwitch.isOn){
            [[DataManager sharedManager]changeDefaultAccountForType:self.type :newAccount];
        }
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Success_Message_Title") description:Locale(@"Account_Was_Added") type:TWMessageBarMessageTypeSuccess];
    }
    else{
        [[DataManager sharedManager] editAccount:self.account username:self.usernameTextField.text password:self.passwordTextField.text];
        if(self.defaultAccountSwitch.isOn){
            [[DataManager sharedManager]changeDefaultAccountForType:self.account.type :self.account];
        }
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Success_Message_Title") description:Locale(@"Account_Was_Edit") type:TWMessageBarMessageTypeInfo];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
