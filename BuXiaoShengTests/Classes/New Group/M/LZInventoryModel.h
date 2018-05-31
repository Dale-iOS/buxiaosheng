//
//  LZInventoryModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LZInventoryListModel;
#import <Foundation/Foundation.h>

@interface LZInventoryModel : NSObject
@property (nonatomic,copy) NSString *totalCode;
@property (nonatomic,copy) NSString *totalKg;
@property (nonatomic,copy) NSString *totalRice;
@property (nonatomic,strong) NSArray <LZInventoryListModel *> *itemList;
@end

@interface LZInventoryListModel:NSObject
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *houseName;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *kg;
@property (nonatomic,copy) NSString *rice;
@end
