//
//  bankTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "bankTableViewCell.h"

@implementation bankTableViewCell
@synthesize bgView,iconImageView,titleLabel,lastLabel,addLabel,totalLabel,bottomBgView;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setSDlayout];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
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

- (UIImageView *)iconImageView
{
    if (iconImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"icbc");
        [contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"中国工商银行";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [contentView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)lastLabel
{
    if (lastLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"上期：5623.10";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(titleLabel = label)];
    }
    return lastLabel;
}

- (UILabel *)addLabel
{
    if (addLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"新增：261345.11";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(addLabel = label)];
    }
    return addLabel;
}

- (UILabel *)totalLabel
{
    if (totalLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"2454545.00";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(totalLabel = label)];
    }
    return totalLabel;
}

- (UIView *)bottomBgView
{
    if (bottomBgView == nil )
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        [contentView addSubview:(bottomBgView = view)];
    }
    return bottomBgView;
}

- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 0)
    .leftSpaceToView(contentView, 0)
    .widthIs(APPWidth -30)
    .heightIs(123);
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
