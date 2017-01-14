//
//  QBPopupMenuItem.h
//  QBPopupMenu
//
//  Created by Tanaka Katsuma on 2013/11/22.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBPopupMenuItem : NSObject

@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)itemWithTitle:(NSString *)titleString image:(UIImage *)image target:(id)target action:(SEL)action;

@end
