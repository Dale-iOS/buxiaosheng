//
//  AddColorViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLColorRegistModel;
@interface AddColorViewController : BaseViewController

@property (nonatomic,copy) void(^ColorsArrayBlock)(NSMutableArray <LLColorRegistModel*>*muColosArray);
// 0是正常  1位修改过来的
@property(nonatomic ,assign)NSInteger  type;
@property(nonatomic ,strong)NSMutableArray <LLColorRegistModel*>* dataModels;
@end

