//
//  LLHomeChildContentCollectionCell.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLHomePieChartModel;
@class LLHomeChidVC;
@interface LLHomeChildContentCollectionCell : UICollectionViewCell
@property(nonatomic ,assign)NSInteger selectIndex;
@property(nonatomic ,strong)LLHomePieChartModel * model;
@property(nonatomic ,strong)LLHomeChidVC * childVc;
@end
