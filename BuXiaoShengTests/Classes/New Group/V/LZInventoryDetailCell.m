//
//  LZInventoryDetailCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZInventoryDetailCell.h"

@implementation LZInventoryDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellAccessoryNone;
        [self setupUI];
    }
    return self;
}

- (UILabel *)nameLbl
{
    if (!_numLbl) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(_nameLbl = label)];
    }
    return _nameLbl;
}

- (UILabel *)lineLbl
{
    if (!_lineLbl) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(_lineLbl = label)];
    }
    return _lineLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(_numLbl = label)];
    }
    return _numLbl;
}

- (UILabel *)unitLbl
{
    if (!_unitLbl) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(_unitLbl = label)];
    }
    return _unitLbl;
}

- (UILabel *)warehouseLbl
{
    if (!_warehouseLbl) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        [self.contentView addSubview:(_warehouseLbl = label)];
    }
    return _warehouseLbl;
}

//UI布局
- (void)setupUI
{
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
    }];
    
    [_lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_nameLbl);
        make.width.mas_offset(APPWidth *0.2);
    }];
    
    [_numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_lineLbl);
        make.width.mas_offset(APPWidth *0.2);
    }];
    
    [_unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_numLbl);
        make.width.mas_offset(APPWidth *0.2);
    }];
    
    [_warehouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_unitLbl);
        make.width.mas_offset(APPWidth *0.2);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
