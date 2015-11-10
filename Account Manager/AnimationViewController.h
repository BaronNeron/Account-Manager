//
//  AnimationViewController.h
//  Account Manager
//
//  Created by neron on 30/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *animationLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBarButton;

- (IBAction)animation:(id)sender;

@end
