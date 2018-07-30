//
//  BXSChooseProductVC.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableVC.h"
@class productListModel;
@interface BXSChooseProductVC : BaseTableVC


@property (copy,nonatomic)void (^selectProduct)(productListModel *model);

@end
