//
//  DemoViewController.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 09/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKDisplayImageView.h"
#import "SBKHelper.h"
#import "SBKTextView.h"
#import "SBKMenuView.h"

@interface DemoViewController () {
    UISwipeGestureRecognizer *swipeOnImage;
    SBKMenuView *customMenuView;
    SBKTextViewObject *textBobject;
    
}

@property (strong, nonatomic) SBKDisplayImageView *mainImageView;
@end

@implementation DemoViewController
@synthesize imageToEdit;

- (void)viewDidLoad {
    [super viewDidLoad];

    // set background color
    [self.view setBackgroundColor:[UIColor grayColor]];

    // setup Display ImageView
    self.mainImageView = [[SBKDisplayImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    swipeOnImage = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeOnImageAction:)];
    [swipeOnImage setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.mainImageView setImage:self.imageToEdit];
    __block CustomViewController *selfBlock = self;
    [self.mainImageView setItemActionBlock:^(SBKDisplayImageView *imageView, QBPopupMenuItem *item) {
        [selfBlock addTextAfterItem:item fromPoint:imageView.touchedPoint];
    }];
    [self.view addSubview:self.mainImageView];
    // add swipe gesture ( don't know why i hide the NavigationBar :P )
    [self.mainImageView addGestureRecognizer:swipeOnImage];
}

- (void)swipeOnImageAction:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addTextAfterItem:(QBPopupMenuItem *)item fromPoint:(CGPoint)point {
    
    NSString *textString = @"SBKMenuView";
    
    // text object
    textBobject = [[SBKTextViewObject alloc] init];
    textBobject.text = textString;
    textBobject.font = [UIFont fontWithName:@"HoeflerText-Black" size:20];
    textBobject.textColor = [UIColor redColor];
    
    // add text object to the custom textview
    SBKTextView *textView = [[SBKTextView alloc] init];
    textView.currentPoint = point;
    [textView addTextObject:textBobject];
    __block CustomViewController *selfBlock = self;
    [textView setTappedAction:^(CGPoint point, SBKTextView *sbkTextView) {
        [selfBlock addMenuViewFromPoint:CGPointMake(sbkTextView.frame.origin.x, sbkTextView.frame.origin.y+sbkTextView.frame.size.height) forTextView:sbkTextView];
    }];
    // insert the textview inside the display ImageView
    [self.mainImageView addSubview:textView];
    
}

- (void)addMenuViewFromPoint:(CGPoint)point forTextView:(SBKTextView *)textView {
    __block SBKTextViewObject *currentObject = textBobject;
    if (customMenuView == nil) {
        customMenuView = [[SBKMenuView alloc] initWithFrame:CGRectMake(point.x, point.y, 320, 112) andButtonsArray:@[@"Text", @"Font", @"Style", @"Size", @"Tilt", @"Move", @"Test 2"]];
        customMenuView.blurBgEffectStyle = SBKMenuViewBlurEffectStyleDark;
        customMenuView.tag = 2364;
        customMenuView.textView = textView;
        [customMenuView setActionBlock:^(UIButton *button, NSString* title, SBKMenuView *menuView, SBKTextView *textView) {
            
            if (CGPointEqualToPoint(textView.frame.origin, textView.frame.origin)) {
                textView.currentPoint = textView.frame.origin;
                if ([title isEqualToString:@"Size"]) {
                    
                    CGRect newFrame = menuView.frame;
                    if (newFrame.size.height == 112) {
                        NSLog(@"Equal");
                        newFrame.size.height = menuView.frame.size.height+54;
                        //                [menuView setDraggable:NO];
                        NSValue * value = [NSValue valueWithCGRect:newFrame];
                        [menuView performSelector:@selector(updateViewFrame:) withObject:value];
                        SBKSliderView *sView = [[SBKSliderView alloc] initWithFrame:CGRectMake(5, button.frame.origin.y*2-5, newFrame.size.width-10, 50) defaultValue:textView.currentObject.font.pointSize];
                        sView.sliderBlock = ^(UISlider *slider) {
                            NSLog(@"%f", slider.value);
                            currentObject.text = textView.currentObject.text;
                            currentObject.font = [UIFont fontWithName:textView.currentObject.font.fontName size:slider.value];
                            currentObject.textColor = textView.currentObject.textColor;
                            [textView addTextObject:currentObject];
                            
                        };
                        sView.stepperBlock = ^(SBKStepper *stepper) {
                            NSLog(@"%f", stepper.value);
                            currentObject.text = textView.currentObject.text;
                            currentObject.font = [UIFont fontWithName:textView.currentObject.font.fontName size:stepper.value];
                            currentObject.textColor = textView.currentObject.textColor;
                            [textView addTextObject:currentObject];
                        };
                        [menuView addSliderView:sView];
                    } else {
                        NSLog(@"Don't Equal");
                        newFrame.size.height = menuView.frame.size.height-54;
                        NSValue * value = [NSValue valueWithCGRect:newFrame];
                        [menuView performSelector:@selector(updateViewFrame:) withObject:value];
                        [menuView removeSliderView];
                    }
                    
                } else if ([title isEqualToString:@"Text"]) {
                    
                    currentObject.text = @"SBKMenuView";
                    currentObject.font = [UIFont fontWithName:@"HoeflerText-Black" size:20];
                    currentObject.textColor = [UIColor redColor];
                    [textView addTextObject:currentObject];
                }
            }
        }];
        [self.view addSubview:customMenuView];
    } else {
        
        [customMenuView removeFromSuperview];
        customMenuView = nil;
    }
}
@end
