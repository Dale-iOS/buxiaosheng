//
//  CustomerCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReCustomerCell.h"

@implementation ReCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDataModel:(LZPurchaseReceivingListDetailModel *)dataModel
{
    _dataModel = dataModel;
    self.addressLB.text = dataModel.address;
    self.arrearsPriceLB.text =dataModel.copewithPrice;
    self.bankNameLB.text = dataModel.bankName;
    self.contactNameLB.text = dataModel.contactName;
    self.copewithPriceLB.text = dataModel.arrearsPrice;
    self.factoryNameLB.text = dataModel.factoryName;
    self.factoryNoLB.text = dataModel.factoryNo;
    self.orderNoLB.text = dataModel.orderNo;
    self.remarkLB.text = dataModel.remark;
    self.houseNameLB.text = dataModel.houseName;
    self.mobileLB.text = dataModel.mobile;
    self.realpayPriceLB.text = dataModel.realpayPrice;
    self.createTimeLB.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:dataModel.createTime]];
}


@end
