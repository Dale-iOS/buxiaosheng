//
//  AlterWarehouseViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AlterWarehouseViewController : BaseViewController

@property (nonatomic,copy) NSString * id;
@property (nonatomic,assign) BOOL  isFormWarehouseAdd;  //yes 来源添加仓库  false 修改仓库

@end
