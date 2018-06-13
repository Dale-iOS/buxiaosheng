//
//  LZDidNoBackOrderCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZNoBackOrderModel;

@interface LZDidNoBackOrderCell : UITableViewCell
@property(nonatomic,strong)LZNoBackOrderModel *model;
///白色底图
@property (nonatomic, strong)UIView *bgView;

///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;

///标题
@property (nonatomic, strong) UILabel *nameLabel;

///副标题
@property (nonatomic, strong) UILabel *subLabel;

///需求量
@property (nonatomic, strong) UILabel *demandLabel;

///品名
@property (nonatomic, strong) UILabel *titleLabel;

///金额
@property (nonatomic, strong) UILabel *priceLabel;

///时间
@property (nonatomic, strong) UILabel *timeLabel;

///提示
//@property (nonatomic, strong) UILabel *subLabel;

///审批图标
@property (nonatomic,strong)UIImageView *auditIMV;
@end
