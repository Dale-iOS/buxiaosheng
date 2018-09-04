//
//  LLWarehouseDetailCell.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLWarehouseDetailModel;
@interface LLWarehouseDetailCell : UITableViewCell
@property(nonatomic ,strong)LLWarehouseDetailModel * model;
@property(nonatomic ,strong)NSIndexPath * indexPath;
@end
