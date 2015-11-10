//
//  AboutViewController.h
//  Account Manager
//
//  Created by Admin on 10/11/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButton;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *secondNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *groupTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

- (IBAction)emailTouchDown:(id)sender;

- (IBAction)phoneTouchDown:(id)sender;

- (IBAction)textFieldDidEndOnExit:(id)sender;

@end
