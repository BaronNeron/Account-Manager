//
//  AboutViewController.m
//  Account Manager
//
//  Created by Admin on 10/11/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AboutViewController.h"
#import "CustomColorHelper.h"
#import "LocalizationHelper.h"
#import "SWRevealViewController.h"

@interface AboutViewController () <MFMailComposeViewControllerDelegate, UITextFieldDelegate>

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = Locale(@"About_Navigation_Item_Title");
    self.navigationController.navigationBar.tintColor = [CustomColorHelper redColor];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBarButton setTarget: self.revealViewController];
        [self.menuBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    self.firstNameLabel.text = Locale(@"firstName");
    self.secondNameLabel.text = Locale(@"secondName");
    self.groupLabel.text = Locale(@"group");
    self.emailLabel.text = Locale(@"email");
    self.phoneLabel.text = Locale(@"phone");
    self.firstNameTextField.text = Locale(@"myFirstName");
    self.secondNameTextField.text = Locale(@"mySecondName");
    self.groupTextField.text = Locale(@"myGroup");
    self.emailTextField.text = Locale(@"myEmail");
    self.phoneTextField.text = Locale(@"myPhone");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"Message Send");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Message Save");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"Send Abort");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Error");
            break;
        default:
            NSLog(@"Unknown Error");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)emailTouchDown:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@""];
        [mail setMessageBody:@"" isHTML:NO];
        [mail setToRecipients:@[self.emailTextField.text]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This Device Cant Send Email");
    }
}

- (IBAction)phoneTouchDown:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:self.phoneTextField.text]]];
}

- (IBAction)textFieldDidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}


@end
