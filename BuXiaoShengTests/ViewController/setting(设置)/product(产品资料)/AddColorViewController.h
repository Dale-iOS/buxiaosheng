//
//  AddColorViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AddColorViewController : BaseViewController

@property (nonatomic,copy) void(^ColorsArrayBlock)(NSMutableArray *muParamArray,NSMutableArray *muColosArray);

@end

