//
//  OrderTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell
@synthesize bgView,iconImageView,companyLabel,nameLabel,demandLabel,OutNumLabel,priceLabel,timeLabel,stateLabel,distributionLabel;
#define contentView   self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellAccessoryNone;
        
        self.backgroundColor = LZHBackgroundColor;
        
        [self setSDlayout];
        
    }
    return self;
}

#pragma mark ------- lazy loding --------
- (UIView *)bgView
{
    if (!bgView)
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5.0f;
        [contentView addSubview:(bgView = view)];
    }
    return bgView;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self.bgView addSubview:(iconImageView = imageView)];
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
        label.textColor = [UIColor colorWithR:51.0f/255.0f G:51.0f/255.0f B:51.0f/255.0f A:1.0f];
        [self.bgView addSubview:(companyLabel = label)];
    }
    return companyLabel;
}

- (UILabel *)nameLabel
{
    if (!nameLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(nameLabel = label)];
    }
    return nameLabel;
}

- (UILabel *)demandLabel
{
    if (!demandLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(demandLabel = label)];
    }
    return demandLabel;
}

- (UILabel *)OutNumLabel
{
    if (!OutNumLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        label.hidden = YES;
        [self.bgView addSubview:(OutNumLabel = label)];
    }
    return OutNumLabel;
}

- (UILabel *)priceLabel
{
    if (!priceLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(priceLabel = label)];
    }
    return priceLabel;
}

- (UILabel *)timeLabel
{
    if (!timeLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (UILabel *)stateLabel
{
    if (!stateLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        label.textColor = [UIColor whiteColor];
        label.font = FONT(12);
        label.layer.cornerRadius = 5.0f;
        [self.bgView addSubview:(stateLabel = label)];
    }
    return stateLabel;
}

- (UILabel *)distributionLabel
{
    if (!distributionLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        label.backgroundColor =[UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:0.2f];
        label.layer.cornerRadius = 2.0f;
        [self.bgView addSubview:(distributionLabel = label)];
    }
    return distributionLabel;
}

//自动布局
- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 8)
    .widthIs(APPWidth -16)
    .heightIs(110);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 35)
    .widthIs(40)
    .heightIs(40);
    
    self.companyLabel.text = @"广州佛山染织厂";
    self.companyLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.bgView, 20)
//    .widthIs(300)
    .heightIs(15);
    [self.companyLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.nameLabel.text = @"魔术贴印双层BAD";
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.companyLabel, 10)
    .heightIs(13);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    self.demandLabel.text = @"需求量：5000";
    self.demandLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.demandLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    self.OutNumLabel.text = @"出库数：500";
    self.OutNumLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.OutNumLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    self.priceLabel.text = @"￥1623";
    self.priceLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 115)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:60];
    
    self.timeLabel.text = @"2018-4-3  13:14";
    self.timeLabel.sd_layout
    .rightSpaceToView(self.bgView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
