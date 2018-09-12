//
//  LZPurchaseReceivingListCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZPurchaseReceivingListModel;

@interface LZPurchaseReceivingListCell : UITableViewCell
///白色底图
@property (nonatomic, strong)UIView *bgView;
///仓库
@property (nonatomic, strong) UILabel *warehouseLabel;
///数量
@property (nonatomic, strong) UILabel *numLabel;
///金额
@property (nonatomic, strong) UILabel *priceLabel;
///时间
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) LZPurchaseReceivingListModel *model;
@end
