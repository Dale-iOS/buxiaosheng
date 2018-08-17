//
//  LZPurchaseModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 产品模型

#import <Foundation/Foundation.h>
@class LZPurchaseItemListModel;

@interface LZPurchaseModel : NSObject
@property(nonatomic,copy)NSArray <LZPurchaseItemListModel*> *itemList;
@property(nonatomic,copy)NSString *productId;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *totalNumber;


@property (assign,nonatomic) CGFloat cellHeight;
@property (assign,nonatomic) BOOL isShow;

//j
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@end




@class BXSDSModel;
@interface LZPurchaseItemListModel : BaseModel
@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorId;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *total;


///j
@property(nonatomic,copy)NSString *productName;
@property (copy,nonatomic)NSMutableArray <BXSDSModel *>*dsArray;

@end
