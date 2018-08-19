//  Created by 王猛 on 16/2/4.
//  Copyright © 2016年 WM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WM)

- (void)setButtonCorner:(CGFloat)corner;

//设置按钮的正常图片、高亮图片
- (void)setImage:(UIImage *)image h_Image:(UIImage *)highImage;

//设置按钮的正常图片、选中图片
- (void)setImage:(UIImage *)image selected_Image:(UIImage *)selected_Image;

//设置按钮的文字、文字颜色、背景颜色、状态、方法、事件触发
- (void)setTitle:(NSString *)title font:(CGFloat)font titleColor:(UIColor *)color bgcolor:(UIColor *)bgcolor forState:(UIControlState)state target:(id)target action:(SEL)action controlEvents:(UIControlEvents)event;

//设置按钮的文字、背景颜色、方法 背景图片为蓝色
- (void)setButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor target:(id)target sel:(SEL)sel;

//设置按钮的文字、背景颜色、方法 图片
- (void)setButtonWithTitle:(NSString *)title bgColor:(UIColor *)bgColor imageName:(NSString *)imageName target:(id)target sel:(SEL)sel;

//文字大小
- (void)setButtonWithTitle:(NSString *)title font:(CGFloat)fontSize bgColor:(UIColor *)bgColor imageName:(NSString *)imageName target:(id)target sel:(SEL)sel;

//设置按钮方法 背景图片
- (void)setButtonWithBgImage:(UIImage *)image target:(id)target sel:(SEL)sel;

//设置按钮文字，按钮选中、正常的图片固定
- (void)setButtonWithTitle:(NSString *)title target:(id)target sel:(SEL)sel;

/*
 *
 *  @brief 标题在上 图片在下
 *
 *  @param space 它们之间的间距
 */

/**  设置标题在图片上方  */
- (void)titleOverTheImageTopWithSpace:(CGFloat)space;

/*
 *
 *  @brief  图片在上 标题在下
 *
 *  @param space 它们之间的间距
 */

- (void)titleBelowTheImageWithSpace:(CGFloat)space;

/*
 *
 *  @brief  图片在左 标题在右 (系统默认的也是这种 这里提供设置间距的接口)
 *
 *  @param space 它们之间的间距
 */
- (void)imageOnTheTitleLeftWithSpace:(CGFloat)space;

/*
 *
 *  @brief  标题在左    图片在右
 *
 *  @param space 它们之间的间距
 */
- (void)imageOnTheTitleRightWithSpace:(CGFloat)space;

@end
