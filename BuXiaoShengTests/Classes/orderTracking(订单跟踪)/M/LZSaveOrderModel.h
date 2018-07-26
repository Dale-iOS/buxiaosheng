//
//  LZSaveOrderModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZSaveOrderItemList :NSObject
@property (nonatomic,copy) NSString *value;//细码值
@property (nonatomic,copy) NSString *outNumber;//条数
@end

@interface LZSaveOrderProductList :NSObject
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productColorId;
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSArray<LZSaveOrderItemList *> *itemList;
@end

@interface LZSaveOrderModel : NSObject
@property (nonatomic,copy) NSString *total;//出库条数合计
@property (nonatomic,copy) NSString *outNumber;//出库数量
@property (nonatomic,copy) NSString *labelNumber;//标签数量
@property (nonatomic,copy) NSString *settleNumber;//结算数量
@property (nonatomic,copy) NSString *receivablePrice;//本单应收金额
@property (nonatomic,copy) NSString *netreceiptsPrice;//实收金额
@property (nonatomic,copy) NSString *depositPrice;//预收定金
@property (nonatomic,copy) NSString *trimPrice;//调整金额
@property (nonatomic,copy) NSString *arrearsPrice;//本单欠款
@property (nonatomic,copy) NSString *bankId;//银行id
@property (nonatomic,copy) NSString *remark;//备注内容
@property (nonatomic,copy) NSString *singleType;//0:大货 1:板布
@property (nonatomic,copy) NSString *type;//0:真单 1:假单
@property (nonatomic,copy) NSArray<LZSaveOrderProductList *> *productList;
@end
