//
//  LZShipmentBigGoodsView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZOrderTrackingModel.h"
#import "BigGoodsAndBoardModel.h"
#import "LZSaveOrderModel.h"

@interface LZShipmentBigGoodsView : UIView
@property (nonatomic, strong) LZOrderTrackingModel *model;
@property (nonatomic, copy) void(^didClickCompltBlock)(LZSaveOrderModel *boardModel);
@end
