//
//  CustomerReconciliationTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户对账单cell

#import "CustomerReconciliationTableViewCell.h"
#define contentView   self.contentView

@implementation CustomerReconciliationTableViewCell
@synthesize dateLbl,titleLbl,numLbl,bankLbl,priceLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSDlayout];
        
    }
    return self;
}

- (UILabel *)dateLbl
{
    if (dateLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.text = @"2018-4-13";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(dateLbl = label)];
    }
    return dateLbl;
}

- (UILabel *)titleLbl
{
    if (titleLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.text = @"魔术贴双层bab";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(titleLbl = label)];
    }
    return titleLbl;
}

- (UILabel *)numLbl
{
    if (numLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.text = @"sadfdsg";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(numLbl = label)];
    }
    return numLbl;
}

- (UILabel *)bankLbl
{
    if (bankLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.layer.cornerRadius = 2.0f;
        label.backgroundColor = [UIColor colorWithRed:37.0f/255.0f green:204.0f/255.0f blue:229.0f/255.0f alpha:0.2f];
        label.textColor = [UIColor colorWithHexString:@"#25cce5"];
        label.text = @"农业银行";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(bankLbl = label)];
    }
    return bankLbl;
}

- (UILabel *)priceLbl
{
    if (priceLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(17);
        label.textColor = [UIColor colorWithHexString:@"#f26552"];
        label.text = @"+1324651.00";
        label.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:(priceLbl = label)];
    }
    return priceLbl;
}

- (void)setupSDlayout
{
    self.dateLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(contentView, 20)
    .widthIs(120)
    .heightIs(15);
    
    self.titleLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(self.dateLbl, 10)
    .widthIs(250)
    .heightIs(14);
    
    self.numLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(self.titleLbl, 10)
    .widthIs(250)
    .heightIs(14);
    
    self.bankLbl.sd_layout
    .leftSpaceToView(contentView, 105)
    .topSpaceToView(contentView, 16)
    .widthIs(75)
    .heightIs(20);
    
    self.priceLbl.sd_layout
    .rightSpaceToView(contentView, 15)
    .topEqualToView(self.bankLbl)
    .widthIs(250)
    .heightIs(18);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
