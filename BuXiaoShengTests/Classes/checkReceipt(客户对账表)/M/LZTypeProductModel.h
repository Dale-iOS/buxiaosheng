//
//  LZTypeProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZTypeProductModel : NSObject
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *productColorName;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *unitName;
@property (nonatomic,copy)NSArray <NSDictionary *>*valList;
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,copy)NSString *totalNumber;
@property (nonatomic,copy)NSDictionary *colorList;
//cell总高度
@property (nonatomic,assign)float totalHeight;
//各个高度
@property (nonatomic,strong)NSMutableArray *conHeight;
+ (NSArray *)setOriginSource:(NSArray <NSDictionary *>*)source;
@end
