//
//  LZCustomerNeedsDetailModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LZCustomerNeedsDetailProductValListModel : NSObject
@property(nonatomic,copy) NSString *total;
@property(nonatomic,copy) NSString *value;
@end


@interface LZCustomerNeedsDetailProductColorListModel : NSObject

@property(nonatomic,copy)NSString *number;
@property(nonatomic,copy)NSString *productColorName;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *unitName;
@property(nonatomic,copy)NSArray <LZCustomerNeedsDetailProductValListModel*> *valList;
@end

@interface LZCustomerNeedsDetailProductModel : NSObject

@property(nonatomic,copy)NSArray <LZCustomerNeedsDetailProductColorListModel*> *colorList;
@property(nonatomic,copy)NSString *productName;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *number;
@end

@interface LZCustomerNeedsDetailModel : NSObject
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *remark;
@property (nonatomic,copy) NSString *matter;
@property (nonatomic,copy) NSString *customerMobile;
@property (nonatomic,copy) NSString *customerName;
@end
