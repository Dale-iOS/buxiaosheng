//
//  CustomerReconciliationTableViewCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReconciliationTableViewCell : UITableViewCell

///日期
@property (nonatomic, strong) UILabel *dateLbl;

///商品名称
@property (nonatomic, strong) UILabel *titleLbl;

///商品编号
@property (nonatomic, strong) UILabel *numLbl;

///银行名称
@property (nonatomic, strong) UILabel *bankLbl;

///价格变化
@property (nonatomic, strong) UILabel *priceLbl;

@end
