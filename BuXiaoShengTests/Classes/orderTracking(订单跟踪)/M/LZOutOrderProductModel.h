//
//  LZOutOrderProductModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LZOutOrderProductColorListModel;
@class LZOutOrderProductValListModel;

@interface LZOutOrderProductModel : NSObject
@property (nonatomic,strong)NSArray <LZOutOrderProductColorListModel *> *colorList;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *productName;
@property (nonatomic,strong)NSString *total;
@end

@interface LZOutOrderProductColorListModel : NSObject
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *productColorName;
@property (nonatomic,strong)NSString *total;
@property (nonatomic,strong)NSString *unitName;
@property (nonatomic,strong)NSArray <LZOutOrderProductValListModel *> *valList;
@end

@interface LZOutOrderProductValListModel : NSObject
@property (nonatomic,strong)NSString *totalA;
@property (nonatomic,strong)NSString *value;
@end
