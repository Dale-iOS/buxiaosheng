//
//  LZClientModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LZAuditMangerItemModel;
#import <Foundation/Foundation.h>

@interface LZClientModel : NSObject
@property (nonatomic,copy) NSString * deptId;
@property (nonatomic,copy) NSString * deptName;
@property (nonatomic,strong) NSArray <LZAuditMangerItemModel *> * itemList;
@property (nonatomic,assign) BOOL sectionClick;
@end

@interface LZAuditMangerItemModel:NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@end
