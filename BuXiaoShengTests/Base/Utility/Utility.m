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

@end
