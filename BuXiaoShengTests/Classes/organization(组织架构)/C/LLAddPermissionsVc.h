//
//  LLAddPermissionsVc.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLAuditMangerModel.h"
#import "LLAddNewPeoleRoleModel.h"
@interface LLAddPermissionsVc : BaseViewController
@property (nonatomic,strong) LLAuditMangerItemModel * model;
@property (nonatomic,strong) NSArray <LLAddNewPeoleRoleModel*> * exis_roles;
@end
