//
//  BankDetailListTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZBankListListModel;
@interface BankDetailListTableViewCell : UITableViewCell
@property(nonatomic,strong)LZBankListListModel *model;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///标题
@property (nonatomic, strong) UILabel *titleLabel;

///银行名称
@property (nonatomic, strong) UILabel *bankLabel;

///日期
@property (nonatomic, strong) UILabel *dateLabel;

///金额变化
@property (nonatomic, strong) UILabel *moneyLabel;

@end
