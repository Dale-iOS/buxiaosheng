//
//  OrderTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

@class LZOrderTrackingModel;
#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

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

///采购中
@property (nonatomic, strong)UILabel *procurementLabel;

///采购信息
@property (nonatomic, strong)UILabel *procurementInfoLabel;

///已下单待处理
@property (nonatomic, strong)UILabel *processedLabel;

///图标名字
@property (nonatomic, strong)UILabel *iconLabel;


@end
