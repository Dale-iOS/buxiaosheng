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
    UIImageView *_auditIM;//审批图标
    UILabel *_auditLbl;//审批状态
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
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
