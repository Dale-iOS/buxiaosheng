//
//  LZChooseRecipeVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger,ChooseType)
{
    ChooseTypeFromDye = 0, //来自染色
    ChooseTypeFromWeaVe,   //来自织布
};

@interface LZChooseRecipeVC : BaseViewController

@property (nonatomic, assign) ChooseType chooseType;

@end
