//
//  CustomerCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "OrderCustomerCell.h"

@implementation OrderCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setCustomerModel:(LZOutOrderCustomerModel *)customerModel
{
    _customerModel = customerModel;
    self.customerNameLB.text = customerModel.customerName;
    self.customerMobileLB.text = customerModel.customerMobile;
    self.receivablePriceLB.text = customerModel.matter;
    self.orderNoLB.text = customerModel.orderNo;
    self.remarkLB.text = customerModel.remark;
    self.createTimeLB.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:customerModel.createTime]];
}


@end
