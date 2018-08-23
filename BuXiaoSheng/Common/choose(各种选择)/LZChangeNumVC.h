//
//  LZChangeNumVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemList;
@interface LZChangeNumVC : UIViewController
//原始值
@property(nonatomic,assign)NSInteger originalValue;
@property(nonatomic,assign)NSInteger lineValue;
@property(nonatomic,strong)NSMutableArray * cellLineList;//总条数的数据源
@property(nonatomic,strong)ItemList * itemModel;//结算数量的model
@property (nonatomic,copy) void(^NumValueBlock)(NSString *ValueStr);
@end
