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
@property (nonatomic, strong) BigGoodsAndBoardModel *model;
@property (nonatomic, copy) void(^didClickCompltBlock)(NSInteger index,BigGoodsAndBoardModel *model, NSIndexPath *indexPath);
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
