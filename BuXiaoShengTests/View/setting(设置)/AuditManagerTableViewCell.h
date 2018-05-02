//
//  AuditManagerTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuditManagerTableViewCell : UITableViewCell

///图标
@property (nonatomic, strong)UIImageView *iconImageView;

///图标里面的名字
@property (nonatomic, strong)UILabel *iconNameLabel;

///名字
@property (nonatomic, strong)UILabel *titleLabel;

///删除
@property (nonatomic, strong)UILabel *deletLabel;

@end
