//
//  StringFromDateHelper.m
//  Account Manager
//
//  Created by Admin on 27/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "StringFromDateHelper.h"

@implementation StringFromDateHelper

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
