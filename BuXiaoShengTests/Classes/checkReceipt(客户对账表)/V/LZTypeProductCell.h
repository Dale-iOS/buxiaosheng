//
//  LZTypeProductCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZTypeProductModel;
@interface LZTypeProductCell : UITableViewCell
- (void)changeCellHeight:(LZTypeProductModel *)modelHeight;

+ (LZTypeProductCell *)refuProductCell:(UITableView *)tbview;
@end
