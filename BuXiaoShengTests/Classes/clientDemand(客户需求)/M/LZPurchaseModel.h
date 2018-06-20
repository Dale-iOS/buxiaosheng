//
//  LZPurchaseModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZPurchaseItemListModel;

@interface LZPurchaseModel : NSObject
@property(nonatomic,copy)NSArray <LZPurchaseItemListModel*> *itemList;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *totalNumber;
@end

@interface LZPurchaseItemListModel : NSObject
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@end
