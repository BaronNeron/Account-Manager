//
//  CustomColorHelper.m
//  Account Manager
//
//  Created by Admin on 25/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "CustomColorHelper.h"

@implementation CustomColorHelper

+(UIColor*)redColor{
    return [UIColor colorWithRed:0.89f green:0.14f blue:0.46f alpha:1.0f];
}

+(UIColor*)greenColor{
    return [UIColor colorWithRed:0.30f green:0.78f blue:0.60f alpha:1.0f];
}

+(UIColor*)blueColor{
    return [UIColor colorWithRed:0.45f green:0.80f blue:0.86f alpha:1.0f];
}

+(UIColor*)yellowColor{
    return [UIColor colorWithRed:0.97 green:0.71 blue:0.12 alpha:1.0f];
}

+(UIColor*)grayColor{
    return [UIColor colorWithRed:0.30 green:0.22 blue:0.29 alpha:1.0f];
}

+(UIColor*)makeColor:(UIColor*)color :(CGFloat)alpha{
    return [color colorWithAlphaComponent:alpha];
}

@end
