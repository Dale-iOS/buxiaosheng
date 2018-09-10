//
//  BXSStockPurchaseVC.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableVC.h"

@interface BXSStockPurchaseVC : BaseTableVC
/**
 请求商品名后成功后的回调
*productsListNameArray;//展示图产品列表名称数组
*productsListIdArray;//展示图产品列表ID数组
 */
@property(nonatomic,copy)void(^requestProductListBlock)(NSMutableArray *productsListNameArray,NSMutableArray *productsListIdArray);

@end
