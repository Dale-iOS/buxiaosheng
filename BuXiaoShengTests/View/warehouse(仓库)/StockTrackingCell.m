//
//  StockTrackingCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "StockTrackingCell.h"

@implementation StockTrackingCell
@synthesize bgView,iconImageView,iconNameLabel,titleLabel,stateLabel,subLabel,timeLabel,demandNumLabel,typeLabel,StorageNumLabel,redLeftView;
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
    if (bgView == nil)
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
    if (iconImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"ordericon");
        [self.bgView addSubview:(iconImageView = imageView)];
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
        label.text = @"供应商：阿吉布行";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self.bgView addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UILabel *)subLabel
{
    if (subLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"魔术贴魔术贴魔术贴魔术贴魔术贴";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(subLabel = label)];
    }
    return subLabel;
}

- (UILabel *)demandNumLabel
{
    if (demandNumLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"需求量：500";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(demandNumLabel = label)];
    }
    return demandNumLabel;
}

- (UILabel *)timeLabel
{
    if (timeLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"2018-4-3 13:14";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (UILabel *)stateLabel
{
    if (stateLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"已下单待处理";
        label.backgroundColor = [UIColor colorWithRed:37.0f/255.0f green:204.0f/255.0f blue:229.0f/255.0f alpha:0.2f];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.layer.cornerRadius = 4.0f;
        label.textColor = [UIColor colorWithHexString:@"#25cce5"];
        [self.bgView addSubview:(stateLabel = label)];
    }
    return stateLabel;
}

- (UILabel *)typeLabel
{
    if (typeLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"加工";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithHexString:@"#25cce5"];
        [self.bgView addSubview:(typeLabel = label)];
    }
    return typeLabel;
}

- (UIView *)redLeftView
{
    if (redLeftView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor colorWithHexString:@"#ff6565"];
        [self.bgView addSubview:(redLeftView = view)];
    }
    return redLeftView;
}

- (UILabel *)StorageNumLabel
{
    if (StorageNumLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"入库数:16464 -3435";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [self.bgView addSubview:(StorageNumLabel = label)];
    }
    return StorageNumLabel;
}

//自动布局
- (void)setSDlayout
{
    self.bgView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, 8)
    .widthIs(APPWidth -16)
    .heightIs(140);
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 28)
    .widthIs(40)
    .heightIs(40);
    
    self.iconNameLabel.sd_layout
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView)
    .widthIs(40)
    .heightIs(14);
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.bgView, 20)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(200)
    .heightIs(15);
    
    self.subLabel.sd_layout
    .topSpaceToView(self.titleLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
    self.demandNumLabel.sd_layout
    .topSpaceToView(self.subLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.demandNumLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
     self.stateLabel.sd_layout
    .topEqualToView(self.titleLabel)
    .rightSpaceToView(self.bgView, 15)
    .heightIs(20);
    [self.stateLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.typeLabel.sd_layout
    .topEqualToView(self.timeLabel)
    .rightSpaceToView(self.bgView, 15)
    .widthIs(25)
    .heightIs(13);
    
    self.redLeftView.sd_layout
    .topSpaceToView(self.bgView, 0)
    .bottomSpaceToView(self.bgView, 0)
    .leftSpaceToView(self.bgView, 0)
    .widthIs(7);
    
    self.StorageNumLabel.sd_layout
    .topSpaceToView(self.timeLabel, 10)
    .leftSpaceToView(self.bgView, 70)
    .widthIs(250)
    .heightIs(13);
    
    //设置多出superView的部分隐藏
    self.bgView.clipsToBounds = YES;
    
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
