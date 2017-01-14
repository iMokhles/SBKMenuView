//
//  SBKMenuView.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 09/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKMenuView.h"

@interface SBKMenuView () <UIScrollViewDelegate> {
    NSMutableArray *btnsArray; // uibutton array
    UIVisualEffect *blurEffect;
    UIVisualEffectView *visualEffectView;
    SBKSliderView *_sliderView;
    UIView *_newView;
    UIPanGestureRecognizer *panGesture;
}
@property(strong, nonatomic) UIScrollView *buttonView; // @synthesize buttonView;

@property (strong, nonatomic) UIButton *Button1;
@property (strong, nonatomic) UIButton *Button2;
@property (strong, nonatomic) UIButton *Button3;
@property (strong, nonatomic) UIButton *Button4;
@property (strong, nonatomic) UIButton *Button5;
@property (strong, nonatomic) UIButton *Button6;

@property (strong, nonatomic) UIButton *Button7;
@property (strong, nonatomic) UIButton *Button8;
@property (strong, nonatomic) UIButton *Button9;
@property (strong, nonatomic) UIButton *Button10;
@property (strong, nonatomic) UIButton *Button11;
@property (strong, nonatomic) UIButton *Button12;

@property (nonatomic) NSArray *mainBtnsArray; // buttons titles array
@end

@implementation SBKMenuView
@synthesize buttonView;
- (id)initWithFrame:(CGRect)frame andButtonsArray:(NSArray *)btnsTitlesArray {
    self = [super initWithFrame:frame];
    if (self) {
        btnsArray = [[NSMutableArray alloc] init];
        _mainBtnsArray = btnsTitlesArray;
        self.userInteractionEnabled = YES;
        CALayer *layerSELF = [self layer];
        layerSELF.masksToBounds = YES;
        [self setClipsToBounds:YES];
        panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveMenuView:)];
        [self addGestureRecognizer:panGesture];
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = self.bounds;
        if (visualEffectView.superview != self)
            [self addSubview:visualEffectView];
        
        buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        buttonView.showsHorizontalScrollIndicator = NO;
        buttonView.pagingEnabled = YES;
        buttonView.bounces = YES;
        buttonView.contentSize = CGSizeMake(frame.size.width*[self numberOfPages], frame.size.height);
        if (_mainBtnsArray.count < 7) {
            buttonView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        }
        [self addSubview:buttonView];
        
        [btnsTitlesArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
            switch (idx) {
                case 0:
                    _Button1  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:0]];
                    [btnsArray addObject:_Button1];
                    [buttonView addSubview:_Button1];
                    break;
                case 1:
                    _Button2  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:1]];
                    [btnsArray addObject:_Button2];
                    [buttonView addSubview:_Button2];
                    break;
                case 2:
                    _Button3  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:2]];
                    [btnsArray addObject:_Button3];
                    [buttonView addSubview:_Button3];
                    break;
                case 3:
                    _Button4  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:3]];
                    [btnsArray addObject:_Button4];
                    [buttonView addSubview:_Button4];
                    break;
                case 4:
                    _Button5  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:4]];
                    [btnsArray addObject:_Button5];
                    [buttonView addSubview:_Button5];
                    break;
                case 5:
                    _Button6  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:5]];
                    [btnsArray addObject:_Button6];
                    [buttonView addSubview:_Button6];
                    break;
                case 6:
                    _Button7  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:6]];
                    [btnsArray addObject:_Button7];
                    [buttonView addSubview:_Button7];
                    break;
                case 7:
                    _Button8  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:7]];
                    [btnsArray addObject:_Button8];
                    [buttonView addSubview:_Button8];
                    break;
                case 8:
                    _Button9  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:8]];
                    [btnsArray addObject:_Button9];
                    [buttonView addSubview:_Button9];
                    break;
                case 9:
                    _Button10  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:9]];
                    [btnsArray addObject:_Button10];
                    [buttonView addSubview:_Button10];
                    break;
                case 10:
                    _Button11  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:10]];
                    [btnsArray addObject:_Button11];
                    [buttonView addSubview:_Button11];
                    break;
                case 11:
                    _Button12  = [self customButtonWithTitle:[btnsTitlesArray objectAtIndex:11]];
                    [btnsArray addObject:_Button12];
                    [buttonView addSubview:_Button12];
                    break;
                default:
                    break;
            }
        }];
        
    }
    return self;
}

