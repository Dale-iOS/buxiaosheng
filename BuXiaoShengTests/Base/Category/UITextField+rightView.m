//
//  UITextField+rightView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "UITextField+rightView.h"

@implementation UITextField_rightView

- (CGRect) rightViewRectForBounds:(CGRect)bounds {
    CGRect textRect = [super rightViewRectForBounds:bounds];
    textRect.origin.x -= 10;
    return textRect;
}


@end
