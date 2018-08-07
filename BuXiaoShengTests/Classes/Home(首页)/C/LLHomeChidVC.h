//
//  LLHomeChidVC.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLHomePieChartModel;
@class LLHomeBaseTableView;
@interface LLHomeChidVC : BaseViewController
@property(nonatomic ,assign)NSInteger selectIndex;
@property(nonatomic ,strong)LLHomePieChartModel * model;
@property (nonatomic, assign) BOOL vcCanScroll;
@property(nonatomic ,strong)LLHomeBaseTableView * tableView;
@end
