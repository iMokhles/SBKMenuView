//
//  SBKTextView.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 20/09/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKTextView.h"

@implementation SBKTextViewObject
+ (instancetype)textObjectWithString:(NSString *)textString font:(UIFont *)textFont color:(UIColor *)color {
    SBKTextViewObject *textObject = [[SBKTextViewObject alloc] init];
    textObject.text = textString;
    textObject.font = textFont;
    textObject.textColor = color;
    return textObject;
}
- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[SBKTextViewObject class]]) {
        return [((SBKTextViewObject *)object).text isEqualToString:_text];
    }
    
    return NO;
}
@end

@interface SBKTextView () {
    UIPanGestureRecognizer *panGesture;
}
@property (nonatomic, copy) void (^completion)();
@end

@implementation SBKTextView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.shineLabel = [[UILabel alloc] init];
        [self.shineLabel setNumberOfLines:0];
        [self.shineLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.shineLabel];
        panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLabelView:)];
        [self addGestureRecognizer:panGesture];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}
- (void)addTextObject:(SBKTextViewObject *)textObject
{
    _currentObject = textObject;
    [self.shineLabel setText:[NSString stringWithFormat:@" %@", _currentObject.text]];
    [self.shineLabel setFont:_currentObject.font];
    [self.shineLabel setTextColor:_currentObject.textColor];
    [self changeFrameWithCurrentPoint];
}


- (void)handleTapFrom:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint pointGesture = [gesture locationInView:[gesture.view superview]];
        self.tappedAction(pointGesture, self);
    }
    
}

- (void)moveLabelView:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.superview];
    recognizer.view.center = CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
}

- (void)setDraggable:(BOOL)draggable {
    [panGesture setEnabled:draggable];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self changeFrameWithCurrentPoint];
}

- (void)changeFrameWithCurrentPoint {
    
    float width = [SBKHelper widthForText:_currentObject.text withFont:_currentObject.font fromLabel:_shineLabel];
    float height = [SBKHelper heightForText:_currentObject.text withFont:_currentObject.font];
    if (height >= [UIScreen mainScreen].bounds.size.height) {
        width = self.superview.frame.size.width;
    }
    CGRect frame = CGRectMake(_currentPoint.x, _currentPoint.y, width, height);
    self.frame = frame;
    [_shineLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
//    CGRect currentRect = self.frame;
//    if (CGRectContainsRect(self.superview.frame, self.frame)) {
//        // Completely Inside
//        
//    } else {
//        if (self.frame.origin.y < self.superview.frame.origin.y) {
//            //vertically outside up
//        } else if (self.frame.origin.y+self.frame.size.height > self.superview.frame.size.height) {
//            //vertically outside down
//            currentRect.origin.y = self.superview.frame.size.height/2;
//            self.frame = currentRect;
//        } else if (self.frame.origin.x < self.superview.frame.origin.x) {
//            //  horizontally outside left
//        } else if (self.frame.origin.x+self.frame.size.width > self.superview.frame.size.width) {
//            //  horizontally outside right
//            currentRect.origin.x = self.superview.frame.size.width/5;
//            self.frame = currentRect;
//        }
//    }
}
@end
