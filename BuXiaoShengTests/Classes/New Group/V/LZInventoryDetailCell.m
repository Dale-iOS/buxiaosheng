//
//  LZInventoryDetailCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZInventoryDetailCell.h"

@implementation LZInventoryDetailCell
@synthesize nameLbl,lineLbl,numLbl,unitLbl,warehouseLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        [self setupUI];
    }
    return self;
}

- (UILabel *)nameLbl
{
    if (numLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(nameLbl = label)];
    }
    return nameLbl;
}

- (UILabel *)lineLbl
{
    if (lineLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(lineLbl = label)];
    }
    return lineLbl;
}

- (UILabel *)numLbl
{
    if (numLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(numLbl = label)];
    }
    return numLbl;
}

- (UILabel *)unitLbl
{
    if (unitLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(unitLbl = label)];
    }
    return unitLbl;
}

- (UILabel *)warehouseLbl
{
    if (warehouseLbl == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(warehouseLbl = label)];
    }
    return warehouseLbl;
}

//UI布局
- (void)setupUI
{
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(APPWidth *0.2);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(APPWidth *0.4);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(APPWidth *0.6);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.warehouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(APPWidth *0.8);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(LZInventoryDetailModel *)model
{
    _model = model;
    self.nameLbl.text = _model.productName;
    self.lineLbl.text = _model.total;
    self.numLbl.text = _model.number;
    self.unitLbl.text = _model.unitName;
    self.warehouseLbl.text = _model.houseName;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
