//
//  LZSalesDetailCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSalesDetailCell.h"
#import "LZSalesDetailModel.h"

@implementation LZSalesDetailCell
@synthesize titleLBL,colorLBL,unitLBL,numberLBL,priceLBL;
#define contentView  self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.titleLBL.sd_layout
    .leftSpaceToView(contentView, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(240))
    .heightIs(65);
    
    self.colorLBL.sd_layout
    .leftSpaceToView(self.titleLBL, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.unitLBL.sd_layout
    .leftSpaceToView(self.colorLBL, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);
    
    self.numberLBL.sd_layout
    .leftSpaceToView(self.unitLBL, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.priceLBL.sd_layout
    .leftSpaceToView(self.numberLBL, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);
}

- (void)setModel:(LZSalesDetailItemListModel *)model{
    _model = model;
    self.titleLBL.text = _model.productName;
    self.colorLBL.text = _model.productColorName;
    self.unitLBL.text = _model.unitName;
    self.numberLBL.text = _model.number;
    self.priceLBL.text = _model.price;
}

#pragma mark ---- lazi loding ----
- (UILabel *)titleLBL{
    if (titleLBL == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(titleLBL = label)];
    }
    return titleLBL;
}

- (UILabel *)colorLBL{
    if (colorLBL == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(colorLBL = label)];
    }
    return colorLBL;
}

- (UILabel *)unitLBL{
    if (unitLBL == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(unitLBL = label)];
    }
    return unitLBL;
}

- (UILabel *)numberLBL{
    if (numberLBL == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(numberLBL = label)];
    }
    return numberLBL;
}

- (UILabel *)priceLBL{
    if (priceLBL == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(priceLBL = label)];
    }
    return priceLBL;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
