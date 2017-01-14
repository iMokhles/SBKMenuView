//
//  SBKStepper.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 11/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKStepper.h"

@implementation SBKStepper

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutorepeat:NO];
    }
    return self;
}
- (void)stopTimer {
    [self.stepperTimer invalidate];
    self.stepperTimer = nil;
}

- (void)startTimer {
    if (self.stepperTimer == nil) {
        self.stepperTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                           selector:@selector(stepperTimerChanged:) userInfo:nil repeats:YES];
    }
    NSTimeInterval timeInterval = 0.1;
    [self.stepperTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
}
- (void)stepperTimerChanged:(NSTimer *)sender {
    if ([self isDecreasing]) {
        self.value -= self.stepValue;
        if(self.value<self.minimumValue) {
            self.value = self.minimumValue;
        }
        if(self.value>self.maximumValue) {
            self.value = self.maximumValue;
        }
    } else {
        self.value += self.stepValue;
        if(self.value<self.minimumValue) {
            self.value = self.minimumValue;
        }
        if(self.value>self.maximumValue) {
            self.value = self.maximumValue;
        }
    }
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    if (touch != nil) {
        CGPoint touchPoing = [touch locationInView:self];
        if (touchPoing.x < 47) {
            self.decreasing = YES;
        } else if (touchPoing.x > 47) {
            self.decreasing = NO;
        }
        [self startTimer];
    }
    return YES;
}
- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    [self stopTimer];
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    [self stopTimer];
}

@end