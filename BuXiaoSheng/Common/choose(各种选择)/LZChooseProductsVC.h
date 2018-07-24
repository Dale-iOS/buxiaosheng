//
//  LZChooseProductsVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZProductDetailModel.h"

@interface LZChooseProductsVC : BaseViewController
@property (nonatomic,copy) void(^selectVCBlock)(LZProductDetailModel *seletedModel);
@end
