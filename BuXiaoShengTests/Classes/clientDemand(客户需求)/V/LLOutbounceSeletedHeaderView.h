//
//  LLOutbounceSeletedHeaderView.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/1.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLOutbounceSeletedHeaderView;
typedef void(^seletedHeaderViewBlock)(LLOutbounceSeletedHeaderView * headerView);
#import <UIKit/UIKit.h>
#import "LZOutboundModel.h"
@interface LLOutbounceSeletedHeaderView : UICollectionReusableView
@property (nonatomic,strong) LLOutboundRightModel * model;
@property (nonatomic,copy) seletedHeaderViewBlock  block;
@end
