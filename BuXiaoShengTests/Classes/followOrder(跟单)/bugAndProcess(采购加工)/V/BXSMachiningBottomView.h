//
//  BXSMachiningBottomView.h
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 加工类似的底部按钮

#import <UIKit/UIKit.h>

@interface BXSMachiningBottomView : UIView

/// 构造方法
+ (instancetype)bottomView;

/// 点击底部确定按钮
@property (copy,nonatomic)void (^clickBottomTrue)(void);
/// 设置需求量／总数量数据
- (void)setupCount:(NSString *)upCount
       bottomCount:(NSString *)bottomCount;
///总数量数据<调用用这个方法那么只有一个总数量／隐藏总需求量>
- (void)setupCoun:(NSString *)upCount;
@end
