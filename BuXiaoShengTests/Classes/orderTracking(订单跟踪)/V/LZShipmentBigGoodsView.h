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

@interface LZShipmentBigGoodsView : UIView
@property (nonatomic, strong) LZOrderTrackingModel *model;
@property (nonatomic, copy) void(^didClickCompltBlock)(BigGoodsAndBoardModel *boardModel);
@property (nonatomic, copy) NSString *singleType;//属于大货还是板布(0为大货，1为板布)
@end