- (void)moveMenuView:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state==UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded){
        UIView *superview = recognizer.view.superview;
        CGSize superviewSize = superview.bounds.size;
        CGSize thisSize = recognizer.view.frame.size;
        CGPoint translation = [recognizer translationInView:self.superview];
        CGPoint center = CGPointMake(recognizer.view.center.x + translation.x,
                                     recognizer.view.center.y + translation.y);
        
        CGPoint resetTranslation = CGPointMake(translation.x, translation.y);
        
        if(center.x - thisSize.width/2 < 0)
            center.x = thisSize.width/2;
        else if (center.x + thisSize.width/2 > superviewSize.width)
            center.x = superviewSize.width-thisSize.width/2;
        else
            resetTranslation.x = 0; //Only reset the horizontal translation if the view *did* translate horizontally
        
        if(center.y - thisSize.height/2 < 0)
            center.y = thisSize.height/2;
        else if(center.y + thisSize.height/2 > superviewSize.height)
            center.y = superviewSize.height-thisSize.height/2;
        else
            resetTranslation.y = 0; //Only reset the vertical translation if the view *did* translate vertically
        
        recognizer.view.center = center;
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
    }
}

- (void)setDraggable:(BOOL)draggable {
    [panGesture setEnabled:draggable];
}

- (void)customStyle {
    CALayer *layerSELF = [self layer];
    if (self.mainCornerRadius) {
        [layerSELF setCornerRadius:self.mainCornerRadius];
    } else {
        [layerSELF setCornerRadius:5];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateViewFrame:CGRectNull];
    CGFloat BtnsWidth = self.frame.size.width/3;
    BtnsWidth = BtnsWidth-9;
    
    _Button1.frame = CGRectMake(4, 4, BtnsWidth, 50);
    _Button2.frame = CGRectMake(8+BtnsWidth, 4, BtnsWidth, 50);
    _Button3.frame = CGRectMake(_Button2.frame.origin.x+BtnsWidth+4, 4, BtnsWidth, 50);
    
    _Button4.frame = CGRectMake(4, 58, BtnsWidth, 50);
    _Button5.frame = CGRectMake(8+BtnsWidth, 58, BtnsWidth, 50);
    _Button6.frame = CGRectMake(_Button5.frame.origin.x+BtnsWidth+4, 58, BtnsWidth, 50);
    
    CGFloat secondPageX = _Button6.frame.origin.x+BtnsWidth+30;
    _Button7.frame = CGRectMake(secondPageX, 4, BtnsWidth, 50);
    _Button8.frame = CGRectMake(secondPageX+BtnsWidth+4, 4, BtnsWidth, 50);
    _Button9.frame = CGRectMake(_Button8.frame.origin.x+BtnsWidth+4, 4, BtnsWidth, 50);
    
    _Button10.frame = CGRectMake(secondPageX, 58, BtnsWidth, 50);
    _Button11.frame = CGRectMake(secondPageX+BtnsWidth+4, 58, BtnsWidth, 50);
    _Button12.frame = CGRectMake(_Button11.frame.origin.x+BtnsWidth+4, 58, BtnsWidth, 50);
    
    [self customStyle];
    
    [btnsArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [button addTarget:self action:@selector(buttonsTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addLayerToButton:button];
        if (self.btnTitleFont != nil) {
            [[button titleLabel] setFont:self.btnTitleFont];
        }
        if (self.btnsBackgroundColor != nil) {
            [button setBackgroundColor:self.btnsBackgroundColor];
        }
        
        if (self.btnsNormalTitleColor != nil) {
            [button setTitleColor:self.btnsNormalTitleColor forState:UIControlStateNormal];
        }
        
        if (self.btnsHightlightTitleColor != nil) {
            [button setTitleColor:self.btnsHightlightTitleColor forState:UIControlStateHighlighted];
        }
    }];
    if (self.blurBgEffectStyle) {
        blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)self.blurBgEffectStyle];
    } else {
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    [visualEffectView setEffect:blurEffect];
    
    CGRect currentRect = self.frame;
    if (CGRectContainsRect(self.superview.frame, self.frame)) {
        // Completely Inside

    } else {
        if (self.frame.origin.y < self.superview.frame.origin.y) {
            //vertically outside up
        } else if (self.frame.origin.y+self.frame.size.height > self.superview.frame.size.height) {
            //vertically outside down
            currentRect.origin.y = self.superview.frame.size.height/2;
            self.frame = currentRect;
        } else if (self.frame.origin.x < self.superview.frame.origin.x) {
            //  horizontally outside left
        } else if (self.frame.origin.x+self.frame.size.width > self.superview.frame.size.width) {
            //  horizontally outside right
            currentRect.origin.x = self.superview.frame.size.width/5;
            self.frame = currentRect;
        }
    }
}

