//
//  Utility.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

//创建navigation title
+ (UIView *)navTitleView:(NSString *)_title;
+ (UIView *)navWhiteTitleView:(NSString *)_title;

//+ (UIView *)navTitleView2:(NSString *)_title;
//
//+ (UIView *)navTitleViewSessionList:(NSString *)_title;

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;
//创建navigation 右按钮是图片的
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image;
//创建navigation 右按钮是文字的
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector title:(NSString *)string;
//颜色转换图片
+(UIImage*) createImageWithColor:(UIColor*) color;

+(UIViewController *)getVCAtView:(UIView *)selfView WithVcClass:(Class )vcClass;
//图片的颜色和尺寸
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
