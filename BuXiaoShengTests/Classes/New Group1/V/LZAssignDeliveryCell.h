//
//  LZAssignDeliveryCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZAssignDeliveryListModel;

@interface LZAssignDeliveryCell : UITableViewCell
@property(nonatomic,strong)LZAssignDeliveryListModel *model;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;
///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;
///客户
@property (nonatomic, strong) UILabel *nameLabel;
///内容 副标题
@property (nonatomic, strong) UILabel *subLabel;
///需求量
@property (nonatomic, strong) UILabel *needLabel;
///出库数
@property (nonatomic, strong) UILabel *outLabel;
///时间
@property (nonatomic, strong) UILabel *timeLabel;
///指派
@property (nonatomic, strong) UILabel *assignLabel;

@end
