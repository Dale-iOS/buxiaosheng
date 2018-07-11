//
//  LZOutboundListCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/30.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZOutboundListCell.h"
@interface LZOutboundListCell()<UITextFieldDelegate>
@end
@implementation LZOutboundListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _warehouseNumTF = [[UITextField alloc]init];
    _warehouseNumTF.delegate = self;
    _warehouseNumTF.placeholder = @"库存数量";
    _warehouseNumTF.font = FONT(14);
    _warehouseNumTF.textAlignment = NSTextAlignmentCenter;
    _warehouseNumTF.textColor = CD_Text99;
    [self.contentView addSubview:_warehouseNumTF];
    [_warehouseNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _OutNumTF = [[UITextField alloc]init];
    _OutNumTF.delegate = self;
    _OutNumTF.placeholder = @"出库数量";
    _OutNumTF.font = FONT(14);
    _OutNumTF.textAlignment = NSTextAlignmentCenter;
    _OutNumTF.textColor = CD_Text99;
    [self.contentView addSubview:_OutNumTF];
    [_OutNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_warehouseNumTF.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _lineNumTF = [[UITextField alloc]init];
    _lineNumTF.delegate = self;
    _lineNumTF.placeholder = @"条数";
    _lineNumTF.font = FONT(14);
    _lineNumTF.textAlignment = NSTextAlignmentCenter;
    _lineNumTF.textColor = CD_Text99;
    [self.contentView addSubview:_lineNumTF];
    [_lineNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_OutNumTF.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];
    
    _fromWarahouseTF = [[UITextField alloc]init];
    _fromWarahouseTF.delegate = self;
    _fromWarahouseTF.placeholder = @"出库仓";
    _fromWarahouseTF.font = FONT(14);
    _fromWarahouseTF.textAlignment = NSTextAlignmentCenter;
    _fromWarahouseTF.textColor = CD_Text99;
    [self.contentView addSubview:_fromWarahouseTF];
    [_fromWarahouseTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(_lineNumTF.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(39);
    }];

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_warehouseNumTF]) {
        if ([self.delegate respondsToSelector:@selector(didClickInWarehouseNumTF:)]) {
            [self.delegate didClickInWarehouseNumTF:_warehouseNumTF];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
