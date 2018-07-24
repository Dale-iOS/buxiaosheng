//
//  UIBarButtonItem+CJExtension.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "UIBarButtonItem+CJExtension.h"

@implementation UIBarButtonItem (CJExtension)

+ (instancetype)itemWithTitle:(NSString *)title norColor:(UIColor *)norColor targer:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:norColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return [[self alloc] initWithCustomView:btn];
}

@end
