//
//  BXSMachiningProduuctCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableCell.h"
#import "LZPurchaseModel.h"

@interface BXSMachiningProduuctCell : BaseTableCell

/// 产品模型
@property (strong,nonatomic)LZPurchaseModel *productModel;


@property (strong,nonatomic)BaseTableVC *contentVC;


@property (copy,nonatomic)void (^getBottomDataBlock)(void);



- (CGFloat)tableViewHeight;
@end
