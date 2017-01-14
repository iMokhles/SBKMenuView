//
//  SBKHelper.m
//  SoraBeKetaba
//
//  Created by Mokhlas Hussein on 20/09/15.
//  Copyright © 2015 iMokhles. All rights reserved.
//

#import "SBKHelper.h"
#import <objc/runtime.h>

#define kXLength 299

@implementation SBKHelper

+ (CGSize)sizeWithForText:(NSString*)bodyText font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [bodyText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)sizeWithForText:(NSString*)bodyText font:(UIFont *)font
{
    return [self sizeWithForText:bodyText font:font maxW:MAXFLOAT];
}


+ (CGFloat)heightForText:(NSString*)bodyText withFont:(UIFont *)textFont
{
    float width = bodyText.length*10;
    UIFont *cellFont = textFont; //[UIFont fontWithName:@"Arial" size:14];
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    if (width > [UIScreen mainScreen].bounds.size.width) {
        constraintSize = CGSizeMake(310, MAXFLOAT);
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bodyText];
    //Add LineBreakMode
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    [attributedString setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
    // Add Font
    [attributedString setAttributes:@{NSFontAttributeName:cellFont} range:NSMakeRange(0, attributedString.length)];
    
    //Now let's make the Bounding Rect
    CGSize labelSize = [attributedString boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    CGFloat height = labelSize.height + 10;
    return height;
}

+ (CGFloat)widthForText:(NSString *)bodyText withFont:(UIFont *)textFont fromLabel:(UILabel *)textLabel {
    
//    float width = bodyText.length*10;
//    UIFont *cellFont = textLabel.font; //[UIFont fontWithName:@"Arial" size:14];
//    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
//    if (width > [UIScreen mainScreen].bounds.size.width) {
//        constraintSize = CGSizeMake(310, MAXFLOAT);
//    }
//    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bodyText];
//    //Add LineBreakMode
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
//    [attributedString setAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, attributedString.length)];
//    // Add Font
//    [attributedString setAttributes:@{NSFontAttributeName:cellFont} range:NSMakeRange(0, attributedString.length)];
//    
//    //Now let's make the Bounding Rect
//    CGSize labelSize = [attributedString boundingRectWithSize:constraintSize options:(NSStringDrawingOptions)(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
//    
//    CGFloat sizeWidth = labelSize.width + 10;
    
    CGSize maximumSize = CGSizeMake(300, 9999);
    CGSize myStringSize = [bodyText sizeWithFont:textFont
                               constrainedToSize:maximumSize
                                   lineBreakMode:textLabel.lineBreakMode];
    float width = myStringSize.width*10;
    
    NSLog(@"**** Width: %f == Screen: %f", width, [UIScreen mainScreen].bounds.size.width);
    if (width > [UIScreen mainScreen].bounds.size.width) {
        width = myStringSize.width;
    }
    return width;
}

+ (CGRect)getFrameForText:(NSString*)text withY:(float)Y
{
    float width = text.length * 8;
    return CGRectMake(kXLength - width, Y, width, 20);
}

@end
