//
//  RandomStringHelper.m
//  Account Manager
//
//  Created by Admin on 23/12/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "RandomStringHelper.h"

@implementation RandomStringHelper

+(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

@end

