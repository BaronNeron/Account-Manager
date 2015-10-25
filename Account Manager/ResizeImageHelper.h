//
//  ResizeImageHelper.h
//  Account Manager
//
//  Created by Admin on 24/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ResizeImageHelper : NSObject

+(UIImage *)resizeImage:(UIImage*)image :(CGSize)size;

@end
