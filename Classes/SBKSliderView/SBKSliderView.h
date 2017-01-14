//
//  SBKSliderView.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 11/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBKStepper.h"

typedef void(^SliderActionCompletionBlock)(UISlider *slider);
typedef void(^StepperActionCompletionBlock)(SBKStepper *stepper);

@interface SBKSliderView : UIView
// slider action block
@property (copy, nonatomic) SliderActionCompletionBlock sliderBlock;
@property (copy, nonatomic) StepperActionCompletionBlock stepperBlock;
- (id)initWithFrame:(CGRect)frame defaultValue:(CGFloat)value;
@end
