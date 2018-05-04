//
//  UIButton+KYTouch.h
//  TestCell
//
//  Created by Frank on 17/1/4.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .1// 默认间隔时间

@interface UIButton (KYTouch)
/**
 *  设置点击时间间隔
 */
@property (nonatomic, assign) NSTimeInterval timeInterVal;



/*
 *    倒计时按钮
 *    @param timeLine  倒计时总时间
 *    @param title     还没倒计时的title
 *    @param subTitle  倒计时的子名字 如：时、分
 *    @param mColor    还没倒计时的颜色
 *    @param color     倒计时的颜色
 */

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
@end
