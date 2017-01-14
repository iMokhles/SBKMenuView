//
//  QBPopupMenuItem.m
//  QBPopupMenu
//
//  Created by Tanaka Katsuma on 2013/11/22.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBPopupMenuItem.h"

@interface QBPopupMenuItem ()


@end

@implementation QBPopupMenuItem
+ (instancetype)itemWithTitle:(NSString *)titleString image:(UIImage *)image target:(id)target action:(SEL)action {
    QBPopupMenuItem *itemMenu = [[QBPopupMenuItem alloc] init];
    itemMenu.title = titleString;
    itemMenu.image = image;
    itemMenu.target = target;
    itemMenu.action = action;
    
    return itemMenu;
}

@end
