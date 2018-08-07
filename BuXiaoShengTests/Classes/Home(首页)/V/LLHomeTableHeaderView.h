//
//  LLHomeTableHeaderView.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
typedef void(^HomeTableHeaderPageBlock)(NSInteger selectIndex);
#import <UIKit/UIKit.h>
@class LZHomeModel;
@class LLTurnoverListModel;
@class SGPageTitleView;
@interface LLHomeTableHeaderView : UIView
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@property(nonatomic ,copy)NSArray <LLTurnoverListModel*> * chartModels;
@property(nonatomic ,copy)HomeTableHeaderPageBlock pageTitleblock;
@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@end
