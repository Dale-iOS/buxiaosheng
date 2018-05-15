//
//  LLAddNewPeoleRole.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLAddNewPeoleRoleModel : NSObject
@property (nonatomic,copy) NSString * id;
@property (nonatomic,copy) NSString * logo;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * parentId;
@property (nonatomic,strong) NSArray <LLAddNewPeoleRoleModel*> * itemList;

@property (nonatomic,assign) BOOL exis_role; //是否存在权限  或者选中
@end
