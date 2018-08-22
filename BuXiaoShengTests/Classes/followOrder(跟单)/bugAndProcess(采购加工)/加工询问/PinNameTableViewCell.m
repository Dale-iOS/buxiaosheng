//
//  PinNameTableViewCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "PinNameTableViewCell.h"

@implementation PinNameTableViewCell

- (void)setDetailModel:(LZPurchaseDetailModel *)detailModel
{
    _pinNameLabel.text = detailModel.productName;
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
