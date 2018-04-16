//
//  OrderTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

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

///订单状态
@property (nonatomic, strong)UILabel *stateLabel;

///配送信息
@property (nonatomic, strong)UILabel *distributionLabel;


@end
