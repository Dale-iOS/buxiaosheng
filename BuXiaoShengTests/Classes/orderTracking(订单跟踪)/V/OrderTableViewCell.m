//
//  OrderTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "LZOrderTrackingModel.h"

@implementation OrderTableViewCell
@synthesize bgView,iconImageView,companyLabel,nameLabel,demandLabel,OutNumLabel,priceLabel,timeLabel,procurementLabel,procurementInfoLabel,processedLabel,iconLabel;
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
        label.text = @"companyLabel";
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
        label.text = @"nameLabel";
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
        label.text = @"demandlabel ";
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
        label.text = @" outnumLabel";
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
        label.text = @"priceLabel";
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
        label.text = @" timeLabel";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [self.bgView addSubview:(timeLabel = label)];
    }
    return timeLabel;
}

- (UILabel *)procurementLabel
{
    if (!procurementLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"采购中";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        label.backgroundColor =[UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:0.2f];
        label.layer.cornerRadius = 2.0f;
        label.layer.masksToBounds = YES;
        label.hidden = YES;
        [self.bgView addSubview:(procurementLabel = label)];
    }
    return procurementLabel;
}

- (UILabel *)procurementInfoLabel
{
    if (!procurementInfoLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"采购信息";
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
        label.layer.cornerRadius = 5.0f;
        label.layer.masksToBounds = YES;
        label.font = FONT(13);
        label.hidden = YES;
        [self.bgView addSubview:(procurementInfoLabel = label)];
    }
    return procurementInfoLabel;
}

- (UILabel *)processedLabel
{
    if (!processedLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"已下单待处理";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12);
        label.textColor = [UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
        label.backgroundColor =[UIColor colorWithRed:35.0f/255.0f green:196.0f/255.0f blue:220.0f/255.0f alpha:0.2f];
        label.layer.cornerRadius = 2.0f;
        label.hidden = YES;
        label.layer.masksToBounds = YES;
        [self.bgView addSubview:(processedLabel = label)];
    }
    return processedLabel;
}

- (UILabel *)iconLabel
{
    if (!iconLabel)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(13);
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        label.backgroundColor =[UIColor clearColor];
        [self.iconImageView addSubview:(iconLabel = label)];
    }
    return iconLabel;
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
    

    self.companyLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.bgView, 10)
    .heightIs(15);
    [self.companyLabel setSingleLineAutoResizeWithMaxWidth:300];
    

    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.companyLabel, 10)
    .heightIs(13);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:300];
    

    self.demandLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.demandLabel setSingleLineAutoResizeWithMaxWidth:100];
    

    self.OutNumLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.OutNumLabel setSingleLineAutoResizeWithMaxWidth:180];
    
    self.priceLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 135)
    .topSpaceToView(self.nameLabel, 10)
    .heightIs(13);
    [self.priceLabel setSingleLineAutoResizeWithMaxWidth:60];
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .topSpaceToView(self.demandLabel, 10)
    .heightIs(13);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    self.iconLabel.sd_layout
    .widthIs(40)
    .heightIs(14)
    .centerXEqualToView(self.iconImageView)
    .centerYEqualToView(self.iconImageView);
    
    self.processedLabel.sd_layout
    .widthIs(80)
    .heightIs(20)
    .rightSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 15);
    
    
    self.procurementLabel.sd_layout
    .widthIs(60)
    .heightIs(20)
    .rightSpaceToView(self.bgView, 15)
    .topSpaceToView(self.bgView, 15);
    
    self.procurementInfoLabel.sd_layout
    .widthIs(64)
    .heightIs(29)
    .rightSpaceToView(self.bgView, 15)
    .bottomSpaceToView(self.bgView, 15);
}

- (void)setModel:(LZOrderTrackingModel *)model
{
    _model = model;
    if (_model.drawerName.length >3) {
        self.iconLabel.text = [_model.drawerName substringFromIndex:3];
    }else{
        self.iconLabel.text = _model.drawerName;
    }
    self.nameLabel.text = _model.productName;
    self.companyLabel.text = _model.customerName;
    self.demandLabel.text = [NSString stringWithFormat:@"出库数:%@",_model.number];
    self.priceLabel.text = [NSString stringWithFormat:@"￥:%@",_model.price];
    self.timeLabel.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
    
//采购状态（0：未采购 1：采购中）
    if ([_model.buyStatus isEqualToString:@"0"]) {
        self.processedLabel.hidden = NO;
    }else if ([_model.buyStatus isEqualToString:@"1"])
    {
        self.procurementLabel.hidden = NO;
        self.procurementInfoLabel.hidden = NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
