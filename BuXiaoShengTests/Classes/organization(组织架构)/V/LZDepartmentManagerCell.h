//
//  LZDepartmentManagerCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LZDepartmentManagerModel;

@interface LZDepartmentManagerCell : UITableViewCell
@property(nonatomic,strong)LZDepartmentManagerModel *model;
///头像
@property (nonatomic, strong) UIImageView *iconImageView;
///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;
///客户
@property (nonatomic, strong) UILabel *nameLabel;
@end
