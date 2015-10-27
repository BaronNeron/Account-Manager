//
//  DataManager.m
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "Account.h"
#import "DataManager.h"
#import "History.h"
#import "Type.h"

@implementation DataManager

+(DataManager*) sharedManager{
    
    static DataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}

- (Account*)addAccountWithType:(Type*)type username:(NSString*)username password:(NSString*)password{
    NSManagedObjectContext *context = self.managedObjectContext;
    Account *newAccount = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
    newAccount.type = type;
    newAccount.username = username;
    newAccount.password = password;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save new account! %@ %@", error, [error localizedDescription]);
        return nil;
    }
    else{
        NSLog(@"Account %@ was added and save", username);
        return newAccount;
    }
}

- (void)addTypeWithName:(NSString*)name{
    NSManagedObjectContext *context = self.managedObjectContext;
    Type *newType = [NSEntityDescription insertNewObjectForEntityForName:@"Type" inManagedObjectContext:context];
    newType.name = name;
    newType.accounts = nil;
    newType.defaultAccount = nil;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save new type! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Type %@ was added and save", name);
    }
}

- (void)changeDefaultAccountForType:(Type*)type :(Account*)defaultAccount{
    NSManagedObjectContext *context = self.managedObjectContext;
    type.defaultAccount = defaultAccount;
    defaultAccount.defaultToType = type;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't change default account for type! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Default account for type %@ was changed", type.name);
    }
}

- (void)addHistoryWithDetail:(NSString*)detail{
    NSManagedObjectContext *context = self.managedObjectContext;
    History *newHistory = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
    newHistory.detail = detail;
    newHistory.date = [NSDate date];
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Can't save new history! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Histroy was added and save");
    }
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Account_Manager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Account_Manager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
