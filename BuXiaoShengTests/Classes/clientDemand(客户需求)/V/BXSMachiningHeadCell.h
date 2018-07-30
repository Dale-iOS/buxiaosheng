//
//  BXSMachiningHeadCell.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableCell.h"
#import "LZPurchaseModel.h"
@interface BXSMachiningHeadCell : BaseTableCell



@property (strong,nonatomic)LZPurchaseModel *purchaseModel;

@property (copy,nonatomic)void (^clickShowBlock)(BOOL isShowing);
@end
