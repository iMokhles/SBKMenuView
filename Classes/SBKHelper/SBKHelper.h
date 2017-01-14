//
//  SBKHelper.h
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 20/09/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Accounts/Accounts.h>
#import <ImageIO/ImageIO.h>

@interface SBKHelper : NSObject


// Text Methods
+ (CGFloat)widthForText:(NSString *)bodyText withFont:(UIFont *)textFont fromLabel:(UILabel *)textLabel;
+ (CGFloat)heightForText:(NSString*)bodyText withFont:(UIFont *)textFont;
+ (CGRect)getFrameForText:(NSString*)text withY:(float)Y;
@end
