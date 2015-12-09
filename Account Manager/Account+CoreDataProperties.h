//
//  Account+CoreDataProperties.h
//  Account Manager
//
//  Created by Admin on 23/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *password;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) Type *defaultToType;
@property (nullable, nonatomic, retain) Type *type;

@end

NS_ASSUME_NONNULL_END
