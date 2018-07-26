//
//  BigGoodsAndBoardModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BigGoodsAndBoardModel.h"

@implementation ItemList
- (id)copyWithZone:(nullable NSZone *)zone{
    ItemList *model = [[self class] allocWithZone:zone];
    model.total = self.total;
    model.value = self.value;
    model.key = self.key;
    model.placeholder = self.placeholder;
    model.isSelect = self.isSelect;
    model.isContentColorRed = self.isContentColorRed;
    model.isEditor = self.isEditor;
    return model;
}

@end


@implementation BatchNumberList


@end


@implementation BigGoodsAndBoardModel
- (id)copyWithZone:(nullable NSZone *)zone{
    BigGoodsAndBoardModel *model1 = [[self class] allocWithZone:zone];
    model1.number = self.number;
    model1.productColorId = self.productColorId;
    model1.batchNumberList = self.batchNumberList;
    model1.productId = self.productId;
    model1.price = self.price;
    model1.productName = self.productName;
    model1.unitName = self.unitName;
    model1.productColorName = self.productColorName;
    model1.total = self.total;
    model1.storageType = self.storageType;
    model1.customerMobile = self.customerMobile;
    model1.customerName = self.customerName;
    model1.deposit = self.deposit;
    
    
    return model1;
}


@end
