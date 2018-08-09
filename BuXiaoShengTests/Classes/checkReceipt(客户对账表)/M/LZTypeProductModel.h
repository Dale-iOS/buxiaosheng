//
//  LZTypeProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZtypeInnerModel : NSObject
@property (nonatomic,strong)NSNumber *price;
@property (nonatomic,copy)NSString *productColorName;
@property (nonatomic,strong)NSNumber *total;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSArray <NSDictionary *>*valList;
//细码值
@property (nonatomic,copy)NSString *xiMaName;
//高度
@property (nonatomic,assign)float xiMaHeight;
@end

@interface LZTypeProductModel : NSObject
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,strong)NSNumber *totalNumber;
@property (nonatomic,copy)NSArray *colorList;

@property (nonatomic,strong)NSMutableArray <LZtypeInnerModel *>*innerModels;

+ (NSArray *)setOriginSource:(NSArray <NSDictionary *>*)source;

//cell总高度
@property (nonatomic,assign)float totalHeight;
@end
