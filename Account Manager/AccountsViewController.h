//
//  AccountsViewController.h
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "CoreDataViewController.h"
#import "Type.h"
#import <UIKit/UIKit.h>

@interface AccountsViewController : CoreDataViewController

@property (nonatomic, strong) Type *type;

@end
