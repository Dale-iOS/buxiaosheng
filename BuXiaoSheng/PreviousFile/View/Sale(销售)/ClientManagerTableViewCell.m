//
//  ClientManagerTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ClientManagerTableViewCell.h"

@implementation ClientManagerTableViewCell
@synthesize iconImageView,iconNameLabel,companyLabel,managerLabel,label,lineView;
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

- (UILabel *)iconNameLabel
{
    if (iconNameLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor whiteColor];
        [self.iconImageView addSubview:(iconNameLabel = label)];
    }
    return iconNameLabel;
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

- (UILabel *)label
{
    if (!label)
    {
        UILabel *label1 = [[UILabel alloc]init];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = FONT(12);
        label1.backgroundColor = [UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:0.2f];
        label1.textColor = [UIColor colorWithHexString:@"#23c4dc"];
        label1.layer.cornerRadius = 2.0f;
        [contentView addSubview:(label = label1)];
    }
    return label;
}

- (UIView *)lineView
{
    if (!lineView) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
        [contentView addSubview:(lineView = view)];
    }
    return lineView;
}


- (void)setModel:(LZClientManagerModel *)model
{
    _model = model;
    //标题
    self.companyLabel.text = model.name;
    //负责人
    self.managerLabel.text = [NSString stringWithFormat:@"%@负责",model.memberName];
    //头像框里面的标题
    //    NSString *nameStr = self.names[indexPath.row][@"memberName"];
    if (model.name.length > 3) {
        self.iconNameLabel.text = [model.name substringToIndex:3];
    }else{
        self.iconNameLabel.text = model.name;
    }
    //标签
    self.label.text = model.labelName;
}

///自动布局
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
    
    self.companyLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(contentView, 15)
    .heightIs(15);
    [self.companyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.managerLabel.sd_layout
    .rightSpaceToView(contentView, 15)
    .centerYEqualToView(contentView)
    .heightIs(13);
    [self.managerLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.label.sd_layout
    .leftEqualToView(self.companyLabel)
    .topSpaceToView(self.companyLabel, 10)
    .heightIs(20)
    .widthIs(44);
    [self.label setSingleLineAutoResizeWithMaxWidth:200];
    
    self.lineView.sd_layout
    .bottomSpaceToView(contentView, 0)
    .heightIs(0.5)
    .widthIs(APPWidth)
    .leftSpaceToView(contentView, 0);
}

- (void)awakeFromNib {
    [super awakeFromNib];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
