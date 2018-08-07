//
//  LZAuditDetailHeaderCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZAuditDetailModel.h"

@interface LZAuditDetailHeaderCell : UIView
///头像底图
@property (nonatomic, strong) UIImageView *headerImageView;
///头像标题
@property (nonatomic, strong) UILabel *headerTitle;
///名称
@property (nonatomic, strong) UILabel *nameLabel;
///状态
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) LZAuditDetailModel *model;
@end
