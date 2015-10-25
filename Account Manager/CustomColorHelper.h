//
//  CustomColorHelper.h
//  Account Manager
//
//  Created by Admin on 25/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomColorHelper : NSObject

+(UIColor*)redColor;

+(UIColor*)greenColor;

+(UIColor*)blueColor;

+(UIColor*)yellowColor;

+(UIColor*)grayColor;

+(UIColor*)makeColor:(UIColor*)color :(CGFloat)alpha;

@end
