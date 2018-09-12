//
//  PurchaseCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "JGPurchaseCollectionViewCell.h"

@implementation JGPurchaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setItemModel:(LZPurchasingInfoDetailItemListModel *)itemModel
{
    _productColorNameLB.text = [NSString stringWithFormat:@"颜色：%@",itemModel.productColorName];
    _numberLB.text = [NSString stringWithFormat:@"需求量：%@",itemModel.number];
}

@end
