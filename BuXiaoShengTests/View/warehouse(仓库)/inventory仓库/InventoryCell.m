//
//  InventoryCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "InventoryCell.h"

@implementation InventoryCell
@synthesize bgView,cornerWhiteBgView,iconImageView,iconNameLabel,titleLabel,meterLabel,codeLabel,kgLabel,bottomBgView;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self setSDlayout];
        
    }
    return self;
}

- (UIView *)bgView
{
    if (bgView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        [contentView addSubview:(bgView = view)];
    }
    return bgView;
}

- (UIView *)cornerWhiteBgView
{
    if (cornerWhiteBgView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        //        view.layer.cornerRadius = 5.0f;
        [contentView addSubview:(cornerWhiteBgView = view)];
    }
    return cornerWhiteBgView;
}

- (UIImageView *)iconImageView
{
    if (iconImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)iconNameLabel
{
    if (iconNameLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"周鹏 ";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor whiteColor];
        [self.iconImageView addSubview:(iconNameLabel = label)];
    }
    return iconNameLabel;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"中国工商银行";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = CD_Text33;
        [contentView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)meterLabel
{
    if (meterLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"上期：5623.10";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(meterLabel = label)];
    }
    return meterLabel;
}

- (UILabel *)codeLabel
{
    if (codeLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"新增：261345.11";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(codeLabel = label)];
    }
    return codeLabel;
}

- (UILabel *)kgLabel
{
    if (kgLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"累计：2454545.00";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(kgLabel = label)];
    }
    return kgLabel;
}

- (UIView *)bottomBgView
{
    if (bottomBgView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
        [contentView addSubview:(bottomBgView = view)];
    }
    return bottomBgView;
}



- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 5)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth -30)
    .heightIs(133);
    
    //    self.bottomBgView.sd_layout
    //    .bottomSpaceToView(self.bgView, -10)
    //    .leftSpaceToView(contentView, 0)
    //    .widthIs(APPWidth -30)
    //    .heightIs(10);
    
    //    self.cornerWhiteBgView.sd_layout
    //    .topSpaceToView(self.bgView, 0)
    //    .leftSpaceToView(self.bgView, 0)
    //    .widthIs(APPWidth -30)
    //    .heightIs(10);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(contentView, 15)
    //    .centerYEqualToView(self.bgView)
    .topSpaceToView(contentView, 40)
    .widthIs(40)
    .heightIs(40);
    
    self.iconNameLabel.sd_layout
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView)
    .widthIs(40)
    .heightIs(14);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.contentView, 20)
    .widthIs(250)
    .heightIs(15);
    
    self.meterLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 15)
    .widthIs(300)
    .heightIs(13);
    
    self.codeLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.meterLabel, 10)
    .widthIs(300)
    .heightIs(13);
    
    self.kgLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.codeLabel, 10)
    .widthIs(300)
    .heightIs(13);
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
