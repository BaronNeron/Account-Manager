//
//  History+CoreDataProperties.h
//  Account Manager
//
//  Created by Admin on 27/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "History.h"

NS_ASSUME_NONNULL_BEGIN

@interface History (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSString *detail;

@end

NS_ASSUME_NONNULL_END
