//
//  LZTypeMsgCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZTypeTopModel;

@interface LZTypeMsgCell : UITableViewCell

+ (LZTypeMsgCell *)resuLZTypeMsgCell:(UITableView *)tableView;
- (void)setCellTxtWith:(LZTypeTopModel *)model;

@end
