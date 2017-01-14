//
//  SBKStepper.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 11/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBKStepper : UIStepper
@property(nonatomic, getter=isDecreasing) BOOL decreasing;
@property(retain, nonatomic) NSTimer *stepperTimer;
@end