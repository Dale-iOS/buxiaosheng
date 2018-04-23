//
//  bankTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bankTableViewCell : UITableViewCell

///圆角背景
@property (nonatomic, strong) UIView *bgView;

///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///标题
@property (nonatomic, strong) UILabel *titleLabel;

///上期
@property (nonatomic, strong) UILabel *lastLabel;

///新增
@property (nonatomic, strong) UILabel *addLabel;

///累计
@property (nonatomic, strong) UILabel *totalLabel;

///底角背景
@property (nonatomic, strong) UIView *bottomBgView;

@end
