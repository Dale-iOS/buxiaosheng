//
//  PinDetailTableViewCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/21.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "PinDetailTableViewCell.h"

@implementation PinDetailTableViewCell

- (void)setBottomModel:(LZPurchaseBottomListModel *)bottomModel
{
    _bottomModel = bottomModel;
    _nameLabel.text = bottomModel.productName;
    _colorLabel.text = bottomModel.productColorName;
    _tiaoNumberLabel.text = bottomModel.number;
    _totalNumberLabel.text = bottomModel.total;
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
