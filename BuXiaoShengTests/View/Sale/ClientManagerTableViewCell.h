//
//  ClientManagerTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientManagerTableViewCell : UITableViewCell

///头像
@property (nonatomic, strong)UIImageView *iconImageView;

///厂名字
@property (nonatomic, strong)UILabel *companyLabel;

///负责人
@property (nonatomic, strong)UILabel *managerLabel;

@end
