//
//  LLAuditMangerModel.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLAuditMangerModel : NSObject
@property (nonatomic,copy) NSString * deptId;
@property (nonatomic,copy) NSString * deptName;
@property (nonatomic,strong) NSArray * itemList;
@property (nonatomic,assign) BOOL sectionClick;
@end

@interface LLAuditMangerItemModel:NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * name;
@end
