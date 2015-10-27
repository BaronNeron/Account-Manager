//
//  DataManager.h
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "Type.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(DataManager*) sharedManager;
- (Account*)addAccountWithType:(Type*)type username:(NSString*)username password:(NSString*)password;
- (void)addTypeWithName:(NSString*)name;
- (void)addHistoryWithDetail:(NSString*)detail;
- (void)changeDefaultAccountForType:(Type*)type :(Account*)defaultAccount;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
