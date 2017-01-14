//
//  SBKDisplayImageView.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 13/10/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBPopupMenu.h"
#import "QBPlasticPopupMenu.h"

@class SBKDisplayImageView;
typedef void(^GestureActionCompletionBlock)(UITapGestureRecognizer *gesture, CGPoint touchPoint);
typedef void(^MenuActionCompletionBlock)(SBKDisplayImageView *imageView, QBPopupMenuItem *item);

@interface SBKDisplayImageView : UIImageView
@property (strong, nonatomic) GestureActionCompletionBlock gestureBlock;
@property (strong, nonatomic) MenuActionCompletionBlock itemActionBlock;
@property (nonatomic, assign) CGPoint touchedPoint;
@property(nonatomic) CGFloat scaleBaseWidth;
@property(nonatomic) CGFloat scaleBaseHeight;
//@property(nonatomic) CGRect baseRect;
@end
