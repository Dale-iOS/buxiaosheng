//
//  LZProductInfoCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZProductInfoModel.h"

@interface LZProductInfoCell : UITableViewCell
@property (strong, nonatomic) LZProductInfoModel *model;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subLabel;
@property (strong, nonatomic) UILabel *unitLabel;
@end
