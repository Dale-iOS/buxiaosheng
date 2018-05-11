//
//  CashBankTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLCashBankModel;
#import <UIKit/UIKit.h>

@interface CashBankTableViewCell : UITableViewCell

///白色底图
@property (nonatomic, strong)UIView *bgView;

///银行图标
@property (nonatomic, strong)UIImageView *iconImageView;

///银行名字
@property (nonatomic, strong)UILabel *titleLabel;

///右箭头
@property (nonatomic, strong) UIImageView *rightArrowImageVIew;

@property (nonatomic,strong) LLCashBankModel * model;

@end
