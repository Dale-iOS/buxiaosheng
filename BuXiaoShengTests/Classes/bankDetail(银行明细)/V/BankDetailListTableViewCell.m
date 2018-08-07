//
//  BankDetailListTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细cell

#import "BankDetailListTableViewCell.h"
#import "LZBankListDetailModel.h"
#import "LZBankListModel.h"

@implementation BankDetailListTableViewCell
@synthesize iconImageView,titleLabel,bankLabel,dateLabel,moneyLabel;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSDlayout];
        
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (iconImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"spendingbank");
    
        [contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
//        label.text = @"利息收入";
        [contentView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)bankLabel
{
    if (bankLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
//        label.text = @"建设银行";
        [contentView addSubview:(bankLabel = label)];
    }
    return bankLabel;
}

- (UILabel *)dateLabel
{
    if (dateLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
//        label.text = @"2018-4-10";
        [contentView addSubview:(dateLabel = label)];
    }
    return dateLabel;
}

- (UILabel *)moneyLabel
{
    if (moneyLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(17);
        label.textColor = [UIColor colorWithHexString:@"#f26552"];
//        label.text = @"+12.00";
        label.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:(moneyLabel = label)];
    }
    return moneyLabel;
}

- (void)setupSDlayout
{
    self.iconImageView.sd_layout
    .leftSpaceToView(contentView, 15)
    .widthIs(40)
    .heightIs(40)
    .centerYEqualToView(contentView);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(contentView, 20)
    .widthIs(250)
    .heightIs(15);
    
    self.bankLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.titleLabel, 10)
    .widthIs(250)
    .heightIs(13);
    
    self.dateLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.bankLabel, 10)
    .widthIs(250)
    .heightIs(13);
    
    self.moneyLabel.sd_layout
    .rightSpaceToView(contentView, 15)
    .widthIs(100)
    .heightIs(18)
    .topSpaceToView(contentView, 20);
}

- (void)setModel:(LZBankListListModel *)model{
    _model = model;
    self.titleLabel.text = _model.objectName;
    self.bankLabel.text = _model.bankName;
    self.dateLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    if ([_model.amount integerValue]>=0) {
        self.moneyLabel.textColor = [UIColor colorWithHexString:@"#f26552"];
        self.iconImageView.image = IMAGE(@"incomebank");
    }else{
        self.moneyLabel.textColor = CD_Text33;
        self.iconImageView.image = IMAGE(@"spendingbank");
    }
    self.moneyLabel.text = _model.amount;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
