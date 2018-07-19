//
//  LZSalesDetailCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZSaleOrderListCell.h"
#import "LZSalesDetailModel.h"

@interface LZSalesDetailCell : UITableViewCell
///品名
@property (nonatomic,strong)UILabel *titleLBL;
///颜色
@property (nonatomic,strong)UILabel *colorLBL;
///单位
@property (nonatomic,strong)UILabel *unitLBL;
///数量
@property (nonatomic,strong)UILabel *numberLBL;
///单价
@property (nonatomic,strong)UILabel *priceLBL;
@property (nonatomic,strong) LZSalesDetailItemListModel *model;
@end
