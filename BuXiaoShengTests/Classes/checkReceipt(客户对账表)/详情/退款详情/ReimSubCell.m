//
//  SubCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/9.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimSubCell.h"

@implementation ReimSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LZBackOrderDetialModel *)model{
    _model = model;
    self.totalNum.text = model.totalNum;
    self.totalLine.text = model.totalLine;
    self.totalMoney.text = model.tatalMoney;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
