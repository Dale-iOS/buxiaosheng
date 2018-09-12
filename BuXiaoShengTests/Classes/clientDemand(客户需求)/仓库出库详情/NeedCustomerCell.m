//
//  CustomerCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "NeedCustomerCell.h"

@implementation NeedCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDataModel:(LZCustomerNeedsDetailModel *)dataModel
{
    _dataModel = dataModel;
  
    self.createTimeLB.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:dataModel.createTime]];
}


@end
