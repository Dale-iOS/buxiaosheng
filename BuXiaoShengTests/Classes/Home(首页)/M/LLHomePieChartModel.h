//
//  LLHomePieChartModel.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/7/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLBigGoodsListModel;
@class LLSaleListModel;
@class LLSheetClothListModel;
@class LLTurnoverListModel;
@interface LLHomePieChartModel:NSObject
@property(nonatomic ,copy)NSArray <LLBigGoodsListModel*> * bigGoodsList;
@property(nonatomic ,copy)NSArray <LLSaleListModel*>* saleList;
@property(nonatomic ,copy)NSArray <LLSheetClothListModel*>* sheetClothList;
@property(nonatomic ,copy)NSArray <LLTurnoverListModel*>* turnoverList;
@end

@interface LLBigGoodsListModel : NSObject
@property(nonatomic ,assign)NSUInteger  number;
@property(nonatomic ,copy)NSString * productName;
@end

@interface LLSaleListModel : NSObject
@property(nonatomic ,assign)NSUInteger  number;
@property(nonatomic ,copy)NSString * memberName;
@end

@interface LLSheetClothListModel : NSObject
@property(nonatomic ,assign)NSUInteger  number;
@property(nonatomic ,copy)NSString * productName;
@end

@interface LLTurnoverListModel : NSObject
@property(nonatomic ,assign)NSUInteger  amount;
@property(nonatomic ,copy)NSString * date;
@end