- (void)updateViewFrame:(CGRect)nFrame {
    if (!CGRectIsEmpty(nFrame)) {
        [self setFrame:nFrame];
        [visualEffectView setFrame:CGRectMake(0, 0, nFrame.size.width, nFrame.size.height)];
    } else {
        if (_mainBtnsArray.count < 4) {
            CGRect newFrame = self.frame;
            newFrame.size.width = self.frame.size.width;
            newFrame.size.height = self.frame.size.height-54;
            [self setFrame:newFrame];
        }
    }
}

- (void)addSliderView:(SBKSliderView *)sliderView {
    _sliderView = sliderView;
    [self insertSubview:_sliderView aboveSubview:visualEffectView];
}

- (void)removeSliderView {
    [_sliderView removeFromSuperview];
}

- (void)addView:(UIView *)view {
    _newView = view;
    [self insertSubview:_newView aboveSubview:visualEffectView];
}

- (void)removeView {
    [_newView removeFromSuperview];
}

- (void)buttonsTapped:(UIButton *)button {
    self.actionBlock(button, button.titleLabel.text, self, self.textView);
}

- (NSInteger)numberOfPages {
    return 2;
}

- (void)addLayerToButton:(UIButton *)button {
    button.layer.masksToBounds = YES;
    [button setClipsToBounds:YES];
    [button.layer setCornerRadius:5];
    if (self.mainCornerRadius) {
        [button.layer setCornerRadius:self.mainCornerRadius];
    }
}

- (UIButton *)customButtonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[button titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[SBKMenuView hex:@"#4C4C4C"] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[SBKMenuView hex:@"#232323"]];
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:16]];
    return button;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    return;
}

#pragma mark - Private
+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    
    return hexComponent / 255.0;
}
+ (UIColor *)hex:(NSString *)hexString
{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch([colorString length])
    {
        case 3: // #RGB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:1];
            green = [self colorComponentFrom:colorString start:1 length:1];
            blue = [self colorComponentFrom:colorString start:2 length:1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom:colorString start:0 length:1];
            red = [self colorComponentFrom:colorString start:1 length:1];
            green = [self colorComponentFrom:colorString start:2 length:1];
            blue = [self colorComponentFrom:colorString start:3 length:1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red = [self colorComponentFrom:colorString start:0 length:2];
            green = [self colorComponentFrom:colorString start:2 length:2];
            blue = [self colorComponentFrom:colorString start:4 length:2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom:colorString start:0 length:2];
            red = [self colorComponentFrom:colorString start:2 length:2];
            green = [self colorComponentFrom:colorString start:4 length:2];
            blue = [self colorComponentFrom:colorString start:6 length:2];
            break;
        default:
            return nil;
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
