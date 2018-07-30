//
//  BYAlertHeadView.h
//  BangYou
//
//  Created by BangYou on 2017/9/28.
//  Copyright © 2017年 李麒. All rights reserved.
//

/*
 1 弹出框的头部上方带圆角
 2 左边文字 右边一个x的箭头 52 *kW
 3 评论弹出框-优惠卷弹出框等等
 
 */
#import <UIKit/UIKit.h>

@interface BYAlertHeadView : UIView

@property (nonatomic,strong)NSString *title;

@property (nonatomic,copy)void (^clickCancleBlock)(void);
+ (instancetype)alertHeaderTitle:(NSString *)title;


@end
