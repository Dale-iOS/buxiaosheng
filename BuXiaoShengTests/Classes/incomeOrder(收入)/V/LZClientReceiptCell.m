//
//  LZClientReceiptCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZClientReceiptCell.h"
#import "LZClientReceiptModel.h"

@interface LZClientReceiptCell()
{
    UILabel *_nameLbl;//名字
    UILabel *_dataLbl;//日期
    UILabel *_moneyLbl;//加金额
}
@end

@implementation LZClientReceiptCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _nameLbl = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLbl];
    _nameLbl.textColor = CD_Text33;
    _nameLbl.font = FONT(14);
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_offset(200);
        make.height.mas_offset(15);
    }];
    
    _dataLbl = [[UILabel alloc]init];
    [self.contentView addSubview:_dataLbl];
    _dataLbl.textColor = CD_Text66;
    _dataLbl.font = FONT(13);
    [_dataLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.mas_offset(200);
        make.height.mas_offset(14);
    }];
    
    _moneyLbl = [[UILabel alloc]init];
    [self.contentView addSubview:_moneyLbl];
    _moneyLbl.textAlignment = NSTextAlignmentRight;
    _moneyLbl.textColor = [UIColor colorWithHexString:@"#f26552"];
    _moneyLbl.font = FONT(17);
    [_moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_offset(150);
        make.height.mas_offset(18);
    }];
}

- (void)setModel:(LZClientReceiptModel *)model{
    _model = model;
    _nameLbl.text = _model.customerName;
    _dataLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    _moneyLbl.text = [NSString stringWithFormat:@"+%@",_model.amount];
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
