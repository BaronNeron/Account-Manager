//
//  NavigationController.m
//  Account Manager
//
//  Created by Admin on 26/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "CustomColorHelper.h"
#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [CustomColorHelper grayColor];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
