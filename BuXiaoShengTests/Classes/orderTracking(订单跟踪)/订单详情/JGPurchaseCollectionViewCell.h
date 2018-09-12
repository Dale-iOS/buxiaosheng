//
//  PurchaseCollectionViewCell.h
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZPurchasingInfoDetailModel.h"
@interface JGPurchaseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *productColorNameLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (nonatomic, strong) LZPurchasingInfoDetailItemListModel *itemModel;
@end
