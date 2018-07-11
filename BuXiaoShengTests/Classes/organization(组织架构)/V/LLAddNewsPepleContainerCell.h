//
//  LLAddNewsPepleContainerCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLAddNewPeoleRoleModel;
@class LLAuditMangerItemModel;
@interface LLAddNewsPepleContainerCell : UITableViewCell
@property (nonatomic,strong) LLAddNewPeoleRoleModel * model;
@property (nonatomic,strong) LLAuditMangerItemModel * idModel;
@end
