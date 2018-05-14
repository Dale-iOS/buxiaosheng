//
//  AuditManagerTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AuditManagerTableViewCell.h"

@implementation AuditManagerTableViewCell
@synthesize iconImageView,iconNameLabel,titleLabel;
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

#pragma mark ------- lazy loding --------
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
    if (!titleLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"罗志祥";
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [contentView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

//- (UILabel *)deletLabel
//{
//    if (!deletLabel)
//    {
//        UILabel *label = [[UILabel alloc]init];
//        label.textAlignment = NSTextAlignmentRight;
//        label.text = @"删除";
//        label.font = FONT(12);
//        label.textColor = CD_Text33;
//        [contentView addSubview:(deletLabel = label)];
//    }
//    return deletLabel;
//}

- (void)setSDlayout
{
    self.iconImageView.sd_layout
    .leftSpaceToView(contentView, 15)
    .centerYEqualToView(contentView)
    .widthIs(40)
    .heightIs(40);
    
    self.iconNameLabel.sd_layout
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView)
    .widthIs(40)
    .heightIs(14);
    
    self.titleLabel.sd_layout
    .widthIs(250)
    .heightIs(15)
    .leftSpaceToView(self.iconImageView, 10)
    .centerYEqualToView(contentView);
    
//    self.deletLabel.sd_layout
//    .widthIs(30)
//    .heightIs(13)
//    .rightSpaceToView(contentView, 15)
//    .centerYEqualToView(contentView);
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
