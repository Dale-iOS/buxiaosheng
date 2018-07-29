//
//  LZBackOrderGroup.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LZBackOrderItem;

@interface LZBackOrderGroup : NSObject

/**
 是否折叠
 */
@property (nonatomic,assign,getter=isFold) BOOL fold;

/**
 存放每一个分组下cell对应的数据模型
 */
@property (nonatomic,strong) NSMutableArray<LZBackOrderItem *> *items;


/**
 是否隐藏新增一条按钮
 */
@property (nonatomic,assign,getter=isHiddenAddYard) BOOL hiddenAddYard;


/**
 每个分组下输入的细码内容
 */
@property (nonatomic,strong) NSMutableArray *itemStrings;

//总码 or 细码
@property (nonatomic,strong) NSString *storageType;

+ (instancetype)groupWithFlod:(BOOL)flod items:(NSArray *)items;

@end
