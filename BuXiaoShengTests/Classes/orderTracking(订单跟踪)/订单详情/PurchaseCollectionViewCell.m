//
//  PurchaseCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "PurchaseCollectionViewCell.h"

@implementation PurchaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setItemModel:(LZPurchasingInfoDetailItemListModel *)itemModel
{
    _productColorNameLB.text = itemModel.productColorName;
    _numberLB.text = itemModel.number;
}

@end
