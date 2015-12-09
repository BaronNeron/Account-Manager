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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*------AES256 TEST------*/
    /*
    NSString *str = @"teststring";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSData *eData = [data aes256EncryptWithKey:@"Salted__!*ôZP¿ý›ßž‚}.&¹8›dÆm"];
    NSString* eStr = [[NSString alloc] initWithData:eData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", eStr);
    NSData *dData = [eData aes256DecryptWithKey:@"Salted__!*ôZP¿ý›ßž‚}.&¹8›dÆm"];
    NSString* dStr = [[NSString alloc] initWithData:dData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", dStr);
    */
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"has_launched_once"])
    {
        NSArray *types = @[@"Apple", @"Dropbox", @"Facebook", @"Google", @"Instagramm", @"Skype", @"Twitter", @"Vkontakte", @"Yahoo", @"Yandex", @"YouTube"];
        for (NSString *type in types){
            [[DataManager sharedManager] addTypeWithName:type];
        }
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"has_launched_once"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager sharedManager] saveContext];
}

@end
