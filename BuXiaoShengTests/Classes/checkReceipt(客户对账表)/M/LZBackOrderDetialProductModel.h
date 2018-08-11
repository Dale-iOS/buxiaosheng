//
//  LZBackOrderDetialProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZBackOrderDetialProductValListModel : NSObject
@property (nonatomic,strong)NSString *total1;
@property (nonatomic,strong)NSString *value;
@end

@interface LZBackOrderDetialProductColorListModel : NSObject
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *productColorName;
@property (nonatomic,strong)NSString *total;
@property (nonatomic,strong)NSString *unitName;
@property (nonatomic,strong)NSArray <LZBackOrderDetialProductValListModel *> *valList;
@end

@interface LZBackOrderDetialProductModel : NSObject
@property (nonatomic,strong)NSArray <LZBackOrderDetialProductColorListModel *> *colorList;
@property (nonatomic,strong)NSString *houseNum;
@property (nonatomic,strong)NSString *labelNum;
@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *refundAmount;
@property (nonatomic,strong)NSString *settlementNum;
@property (nonatomic,strong)NSString *total;
@end
