//
//  ReimCustomerCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimCustomerCell.h"

@implementation ReimCustomerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setMsgModel:(LZBackOrderDetialModel *)msgModel{
    _msgModel = msgModel;
    self.createTime.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:msgModel.createTime]];
    self.customerName.text = msgModel.customerName;//客户名字
    self.customerMobile.text = msgModel.customerMobile;//客户电话
    self.orderNo.text = msgModel.orderNo;//订单号
    self.houseName.text = msgModel.houseName;//入库存
    NSInteger temp = [msgModel.realpayPrice integerValue] + [msgModel.deposit integerValue];
    self.shouldPrice.text = [NSString stringWithFormat:@"%ld",temp];//应收金额
    self.realpayPrice.text = msgModel.realpayPrice;//实付金额
    self.deposit.text = msgModel.deposit;//预收基恩
    self.bankName.text = msgModel.bankName;//收款方式
    self.remark.text = msgModel.remark;//备注
}


@end
