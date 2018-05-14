//
//  AddSetCompanyViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SupplierCompanyViewController.h"
@interface AddSetCompanyViewController : BaseViewController
@property (nonatomic,assign) FactoryType type;
@property (nonatomic,assign) BOOL  isFormCompanyAdd;   //yes 来源添加仓库  false 更新仓库
@property (nonatomic,copy) NSString * id;
@end
