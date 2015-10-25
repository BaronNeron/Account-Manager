//
//  TimerManager.h
//  Account Manager
//
//  Created by Admin on 26/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TimerManager : NSObject

@property (strong, nonatomic) NSTimer *timer;

+(TimerManager*) sharedManager;

-(void)clearBufferAfter:(float)time;

-(void)clearBuffer:(NSTimer *)timer;

@end
