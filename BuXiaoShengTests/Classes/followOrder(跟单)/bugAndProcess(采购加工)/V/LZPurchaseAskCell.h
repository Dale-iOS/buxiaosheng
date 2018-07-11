//
//  LZPurchaseAskCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZPurchaseDetailItemListModel;

@interface LZPurchaseAskCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *colorLbl;
@property(nonatomic,strong)UILabel *needLbl;
@property(nonatomic,strong)LZPurchaseDetailItemListModel *model;
@end
