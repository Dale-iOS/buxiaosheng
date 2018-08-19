//
//  UIButton+Category.h
//  JDemo
//
//  Created by BangYou on 2018/1/18.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

@property (assign, nonatomic) UIEdgeInsets expandHitEdgeInsets;
 
/*!
 * @style 方向
 * @space 文字距图片的距离
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

/// 构造一个上面图片下面文字的按钮（使用sd_）
+ (instancetype)initWithBottomLabelHeight:(CGFloat)height;

///使用sd_布局依赖sdlayout
- (void)setupSDLayoutWithInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end
