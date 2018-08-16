//
//  LLOutboundSeletedVC.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
#import "LZOutboundModel.h"
typedef void(^OutboundSeletedVCBlock)(NSArray <LLOutboundRightModel*>* seleteds,LZOutboundItemListModel * lastModel);
#import <UIKit/UIKit.h>

@interface LLOutboundSeletedVC : BaseViewController

@property (nonatomic,strong) LZOutboundItemListModel * itemModel;
@property (nonatomic,copy) OutboundSeletedVCBlock  block;
@end
