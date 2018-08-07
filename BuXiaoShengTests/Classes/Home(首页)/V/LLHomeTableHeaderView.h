//
//  LLHomeTableHeaderView.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZHomeModel;
@class LLTurnoverListModel;
@interface LLHomeTableHeaderView : UIView
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@property(nonatomic ,copy)NSArray <LLTurnoverListModel*> * chartModels;
@end
