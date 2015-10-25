//
//  ResizeImageHelper.m
//  Account Manager
//
//  Created by Admin on 24/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "ResizeImageHelper.h"

@implementation ResizeImageHelper

+(UIImage *)resizeImage:(UIImage *)image :(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
