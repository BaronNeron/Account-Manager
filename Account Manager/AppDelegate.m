//
//  AppDelegate.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "AES256.h"
#import "AppDelegate.h"
#import "DataManager.h"
#import "RandomStringHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunchedOnce"])
    {
        NSArray *types = @[@"Apple", @"Dropbox", @"Facebook", @"Google", @"Instagramm", @"Skype", @"Twitter", @"Vkontakte", @"Yahoo", @"Yandex", @"YouTube"];
        for (NSString *type in types){
            [[DataManager sharedManager] addTypeWithName:type];
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:[RandomStringHelper randomStringWithLength:32] forKey:@"aes256key"];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

    [[DataManager sharedManager] saveContext];
}



@end
