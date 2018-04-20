//
//  LZHHomeMenuCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZHHomeMenuCellDelegate <NSObject>
@optional
- (void)homeMenuCellClick:(long)Sender;
- (void)didClickBankBgViewInCell:(UITableViewCell *)cell;
@end

@interface LZHHomeMenuCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView menuArray:(NSArray *)menuArray;
@property(nonatomic, weak)id <LZHHomeMenuCellDelegate >delegate;


@end
