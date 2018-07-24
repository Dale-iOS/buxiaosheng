//
//  UIBarButtonItem+CJExtension.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CJExtension)

+ (instancetype)itemWithTitle:(NSString *)title norColor:(UIColor *)norColor targer:(id)target action:(SEL)action;

@end
