//
//  SettingCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UIView

///图标
@property (nonatomic, strong) UIImageView *iconImageView;

///标题
@property (nonatomic, strong) UILabel *titleLabel;

///右箭头
@property (nonatomic, strong) UIImageView *rightArrowImageVIew;

///画底部的线
@property (nonatomic, strong) UIView *lineView;

///右侧的文字
@property (nonatomic, strong) UILabel *rigthLabel;

@end
