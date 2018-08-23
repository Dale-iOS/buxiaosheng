//
//  LZOrderTrackingListCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZOrderTrackingListModel;

@interface LZOrderTrackingListCell : UITableViewCell
@property (nonatomic, strong) LZOrderTrackingListModel *model;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;
///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;
///厂商名
@property (nonatomic, strong) UILabel *companyLabel;
///品名
@property (nonatomic, strong) UILabel *nameLabel;
///需求量
@property (nonatomic, strong) UILabel *needLabel;
///价格
@property (nonatomic, strong) UILabel *priceLabel;
///日期
@property (nonatomic, strong) UILabel *dateLabel;
@end
