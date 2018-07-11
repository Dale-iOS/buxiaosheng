//
//  LZDidBugAndProcessUntreatedCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZBugAndProcessBssModel;
@interface LZDidBugAndProcessUntreatedCell : UITableViewCell
///白色底图
@property (nonatomic, strong)UIView *bgView;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;
///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;
///标题
@property (nonatomic, strong) UILabel *titleLabel;
///内容 副标题
@property (nonatomic, strong) UILabel *subLabel;
///需求量
@property (nonatomic, strong) UILabel *demandLabel;
///时间
@property (nonatomic, strong) UILabel *timeLabel;
///状态
@property (nonatomic, strong) UILabel *stateLabel;
@property(nonatomic,strong)LZBugAndProcessBssModel *model;
@end
