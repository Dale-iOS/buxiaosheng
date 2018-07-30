//
//  BYAlertHelper.h
//  BangYou
//
//  Created by BangYou on 2017/9/28.
//  Copyright © 2017年 李麒. All rights reserved.
//

/*
 弹出框管理-组件构造者
 
 eg：
 UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
 btn.backgroundColor = [UIColor redColor];
 btn.frame = CGRectMake(0, 0, kScreenWidth, 120);
 
 UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
 btn1.backgroundColor = [UIColor blueColor];
 btn1.frame = CGRectMake(0, 0, kScreenWidth, 200);
 
 [btn addHanderBlock:^(UIView *sender) {
 [BYAlertHelper hideAlert];
 }];
 [BYAlertHelper sharedBYAlertHelper].addSubviews(@[btn,btn1]).showInWindow();
 
 V1.1.0 添加 BYAlertContentModeTop、BYAlertContentModeCenter和BYAlertContentModeTop功能
 注意:1 addsubviews和addsubview 不能同时使用
     2 必须先执行 addsubview或addsubviews 最后执行show方法
 V1.1.2 添加 BYAlertContentModeLeft和BYAlertContentModeRight功能（待处理）
 */


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BYAlertHeadView.h"
#import "AlertSheet.h"


#import "BYSingleton.h"
typedef NS_ENUM(NSUInteger,BYAlertContentMode) {
    ///内部视图的布局方式
    BYAlertContentModeTop = 0,
    BYAlertContentModeLeft,
    BYAlertContentModeBottom,
    BYAlertContentModeRight,
    BYAlertContentModeCenter,
};


@class BYAlertViewItem,BYAlertHelper;
/// 定义block类型
typedef BYAlertHelper *(^BYAddSubView)(UIView *subView);
typedef BYAlertHelper *(^BYAddSubViews)(NSArray *subViews);
typedef BYAlertHelper *(^BYAlertBackColor)(UIColor *backColor);
typedef BYAlertHelper *(^BYAlertsContentMode)(BYAlertContentMode contentModel);

@interface BYAlertHelper : NSObject
BYSingletonH(BYAlertHelper)
/// 设置配置属性
@property (nonatomic,strong,readonly)BYAlertViewItem *alertItem;
/// 添加多个view 从上往下自然布局
@property (copy,nonatomic)BYAddSubViews addSubviews;
/// 添加一个view
@property (copy,nonatomic)BYAddSubView addSubview ;
/// 默认 有透明的灰暗颜色
@property (copy,nonatomic)BYAlertBackColor backColor;
/// 内部布局方式
@property (copy,nonatomic)BYAlertsContentMode contentModel;

#pragma mark - 显示&隐藏
/// 显示在什么地方
- (void(^)(void))showInWindow;
- (void(^)(UIView *supView))showInView;
/// 隐藏弹出框
+ (void)hideAlert;

@end



@interface BYAlertViewItem :NSObject
/// 背景view
@property (nonatomic,strong)UIView *backView;
/// 默认灰色的背景按钮 默认点击隐藏空控件
@property (nonatomic,strong)UIButton *coverBtn;
/// 设置配置属性
@property (nonatomic,assign)BYAlertContentMode alertContentModel;
@property (nonatomic,strong)NSArray *subViews;
@property (nonatomic,strong)UIView *supView;
@property (nonatomic,strong)UIColor *backColor;
@end





