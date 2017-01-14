//
//  SBKDisplayImageView.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 13/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKDisplayImageView.h"


#define MINIMUM_SCALE 0.5
#define MAXIMUM_SCALE 4.0
static GestureActionCompletionBlock _gestureBlock;
static MenuActionCompletionBlock _itemActionBlock;

@interface SBKDisplayImageView ()
@property CGPoint translation;
@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (nonatomic, strong) QBPlasticPopupMenu *plasticPopupMenu;
@end

@implementation SBKDisplayImageView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentMode:UIViewContentModeScaleAspectFit];
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        QBPopupMenuItem *addTextItem = [QBPopupMenuItem itemWithTitle:@"Add Text" image:nil target:self action:@selector(action:)];
        
        QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:@[addTextItem]];
        popupMenu.highlightedColor = [[UIColor colorWithRed:0 green:0.478 blue:1.0 alpha:1.0] colorWithAlphaComponent:0.8];
        self.popupMenu = popupMenu;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinchGesture];
        [self setImageShadowColor:[UIColor blackColor] radius:5 offset:CGSizeMake(1, 1) opacity:0.5];
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [self addGestureRecognizer:panGesture];
        
    }
    return self;
}

- (void)setImageShadowColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset opacity:(CGFloat)opacity
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}
- (void)action:(QBPopupMenuItem *)item
{
    if (self.itemActionBlock) {
        self.itemActionBlock(self, item);
    }
}

- (void)handleTapFrom:(UITapGestureRecognizer *)gesture {
    CGPoint pointGesture = [gesture locationInView:[gesture.view superview]];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _touchedPoint = pointGesture;
        [self.popupMenu showInView:self.superview targetRect:CGRectMake(pointGesture.x, pointGesture.y, 0, 0) animated:YES];
    }
    
    if (self.gestureBlock)
        self.gestureBlock(gesture, pointGesture);
}

//- (void)pan:(UIPanGestureRecognizer *)gesture {
//    static CGPoint currentTranslation;
//    static CGFloat currentScale = 0;
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        currentTranslation = _translation;
//        currentScale = self.frame.size.width / self.bounds.size.width;
//    }
//    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateChanged) {
//        
//        CGPoint translation = [gesture translationInView:self];
//        
//        _translation.x = translation.x + currentTranslation.x;
//        _translation.y = translation.y + currentTranslation.y;
//        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(_translation.x , _translation.y);
//        CGAffineTransform transform2 = CGAffineTransformMakeScale(currentScale, currentScale);
//        CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
//        self.transform = transform;
//    }
//}


- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateChanged) {
        //        NSLog(@"gesture.scale = %f", gesture.scale);
        
        CGFloat currentScale = self.frame.size.width / self.bounds.size.width;
        CGFloat newScale = currentScale * gesture.scale;
        
        if (newScale < MINIMUM_SCALE) {
            newScale = MINIMUM_SCALE;
        }
        if (newScale > MAXIMUM_SCALE) {
            newScale = MAXIMUM_SCALE;
        }
        
        CGAffineTransform transform1 = CGAffineTransformMakeTranslation(_translation.x, _translation.y);
        CGAffineTransform transform2 = CGAffineTransformMakeScale(newScale, newScale);
        CGAffineTransform transform = CGAffineTransformConcat(transform1, transform2);
        self.transform = transform;
        gesture.scale = 1;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

- (GestureActionCompletionBlock)gestureBlock
{
    return _gestureBlock;
}
- (void)setGestureBlock:(GestureActionCompletionBlock)gestureBlock
{
    if (gestureBlock) {
        _gestureBlock = [gestureBlock copy];
    }
}

- (MenuActionCompletionBlock)itemActionBlock
{
    return _itemActionBlock;
}
- (void)setItemActionBlock:(MenuActionCompletionBlock)itemActionBlock
{
    if (itemActionBlock) {
        _itemActionBlock = [itemActionBlock copy];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
