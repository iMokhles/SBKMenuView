//
//  SBKTextView.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 20/09/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBKHelper.h"

@class SBKTextView;
typedef void(^TappedCompletionBlock)(CGPoint point, SBKTextView *sbkText);

@interface SBKTextViewObject : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
+ (instancetype)textObjectWithString:(NSString *)textString font:(UIFont *)textFont color:(UIColor *)color;
@end

@interface SBKTextView : UIView
@property (nonatomic, strong) TappedCompletionBlock tappedAction;
@property (nonatomic, strong) UILabel *shineLabel;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, strong) SBKTextViewObject *currentObject;

- (void)addTextObject:(SBKTextViewObject *)textObject;
- (void)setDraggable:(BOOL)draggable;
- (void)changeFrameWithCurrentPoint;
@end
