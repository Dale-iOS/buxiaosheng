//
//  SupplierCompanyViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
typedef NS_OPTIONS(NSUInteger, FactoryType) {
    FactoryTypeGongHuoShang = 0,
    FactoryTypeShngChanShang = 1,
     FactoryTypeJiaGongShang = 2,
};
#import <UIKit/UIKit.h>

@interface SupplierCompanyViewController : UIViewController
@property (nonatomic,assign) FactoryType type;
@end
