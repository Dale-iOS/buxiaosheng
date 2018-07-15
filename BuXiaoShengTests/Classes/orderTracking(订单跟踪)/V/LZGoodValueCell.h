//
//  LZGoodValueCell.h
//  BuXiaoSheng
//
//  Created by ap on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigGoodsAndBoardModel.h"

@interface LZGoodValueCell : UITableViewCell
@property (nonatomic, strong) BatchNumberList *model;
@property (nonatomic, copy) void(^didClickCompltBlock)(void);

@end
