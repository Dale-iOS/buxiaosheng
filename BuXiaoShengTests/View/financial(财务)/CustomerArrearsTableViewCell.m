//
//  CustomerArrearsTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户欠款表cell

#import "CustomerArrearsTableViewCell.h"
#define contentView   self.contentView

@implementation CustomerArrearsTableViewCell
@synthesize titleLbl,borrowLbl,payDateLbl,workerLbl;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSDlayout];
        
    }
    return self;
}

- (UILabel *)titleLbl
{
    if (titleLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(13);
        label.textColor = CD_Text99;
        label.text = @"周杰伦";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(titleLbl = label)];
    }
    return titleLbl;
}

- (UILabel *)borrowLbl
{
    if (borrowLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(13);
        label.textColor = CD_Text99;
        label.text = @"20415444.00";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(borrowLbl = label)];
    }
    return borrowLbl;
}

- (UILabel *)workerLbl
{
    if (workerLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(13);
        label.textColor = CD_Text99;
        label.text = @"李小龙";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(workerLbl = label)];
    }
    return workerLbl;
}

- (UILabel *)payDateLbl
{
    if (payDateLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(13);
        label.textColor = CD_Text99;
        label.text = @"2018-4-12";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(payDateLbl = label)];
    }
    return payDateLbl;
}

- (void)setupSDlayout
{
    self.titleLbl.sd_layout
    .leftSpaceToView(contentView, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(contentView, 0);
    
    self.borrowLbl.sd_layout
    .leftSpaceToView(self.titleLbl, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(contentView, 0);
    
    self.payDateLbl.sd_layout
    .leftSpaceToView(self.borrowLbl, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(contentView, 0);
    
    self.workerLbl.sd_layout
    .leftSpaceToView(self.payDateLbl, 0)
    .heightRatioToView(contentView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(contentView, 0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
