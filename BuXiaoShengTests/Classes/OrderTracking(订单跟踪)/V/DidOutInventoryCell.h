//
//  DidOutInventoryCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

@class LZOrderTrackingModel;
#import <UIKit/UIKit.h>

@interface DidOutInventoryCell : UITableViewCell

@property(nonatomic,strong)LZOrderTrackingModel *model;

///白色底图
@property (nonatomic, strong)UIView *bgView;

///头像
@property (nonatomic, strong)UIImageView *iconImageView;

///厂名字
@property (nonatomic, strong)UILabel *companyLabel;

///布名字
@property (nonatomic, strong)UILabel *nameLabel;

///需求量
@property (nonatomic, strong)UILabel *demandLabel;

///出库数
@property (nonatomic, strong)UILabel *OutNumLabel;

///价格
@property (nonatomic, strong)UILabel *priceLabel;

///时间
@property (nonatomic, strong)UILabel *timeLabel;

///已出库运输中
@property (nonatomic, strong)UILabel *transportLabel;

///已出库待送货
@property (nonatomic, strong)UILabel *didTransportLabel;

///收货
@property (nonatomic, strong)UILabel *receivingLabel;

///图标名字
@property (nonatomic, strong)UILabel *iconLabel;


@end
