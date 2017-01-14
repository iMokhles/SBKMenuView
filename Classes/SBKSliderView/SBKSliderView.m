//
//  SBKSliderView.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 11/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKSliderView.h"

@interface SBKSliderView () {
    SBKStepper *stepper;
    UISlider *slider;
    UILabel *label;
}
@end
@implementation SBKSliderView

- (id)initWithFrame:(CGRect)frame defaultValue:(CGFloat)value {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 35, frame.size.height)];
        [label setTextColor:[UIColor whiteColor]];
        [label setText:[NSString stringWithFormat:@"%0.2f",value]];
//        [label setFont:[UIFont systemFontOfSize:14]];
        [label setAdjustsFontSizeToFitWidth:YES];
        [self addSubview:label];
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(48, 0, frame.size.width-155, frame.size.height)];
        slider.tintColor = [UIColor whiteColor];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 10;
        slider.maximumValue = 50;
        slider.continuous = YES;
        slider.value = value;
        [slider setUserInteractionEnabled:YES];
        [self addSubview:slider];
        
        stepper = [[SBKStepper alloc] initWithFrame:CGRectMake(216, 10, 94, 29)];
        stepper.tintColor = [UIColor whiteColor];
        [stepper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventValueChanged];
        [stepper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventTouchUpInside];
        stepper.minimumValue = 10.0;
        stepper.maximumValue = 50.0;
        stepper.stepValue = 0.4;
        stepper.value = value;
        [stepper setUserInteractionEnabled:YES];
        [self addSubview:stepper];
        
    }
    return self;
}
-(void)sliderAction:(id)sender
{
    UISlider *mainSlider = (UISlider*)sender;
    self.sliderBlock(mainSlider);
    [stepper setValue:mainSlider.value];
    [label setText:[NSString stringWithFormat:@"%0.2f",mainSlider.value]];
}
- (void)stepperAction:(id)sender {
    SBKStepper *mainStepper = (SBKStepper *)sender;
    self.stepperBlock(mainStepper);
    [slider setValue:mainStepper.value animated:YES];
    [label setText:[NSString stringWithFormat:@"%0.2f",mainStepper.value]];
}

@end
