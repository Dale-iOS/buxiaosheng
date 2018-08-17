//
//  UIButton+KYTouch.h
//  TestCell
//
//  Created by Frank on 17/1/15.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (EdgeInsets)
/*!
 * @style 方向
 * @space 文字距图片的距离
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@property (assign, nonatomic) UIEdgeInsets expandHitEdgeInsets;
@end
