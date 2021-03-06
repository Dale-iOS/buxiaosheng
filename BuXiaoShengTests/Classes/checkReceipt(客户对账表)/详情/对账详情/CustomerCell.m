//
//  CustomerCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMsgModel:(LZCollectionCheckDetailMsgModel *)msgModel
{
    _msgModel = msgModel;
    self.customerNameLB.text = msgModel.customerName;
    self.arrearsLB.text =msgModel.arrearsPrice;
    self.customerMobileLB.text = msgModel.customerMobile;
    self.depositPriceLB.text = msgModel.depositPrice;
    self.receivablePriceLB.text = msgModel.netreceiptsPrice;
//    self.totalLB.text = msgModel.settleNumber;
    self.typeLB.text = msgModel.bankName;
    self.orderNoLB.text = msgModel.orderNo;
    self.remarkLB.text = msgModel.remark;
    self.labelNumberLB.text = msgModel.labelNumber;
    self.trimPriceLB.text = msgModel.trimPrice;
    self.settleNumber.text = msgModel.total;
    self.outNumberLB.text = msgModel.outNumber;
    self.netreceiptsPriceLB.text = msgModel.receivablePrice;
    self.settlementLabel.text = msgModel.settleNumber;;
    self.createTimeLB.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:msgModel.createTime]];
}


@end
