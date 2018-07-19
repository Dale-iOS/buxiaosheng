//
//  LZSalesDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZSalesDetailItemListModel;

@interface LZSalesDetailModel : NSObject
@property(nonatomic,copy)NSString *bankName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *customerMobile;
@property(nonatomic,copy)NSString *customerName;
@property(nonatomic,copy)NSString *deposit;
@property(nonatomic,copy)NSString *drawerName;
@property(nonatomic,copy)NSString *imgs;
@property(nonatomic,copy)NSArray<LZSalesDetailItemListModel*> *itemList;
@property(nonatomic,copy)NSString *matter;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,copy)NSString *remark;
@end


@interface LZSalesDetailItemListModel : NSObject
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productColorName;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *unitName;
@end
