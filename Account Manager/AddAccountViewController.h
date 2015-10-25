//
//  AddAccountViewController.h
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "Type.h"
#import <UIKit/UIKit.h>

@interface AddAccountViewController : UIViewController

@property (strong) Type *type;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAccountButton;

@property (weak, nonatomic) IBOutlet UILabel *defaultAccountLabel;

@property (weak, nonatomic) IBOutlet UISwitch *defaultAccountSwitch;


- (IBAction)saveAccount:(id)sender;

@end
