//
//  AnimationViewController.m
//  Account Manager
//
//  Created by neron on 30/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AnimationViewController.h"
#import "CustomColorHelper.h"
#import "LocalizationHelper.h"
#import "SWRevealViewController.h"

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = Locale(@"Animation_Menu_Item");
    [self.animationLabel setText:Locale(@"Animation_Menu_Item")];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.menuBarButton setTarget: self.revealViewController];
        [self.menuBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    [self setGradient];
}

-(void)setGradient{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[CustomColorHelper yellowColor] CGColor], (id)[[CustomColorHelper blueColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)animation:(id)sender {
    [UIView transitionWithView:self.animationLabel duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        //todo
    } completion:^(BOOL finished) {
        //todo
    }];
}
     
@end
