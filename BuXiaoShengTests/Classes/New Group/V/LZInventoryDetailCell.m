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
        _numLbl = [[UILabel alloc]init];
        _numLbl.backgroundColor = [UIColor redColor];
        _numLbl.text = @"12323";
        _numLbl.textColor = CD_Text99;
        _numLbl.textAlignment = NSTextAlignmentCenter;
        _numLbl.font = FONT(13);
        [self.contentView addSubview:_numLbl];
    }
    return _nameLbl;
}

- (UILabel *)lineLbl
{
    if (!_lineLbl) {
        _lineLbl = [[UILabel alloc]init];
        _lineLbl.textColor = CD_Text99;
        _lineLbl.textAlignment = NSTextAlignmentCenter;
        _lineLbl.font = FONT(13);
        [self.contentView addSubview:_lineLbl];
    }
    return _lineLbl;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc]init];
        _numLbl.textColor = CD_Text99;
        _numLbl.textAlignment = NSTextAlignmentCenter;
        _numLbl.font = FONT(13);
        [self.contentView addSubview:_numLbl];
    }
    return _numLbl;
}

- (UILabel *)unitLbl
{
    if (!_unitLbl) {
        _unitLbl = [[UILabel alloc]init];
        _unitLbl.textColor = CD_Text99;
        _unitLbl.textAlignment = NSTextAlignmentCenter;
        _unitLbl.font = FONT(13);
        [self.contentView addSubview:_unitLbl];
    }
    return _unitLbl;
}

- (UILabel *)warehouseLbl
{
    if (!_warehouseLbl) {
        _warehouseLbl = [[UILabel alloc]init];
        _warehouseLbl.backgroundColor = [UIColor yellowColor];
        _warehouseLbl.textColor = CD_Text99;
        _warehouseLbl.textAlignment = NSTextAlignmentCenter;
        _warehouseLbl.font = FONT(13);
        [self.contentView addSubview:_warehouseLbl];
    }
    return _warehouseLbl;
}

//UI布局
- (void)setupUI
{
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_nameLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_lineLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_numLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_warehouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_unitLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setModel:(LZInventoryDetailModel *)model
{
    _model = model;
    _nameLbl.text = _model.productName;
    _lineLbl.text = _model.total;
    _numLbl.text = _model.number;
    _unitLbl.text = _model.unitName;
    _warehouseLbl.text = _model.houseName;
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
