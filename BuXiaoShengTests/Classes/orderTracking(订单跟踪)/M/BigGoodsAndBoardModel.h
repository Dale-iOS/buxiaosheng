//
//  BigGoodsAndBoardModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ItemList :NSObject
@property (nonatomic , copy) NSString              * total;
@property (nonatomic , copy) NSString              * value;
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * placeholder;

@property (nonatomic , assign) BOOL              isSelect;
@property (nonatomic , assign) BOOL              isContentColorRed;
@property (nonatomic , assign) BOOL              isEditor;
@property (nonatomic , assign) BOOL              isFake; /// 是否是假单

@end

@interface BatchNumberList :NSObject
@property (nonatomic , copy) NSString              * unitName;
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * batchNumber;
@property (nonatomic , copy) NSArray<ItemList *>              * itemList;
@property (nonatomic , copy) NSString              * total;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * productColorName;
@property (nonatomic , copy) NSString              * productName;

@end


@interface BigGoodsAndBoardModel : NSObject
@property (nonatomic , copy) NSString              * number;
@property (nonatomic , copy) NSString              * productColorId;
@property (nonatomic , copy) NSArray<BatchNumberList *>              * batchNumberList;
@property (nonatomic , copy) NSString              * productId;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * productName;
@property (nonatomic , copy) NSString              * unitName;
@property (nonatomic , copy) NSString              * productColorName;
@property (nonatomic , copy) NSString              * total;
@property (nonatomic , copy) NSString              * storageType;

@property (nonatomic , copy) NSString              * customerMobile;
@property (nonatomic , copy) NSString              * customerName;
@property (nonatomic , copy) NSString              * deposit;
@property (nonatomic , assign) BOOL              isFake; /// 是否是假单

@end
