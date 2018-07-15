//
//  LZGoodsDetailCell.h
//  BuXiaoSheng
//
//  Created by ap on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigGoodsAndBoardModel.h"

@interface LZGoodsDetailCell : UITableViewCell
///标题
@property (nonatomic, weak) UILabel *titleLabel;
///标题右边的内容输入框
@property (nonatomic, weak) UITextField *contentTF;
///右箭头
@property (nonatomic, strong) UIImageView *rightArrowImageVIew;
///画底部的线
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) ItemList *model;
@end
