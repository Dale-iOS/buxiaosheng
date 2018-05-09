//
//  InventoryCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InventoryCell : UITableViewCell

///底图
@property (nonatomic, strong) UIView *bgView;

///圆角背景
@property (nonatomic, strong) UIView *cornerWhiteBgView;

///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;

///标题
@property (nonatomic, strong) UILabel *titleLabel;

///米数
@property (nonatomic, strong) UILabel *meterLabel;

///码数
@property (nonatomic, strong) UILabel *codeLabel;

///公斤
@property (nonatomic, strong) UILabel *kgLabel;

///底角背景
@property (nonatomic, strong) UIView *bottomBgView;

@end
