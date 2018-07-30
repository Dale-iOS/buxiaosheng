//
//  BXSPurchaChangeWarehousingView.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 细码修改入库

#import <UIKit/UIKit.h>

#import "BXSAllCodeModel.h"

@interface BXSPurchaChangeWarehousingView : UIView



@property (strong,nonatomic)BXSAllCodeModel *model;

@property (copy,nonatomic)void (^clickChangeBlock)(void);
@end
