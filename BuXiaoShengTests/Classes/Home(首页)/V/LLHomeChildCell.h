//
//  LLHomeChildCell.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLHomePieChartModel;
@interface LLHomeChildCell : UITableViewCell
@property(nonatomic ,assign)NSIndexPath * indexPath;
@property(nonatomic ,strong)LLHomePieChartModel * model;
@end
