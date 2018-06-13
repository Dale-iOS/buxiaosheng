//
//  LZNoBackOrderCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZNoBackOrderModel;

@protocol LZNoBackOrderCellDelegate <NSObject>

- (void)didClickgoAuditBtnInCell:(UITableViewCell *)cell;

@end

@interface LZNoBackOrderCell : UITableViewCell

@property (nonatomic, weak) id<LZNoBackOrderCellDelegate> delegate;

@property (nonatomic, strong) LZNoBackOrderModel *model;

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

///入库数
@property (nonatomic, strong) UILabel *toWarehouseLabel;

///品名
@property (nonatomic, strong) UILabel *titleLabel;

///金额
@property (nonatomic, strong) UILabel *priceLabel;

///分割线
@property (nonatomic, strong) UIView *lineView;

///时间
@property (nonatomic, strong) UILabel *timeLabel;

///同意按钮
@property (nonatomic, strong) UIButton *goAuditBtn;

@end
