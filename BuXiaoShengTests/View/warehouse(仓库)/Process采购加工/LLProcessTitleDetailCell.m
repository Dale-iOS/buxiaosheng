//
//  LLProcessTitleDetailCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLProcessTitleDetailCell.h"

@implementation LLProcessTitleDetailCell
{
    UILabel * _leftcolorLable;
    UILabel * _leftdemandLable;
    UILabel * _rightcolorLable;
    UILabel * _rightdemandLable;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _leftcolorLable.textColor = CD_Text33;
    }
    return self;
}

@end
