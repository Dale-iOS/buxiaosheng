//
//  OrderTotalCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ReTotalCell.h"

@implementation ReTotalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    NSInteger totalPrice = 0;
    NSInteger total = 0;
    
    LZPurchaseReceivingListDetailProductModel *detailModel = dataArray.firstObject;
    for (int i = 0; i <detailModel.colorList.count; i++) {
        LZPurchaseReceivingListDetailProductColorListModel *colorModel = detailModel.colorList[i];

        for (int j = 0; j < colorModel.valList.count; j++) {
            LZPurchaseReceivingListDetailProductValListModel *vaListModel = colorModel.valList[j];
            totalPrice += colorModel.price.integerValue * vaListModel.value.integerValue;
            total += vaListModel.total.integerValue;
        }

    }
    
//    for (LZPurchaseReceivingListDetailProductModel *productModel in dataArray) {
//
//        number += [productModel.totalNumber doubleValue];
//        total += [productModel.total integerValue];
//
//    }
//    for (int i = 0; i <productModel.colorList.count; i++) {
//        LZPurchaseReceivingListDetailProductColorListModel *colorModel = productModel.colorList[i];
//        //本单应收金额计算
//        NSInteger shouldPrice = 0;
//        for (int j = 0; j < colorModel.valList.count; j++) {
//            LZPurchaseReceivingListDetailProductValListModel *vaListModel = colorModel.valList[j];
//            shouldPrice += colorModel.price.integerValue * vaListModel.value.integerValue;
//        }
//        self.yfLb.text = [NSString stringWithFormat:@"%ld",shouldPrice];
//    }
    self.totalNumberLB.text = [NSString stringWithFormat:@"总条数：%ld",(long)total];
    NSString *tempStr = [NSString stringWithFormat:@"%ld",totalPrice];
    //假如细码值有小数，就只保留一位小数
    if ([tempStr containsString:@"."]) {
        self.totalTiaoLB.text = [NSString stringWithFormat:@"总金额：%.1f",tempStr.doubleValue];
    }else{
        self.totalTiaoLB.text = [NSString stringWithFormat:@"总金额：%ld",tempStr.integerValue];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
