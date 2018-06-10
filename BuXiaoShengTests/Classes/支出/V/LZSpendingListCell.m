//
//  LZSpendingListCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSpendingListCell.h"

@implementation LZSpendingListCell
{
    UILabel *_costLbl;//费用
    UILabel *_bankPayLbl;//银行方式
    UILabel *_dateLbl;//日期
    UILabel *_money;//费用
    UIImageView *_auditYesIM;//审批通过图标
    UIImageView *_auditNoIM;//审批拒绝图标
    UILabel *_auditYesLbl;//审批通过状态
    UILabel *_auditNoLbl;//审批拒绝状态
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    //费用
    _costLbl = [[UILabel alloc]init];
    _costLbl.font = FONT(14);
    _costLbl.textColor = CD_Text33;
    [self.contentView addSubview:_costLbl];
    [_costLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(15);
    }];
    
    //银行方式
    _bankPayLbl = [[UILabel alloc]init];
    _bankPayLbl.font = FONT(13);
    _bankPayLbl.textColor = CD_Text66;
    [self.contentView addSubview:_bankPayLbl];
    [_bankPayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_costLbl).offset(20);
        make.width.mas_offset(100);
        make.height.mas_offset(14);
    }];
    
    //日期
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.textColor = CD_Text66;
    _dateLbl.font = FONT(13);
    [self.contentView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(_bankPayLbl).offset(10);
        make.height.mas_offset(14);
        make.width.mas_offset(100);
    }];
    
    //费用
    _money = [[UILabel alloc]init];
    _money.font = FONT(17);
    _money.textColor = CD_Text33;
    [self.contentView addSubview:_money];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(115);
        make.height.mas_offset(18);
        make.width.mas_offset(100);
        make.centerY.equalTo(self.contentView);
    }];
    
   
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
