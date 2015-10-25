//
//  TimerManager.m
//  Account Manager
//
//  Created by Admin on 26/10/15.
//  Copyright © 2015 Andrey Kozlov. All rights reserved.
//

#import "LocalizationHelper.h"
#import "TimerManager.h"
#import "TWMessageBarManager.h"

@implementation TimerManager

+(TimerManager*) sharedManager{
    
    static TimerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TimerManager alloc] init];
    });
    
    return manager;
}

-(void)clearBufferAfter:(float)time;{
    if(self.timer){
        [self.timer invalidate];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(clearBuffer:) userInfo:nil repeats:NO];
}

-(void)clearBuffer: (NSTimer *)timer {
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:@""];
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:Locale(@"Info_Message_Title") description:Locale(@"Buffer_Is_Clear") type:TWMessageBarMessageTypeInfo];
}

@end
