//
//  LZChangeNumberVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ItemList;

typedef NS_ENUM(NSInteger, LZChangeNumVCType) {
    LZChangeNumVCTypeOrder = 0,//开单
    LZChangeNumVCTypeBackOrder//退单
};

typedef NS_ENUM(NSInteger, WithBtnClickStyle) {
    AdditionBtnClick = 0,
    SubtractionBtnClick,
    MultiplicationBtnClick,
    DivisionBtnClick
};

@interface LZChangeNumberVC : UIViewController
//原始值
@property(nonatomic,assign) double originalValue;
@property(nonatomic,assign)NSInteger lineValue;
@property(nonatomic,strong)NSMutableArray * cellLineList;//总条数的数据源
@property(nonatomic,strong)ItemList * itemModel;//结算数量的model
@property (nonatomic,copy) void(^NumValueBlock)(NSString *ValueStr , NSString *changeStr);

@property (nonatomic,assign) LZChangeNumVCType type;
@end
