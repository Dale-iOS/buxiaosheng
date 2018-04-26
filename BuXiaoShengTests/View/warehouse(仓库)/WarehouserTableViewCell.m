//
//  WarehouserTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "WarehouserTableViewCell.h"

@implementation WarehouserTableViewCell
@synthesize titleLbl,colorLbl,weightLbl,stateLbl,timeLbl;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (UILabel *)titleLbl
{
    if (titleLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text33;
        label.text = @"魔术贴双层bab";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(titleLbl = label)];
    }
    return titleLbl;
}

- (UILabel *)colorLbl
{
    if (colorLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.text = @"紫红色";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(colorLbl = label)];
    }
    return colorLbl;
}

- (UILabel *)weightLbl
{
    if (weightLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.text = @"54587 公斤";
        label.textAlignment = NSTextAlignmentLeft;
        [contentView addSubview:(weightLbl = label)];
    }
    return weightLbl;
}

- (UILabel *)stateLbl
{
    if (stateLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.backgroundColor = [UIColor colorWithRed:37.0f/255.0f green:204.0f/255.0f blue:229.0f/255.0f alpha:0.2f];
        label.textColor = [UIColor colorWithHexString:@"#25cce5"];
        label.text = @"入库";
        label.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(stateLbl = label)];
    }
    return stateLbl;
}

- (UILabel *)timeLbl
{
    if (timeLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text99;
        label.text = @"2018-4-3 13：14";
        label.textAlignment = NSTextAlignmentRight;
        [contentView addSubview:(timeLbl = label)];
    }
    return timeLbl;
}

- (void)setupSDlayout
{
    self.titleLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(contentView, 20)
    .widthIs(250)
    .heightIs(15);
    
    self.colorLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(self.titleLbl, 10)
    .widthIs(150)
    .heightIs(13);
    
    self.weightLbl.sd_layout
    .leftSpaceToView(contentView, 15)
    .topSpaceToView(self.colorLbl, 10)
    .widthIs(250)
    .heightIs(13);
    
    self.stateLbl.sd_layout
    .topEqualToView(self.titleLbl)
    .rightSpaceToView(contentView, 15)
    .widthIs(50)
    .heightIs(20);
    
    self.timeLbl.sd_layout
    .topEqualToView(self.weightLbl)
    .rightSpaceToView(contentView, 15)
    .widthIs(150)
    .heightIs(13);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
