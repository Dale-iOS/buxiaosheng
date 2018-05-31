//
//  CustomerArrearsTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZInventoryDetailModel.h"
@interface CustomerArrearsTableViewCell : UITableViewCell

///客户名称
@property (nonatomic, strong) UILabel *titleLbl;

///应收借欠
@property (nonatomic, strong) UILabel *borrowLbl;

///最后还款日期
@property (nonatomic, strong) UILabel *payDateLbl;

///业务员
@property (nonatomic, strong) UILabel *workerLbl;
@property(nonatomic,strong) LZInventoryDetailModel *model;
@end
