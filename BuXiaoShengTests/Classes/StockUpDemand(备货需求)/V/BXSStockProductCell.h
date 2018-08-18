//
//  BXSStockProductCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 备货需求-采购头部cell
// 请输入产品名称--请选择颜色--请输入数量

#import "BaseTableCell.h"
#import "LZPurchaseModel.h"

@interface BXSStockProductCell : BaseTableCell


@property (strong,nonatomic)LZPurchaseModel *model;
@property (copy,nonatomic)void (^clickSelectColorBlock)(void);
@property (copy,nonatomic)void (^clickNeedGetBottomDataBlock)(void);
@end
