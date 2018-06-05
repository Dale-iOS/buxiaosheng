//
//  LZVisitRecordCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

@class LZVisitModel;
#import <UIKit/UIKit.h>

@interface LZVisitRecordCell : UITableViewCell
@property(nonatomic,strong)LZVisitModel *model;
///白色底图
@property (nonatomic, strong)UIView *bgView;
///头像
@property (nonatomic, strong)UIImageView *iconImageView;
///图标名字
@property (nonatomic, strong)UILabel *iconLabel;
///拜访方式
@property (nonatomic, strong)UILabel *typeLabel;
///对象名字
@property (nonatomic, strong)UILabel *nameLabel;
///主要事宜
@property (nonatomic, strong)UILabel *matterLabel;
///时间
@property (nonatomic, strong)UILabel *timeLabel;
@end
