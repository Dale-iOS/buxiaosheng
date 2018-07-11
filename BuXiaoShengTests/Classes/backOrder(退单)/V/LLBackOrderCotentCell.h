//
//  LLBackOrderCotentCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLBackOrderCotentCell;
#import "salesDemandModel.h"
typedef void(^BackOrderCotentCellBlock)(LLBackOrderCotentCell * cell);
#import <UIKit/UIKit.h>

@class LLBackOrdeContentModel;
@interface LLBackOrderCotentCell : UITableViewCell
 @property (nonatomic,strong) NSMutableArray <NSMutableArray <LLBackOrdeContentModel*>*>* dateModels;

@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,copy) BackOrderCotentCellBlock block;
@property (nonatomic,strong)NSArray < productListModel *> * products;

@end
