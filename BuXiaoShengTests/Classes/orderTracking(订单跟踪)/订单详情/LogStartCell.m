//
//  LogStartCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LogStartCell.h"

@implementation LogStartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setDetailModel:(LZPurchasingInfoDetailModel *)detailModel
{
    _detailModel = detailModel;
    WMLineView *line = [[WMLineView alloc] initWithFrame:self.line.frame withLineLength:5 withLineSpacing:3 withLineColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:line];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
