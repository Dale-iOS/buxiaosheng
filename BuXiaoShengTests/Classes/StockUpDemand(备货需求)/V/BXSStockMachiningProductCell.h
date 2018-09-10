//
//  BXSStockMachiningProductCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableCell.h"
#import "LZPurchaseModel.h"
@interface BXSStockMachiningProductCell : BaseTableCell

@property (nonatomic, strong) NSMutableArray *productsListNameArray;//展示图产品列表名称数组
@property (nonatomic, strong) NSMutableArray *productsListIdArray;//展示图产品列表ID数组
/// 产品模型
@property (strong,nonatomic)LZPurchaseModel *productModel;


@property (strong,nonatomic)BaseTableVC *contentVC;


@property (copy,nonatomic)void (^getBottomDataBlock)(void);



- (CGFloat)tableViewHeight;

@end
