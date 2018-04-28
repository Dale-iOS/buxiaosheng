//
//  StockTrackingCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockTrackingCell : UITableViewCell

///白色底图
@property (nonatomic, strong)UIView *bgView;

///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;

///标题
@property (nonatomic, strong) UILabel *titleLabel;

///状态
@property (nonatomic, strong) UILabel *stateLabel;

///内容 副标题
@property (nonatomic, strong) UILabel *subLabel;

///时间
@property (nonatomic, strong) UILabel *timeLabel;

///需求量
@property (nonatomic, strong) UILabel *demandNumLabel;

///类型
@property (nonatomic, strong) UILabel *typeLabel;

///入库数
@property (nonatomic, strong) UILabel *StorageNumLabel;

///左边红view
@property (nonatomic, strong) UIView *redLeftView;

@end
