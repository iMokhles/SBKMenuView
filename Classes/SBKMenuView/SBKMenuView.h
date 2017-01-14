//
//  SBKMenuView.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 09/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBKSliderView.h"
#import "SBKTextView.h"

@class SBKMenuView;
typedef void(^ActionCompletionBlock)(UIButton *button, NSString *title, SBKMenuView *menuView, SBKTextView *textView);

typedef NS_ENUM(NSInteger, SBKMenuViewBlurEffectStyle) {
    SBKMenuViewBlurEffectStyleExtraLight,
    SBKMenuViewBlurEffectStyleLight,
    SBKMenuViewBlurEffectStyleDark
};

@interface SBKMenuView : UIView

// current textview 
@property (nonatomic, strong) SBKTextView *textView;

// check if the menu is visible
@property (nonatomic, assign) BOOL isVisible;

// changing background blur effect style
@property (nonatomic, assign) SBKMenuViewBlurEffectStyle blurBgEffectStyle;

// changing buttons background color
@property (nonatomic, assign) UIColor *btnsBackgroundColor;

// changing buttons title on normal state
@property (nonatomic, assign) UIColor *btnsNormalTitleColor;

// changing buttons title on hightlight state
@property (nonatomic, assign) UIColor *btnsHightlightTitleColor;

// changing corner radius for both the background and the buttons
@property (nonatomic, assign) CGFloat mainCornerRadius;

// changing button title font
@property (nonatomic, assign) UIFont *btnTitleFont;

// buttons action block
@property (copy, nonatomic) ActionCompletionBlock actionBlock;

// init with button titles
- (id)initWithFrame:(CGRect)frame andButtonsArray:(NSArray *)btnsTitlesArray;

// changing frame in case u want
- (void)updateViewFrame:(CGRect)nFrame;

// Add SliderView ;)
// adding slider
- (void)addSliderView:(SBKSliderView *)sliderView;

// removing the slider
- (void)removeSliderView;

// Add CustomView
// adding new view
- (void)addView:(UIView *)view;

// removing the new view
- (void)removeView;

// enable/disable drag
- (void)setDraggable:(BOOL)draggable;
@end
