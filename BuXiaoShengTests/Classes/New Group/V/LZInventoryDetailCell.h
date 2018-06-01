//
//  LZInventoryDetailCell.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZInventoryDetailModel.h"

@interface LZInventoryDetailCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLbl;
@property(nonatomic,strong)UILabel *lineLbl;
@property(nonatomic,strong)UILabel *numLbl;
@property(nonatomic,strong)UILabel *unitLbl;
@property(nonatomic,strong)UILabel *warehouseLbl;
@property(nonatomic,strong)LZInventoryDetailModel *model;
@end
