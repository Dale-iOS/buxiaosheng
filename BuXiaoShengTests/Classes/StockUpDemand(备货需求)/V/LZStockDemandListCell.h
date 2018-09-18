//
//  LZStockDemandListCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZStockDemandListModel;

@protocol LZStockDemandListCellDelegate <NSObject>
- (void)didstockListBtnInCell:(UITableViewCell *)cell;
@end

@interface LZStockDemandListCell : UITableViewCell
@property (nonatomic,weak) id<LZStockDemandListCellDelegate> delegate;
@property (nonatomic, strong) LZStockDemandListModel *model;
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
///日期
@property (nonatomic, strong) UILabel *dateLabel;
///状态
@property (nonatomic, strong) UILabel *stateLabel;
///备货列表按钮
@property(nonatomic,strong)UIButton *stockListBtn;
@end
