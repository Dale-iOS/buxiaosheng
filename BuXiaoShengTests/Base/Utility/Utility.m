//
//  Utility.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "Utility.h"

@implementation Utility

//!!!!: 创建navigation title view
/**
 *    @brief    创建navigation title view
 *
 *    @param     _title     标题
 *
 *    @return    view
 */
+ (UIView *)navTitleView:(NSString *)_title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    //lab.backgroundColor = [UIColor redColor];
    
    //lab.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor = [UIColor blackColor];
    // lab.alpha=0.5;
    
    lab.text = _title;
    return lab;
}

+ (UIView *)navWhiteTitleView:(NSString *)_title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.backgroundColor = [UIColor clearColor];
    //lab.backgroundColor = [UIColor redColor];
    
    //lab.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.textColor = [UIColor whiteColor];
    // lab.alpha=0.5;
    
    lab.text = _title;
    return lab;
}

//!!!!: 通用navigation 返回按钮
/**
 *    @brief    通用navigation 返回按钮
 *
 *    @param     _target     接收对象
 *    @param     selector    调用方法
 *
 *    @return    BarButtonItem
 */
+ (UIBarButtonItem *)navLeftBackBtn:(id)_target action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0,0, 60, 40)];
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    //    [btn setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    //    btn.imageEdgeInsets = UIEdgeInsetsMake(6, -3, 6, 35);
    
    UIImageView *backIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0,(btn.height-19)/2, 19,18)];
    backIcon.backgroundColor = [UIColor clearColor];
    backIcon.image = [UIImage imageNamed:@"back"];
    [btn addSubview:backIcon];
    
    UIBarButtonItem *left_btn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return left_btn;
}



/**
 *  右按钮是图片的
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param image    图片
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 25, 44);
    [btn setImage:image forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}


/**
 *  右按钮是文字的
 *
 *  @param _target  对象
 *  @param selector 方法
 *  @param string   文字
 *
 *  @return
 */
+ (UIBarButtonItem *)navButton:(id)_target action:(SEL)selector title:(NSString *)string
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(0, 0, 25, 44);
    [btn setTitle:string forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(14);
    [btn addTarget:_target action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIViewController *)getVCAtView:(UIView *)selfView WithVcClass:(Class )vcClass {
    for (UIView* next = selfView; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:vcClass]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
    
}

//!!!!: 设置图片的颜色和尺寸
/**
 *  设置图片的颜色和尺寸
 *
 *  @param color 颜色
 *  @param size  尺寸
 *
 *  @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    // color=[UIColor colorWithRed:155 green:155 blue:155 alpha:0.3];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    // CGContextSetAlpha(context, 0.3);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //CGContextDrawImage(context, rect, image.CGImage);
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
