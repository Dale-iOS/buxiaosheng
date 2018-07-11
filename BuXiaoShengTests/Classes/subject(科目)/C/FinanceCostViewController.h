//
//  FinanceCostViewController.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LZSubjectModel;
#import <UIKit/UIKit.h>

@interface FinanceCostViewController : UIViewController
@property(nonatomic,assign)BOOL isFromSpend;
@property(nonatomic,copy)void(^didClickBlock)(LZSubjectModel *blockModel);
@end
