//
//  ClientManagerTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ClientManagerTableViewCell.h"

@implementation ClientManagerTableViewCell
@synthesize iconImageView,companyLabel,managerLabel;
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
    if (!iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)companyLabel
{
    if (!companyLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
        [contentView addSubview:(companyLabel = label)];
    }
    return companyLabel;
}

- (UILabel *)managerLabel
{
    if (!managerLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [contentView addSubview:(managerLabel = label)];
    }
    return managerLabel;
}

///自动布局
- (void)setSDlayout
{
    
    self.iconImageView.sd_layout
    .leftSpaceToView(contentView, 15)
    .centerYEqualToView(contentView)
    .widthIs(40)
    .heightIs(40);
    
    self.companyLabel.text = @"广州佛山染织厂";
    self.companyLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .centerYEqualToView(contentView)
    .heightIs(15);
    [self.companyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.managerLabel.text = @"周鹏负责";
    self.managerLabel.sd_layout
    .rightSpaceToView(contentView, 15)
    .centerYEqualToView(contentView)
    .heightIs(13);
    [self.managerLabel setSingleLineAutoResizeWithMaxWidth:300];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
