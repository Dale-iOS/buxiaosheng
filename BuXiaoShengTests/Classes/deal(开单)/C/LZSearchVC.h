//
//  LZSearchVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#import "salesDemandModel.h"

@interface LZSearchVC : BaseViewController
@property (nonatomic,copy) void(^SearchVCBlock)(LLSalesColorListModel *seletedModel);
@property (nonatomic,copy) NSString *productId;
@end
