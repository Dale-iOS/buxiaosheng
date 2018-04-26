//
//  AuditTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuditTableViewCellDelegate <NSObject>

- (void)didClickYesBtnInCell:(UITableViewCell *)cell;
- (void)didClickNoBtnInCell:(UITableViewCell *)cell;

@end

@interface AuditTableViewCell : UITableViewCell

@property (nonatomic, weak) id<AuditTableViewCellDelegate> delegate;

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

///金额
@property (nonatomic, strong) UILabel *priceLabel;

///分割线
@property (nonatomic, strong) UIView *lineView;

///时间
@property (nonatomic, strong) UILabel *timeLabel;

///同意按钮
@property (nonatomic, strong) UIButton *yesBtn;

///拒绝按钮
@property (nonatomic, strong) UIButton *noBtn;

///数量
@property (nonatomic, strong) UILabel *NumLabel;


@end
