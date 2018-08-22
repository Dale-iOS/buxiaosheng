//
//  ConsultOtherTableViewCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ConsultOtherTableViewCell.h"

@implementation ConsultOtherTableViewCell


- (void)setDetailModel:(LZPurchaseDetailModel *)detailModel
{
    _detailModel = detailModel;
    _companyLabel.text = detailModel.factoryName;
    _nameLabel.text = detailModel.contactName;
    _phoneLabel.text = detailModel.mobile;
    _addressLabel.text = detailModel.address;
    _remarkTF.text = detailModel.remark;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
