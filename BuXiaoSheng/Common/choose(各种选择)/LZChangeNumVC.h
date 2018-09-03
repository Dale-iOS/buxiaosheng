//
//  LZChangeNumVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@interface LZChangeNumVC : UIViewController
//原始值
@property(nonatomic,assign) double originalValue;
@property(nonatomic,assign)NSInteger lineValue;
@property(nonatomic,strong)NSMutableArray * cellLineList;//总条数的数据源
@property(nonatomic,strong)ItemList * itemModel;//结算数量的model
@property (nonatomic,copy) void(^NumValueBlock)(NSString *ValueStr);

@property (nonatomic,assign) LZChangeNumVCType type;

@end
