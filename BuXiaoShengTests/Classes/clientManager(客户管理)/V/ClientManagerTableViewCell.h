//
//  ClientManagerTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZClientManagerModel.h"
@interface ClientManagerTableViewCell : UITableViewCell

///头像
@property (nonatomic, strong) UIImageView *iconImageView;

///头像名字
@property (nonatomic, strong) UILabel *iconNameLabel;

///厂名字
@property (nonatomic, strong)UILabel *companyLabel;

///负责人
@property (nonatomic, strong)UILabel *managerLabel;

///标签
@property (nonatomic, strong)UILabel *label;

///灰色分割线
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong) LZClientManagerModel *model;

@end
