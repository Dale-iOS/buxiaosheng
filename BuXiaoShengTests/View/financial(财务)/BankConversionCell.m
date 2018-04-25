//
//  BankConversionCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BankConversionCell.h"

@implementation BankConversionCell
@synthesize intoBankView,intoBankLbl,conversionImageView,outBankView,outBankLbl,outPriceLbl;
#define contentView   self.contentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSDlayout];
    }
    return self;
}

- (UIView *) outBankView
{
    if (outBankView == nil) {
        
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor greenColor];
        [self addSubview:(outBankView = view)];
    }
    return outBankView;
}

- (UILabel *)outBankLbl
{
    if (outBankLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_textCC;
        label.text = @"选择到账银行";
        [self.outBankView addSubview:(outBankLbl = label)];
    }
    return outBankLbl;
}

- (UILabel *)outPriceLbl
{
    if (outPriceLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text99;
        label.text = @"￥2500";
        [self.outBankView addSubview:(outPriceLbl = label)];
    }
    return outPriceLbl;
}

- (UIImageView *)conversionImageView
{
    if (conversionImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"conversionbank");
        [self addSubview:(conversionImageView = imageView)];
    }
    return conversionImageView;
}

- (UIView *)intoBankView
{
    if (intoBankView == nil) {
        
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor yellowColor];
        [self addSubview:(intoBankView = view)];
    }
    return intoBankView;
}

- (UILabel *)intoBankLbl
{
    if (intoBankLbl == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text66;
        label.text = @"中国农业银行";
        [self.intoBankView addSubview:(intoBankLbl = label)];
    }
    return intoBankLbl;
}

- (void)setupSDlayout
{
    self.outBankView.sd_layout
    .leftSpaceToView(self, 50)
    .topSpaceToView(self, 0)
    .widthIs(100)
    .heightRatioToView(self, 1);
    
    self.outBankLbl.sd_layout
    .leftSpaceToView(self.outBankView, 0)
    .topSpaceToView(self.outBankView, 20)
    .widthIs(100)
    .heightIs(15);
    
    self.outPriceLbl.sd_layout
    .leftSpaceToView(self.outBankView, 0)
    .topSpaceToView(self.outPriceLbl, 12)
    .widthIs(100)
    .heightIs(13);
    
    self.conversionImageView.sd_layout
    .widthIs(19)
    .heightIs(14)
    .centerXEqualToView(self)
    .centerYEqualToView(self);
    
    self.intoBankView.sd_layout
    .rightSpaceToView(self, 50)
    .topSpaceToView(self, 0)
    .widthIs(100)
    .heightRatioToView(self, 1);
    
    self.intoBankLbl.sd_layout
    .leftSpaceToView(self.inputView, 0)
    .topSpaceToView(self.inputView, 20)
    .widthIs(100)
    .heightIs(15);
    
}



@end






//#import "bankTableViewCell.h"
//
//@implementation bankTableViewCell
//@synthesize bgView,cornerWhiteBgView,iconImageView,titleLabel,lastLabel,addLabel,totalLabel,bottomBgView;
//#define contentView   self.contentView
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//
//        self.selectionStyle = UITableViewCellAccessoryNone;
//
//        self.backgroundColor = [UIColor clearColor];
//
//        [self setSDlayout];
//
//    }
//    return self;
//}
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//}
//
//- (UIView *)bgView
//{
//    if (bgView == nil) {
//
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        view.layer.cornerRadius = 5.0f;
//        [contentView addSubview:(bgView = view)];
//    }
//    return bgView;
//}
//
//- (UIView *)cornerWhiteBgView
//{
//    if (cornerWhiteBgView == nil) {
//
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor whiteColor];
//        //        view.layer.cornerRadius = 5.0f;
//        [contentView addSubview:(cornerWhiteBgView = view)];
//    }
//    return cornerWhiteBgView;
//}
//
//- (UIImageView *)iconImageView
//{
//    if (iconImageView == nil)
//    {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = IMAGE(@"icbc");
//        [contentView addSubview:(iconImageView = imageView)];
//    }
//    return iconImageView;
//}
//
//- (UILabel *)titleLabel
//{
//    if (titleLabel == nil)
//    {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"中国工商银行";
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont boldSystemFontOfSize:14];
//        label.textColor = CD_Text33;
//        [contentView addSubview:(titleLabel = label)];
//    }
//    return titleLabel;
//}
//
//- (UILabel *)lastLabel
//{
//    if (lastLabel == nil)
//    {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"上期：5623.10";
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = FONT(12);
//        label.textColor = CD_Text66;
//        [contentView addSubview:(lastLabel = label)];
//    }
//    return lastLabel;
//}
//
//- (UILabel *)addLabel
//{
//    if (addLabel == nil)
//    {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"新增：261345.11";
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = FONT(12);
//        label.textColor = CD_Text66;
//        [contentView addSubview:(addLabel = label)];
//    }
//    return addLabel;
//}
//
//- (UILabel *)totalLabel
//{
//    if (totalLabel == nil)
//    {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"累计：2454545.00";
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = FONT(12);
//        label.textColor = CD_Text66;
//        [contentView addSubview:(totalLabel = label)];
//    }
//    return totalLabel;
//}
//
//- (UIView *)bottomBgView
//{
//    if (bottomBgView == nil) {
//
//        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor redColor];
//        [contentView addSubview:(bottomBgView = view)];
//    }
//    return bottomBgView;
//}
//
//- (void)setSDlayout
//{
//    self.bgView.sd_layout
//    .topSpaceToView(contentView, 5)
//    .leftSpaceToView(contentView, 0)
//    .widthIs(APPWidth -30)
//    .heightIs(133);
//
//    //    self.bottomBgView.sd_layout
//    //    .bottomSpaceToView(self.bgView, -10)
//    //    .leftSpaceToView(contentView, 0)
//    //    .widthIs(APPWidth -30)
//    //    .heightIs(10);
//
//    //    self.cornerWhiteBgView.sd_layout
//    //    .topSpaceToView(self.bgView, 0)
//    //    .leftSpaceToView(self.bgView, 0)
//    //    .widthIs(APPWidth -30)
//    //    .heightIs(10);
//
//    self.iconImageView.sd_layout
//    .leftSpaceToView(contentView, 15)
//    //    .centerYEqualToView(self.bgView)
//    .topSpaceToView(contentView, 40)
//    .widthIs(40)
//    .heightIs(40);
//
//    self.titleLabel.sd_layout
//    .leftSpaceToView(self.iconImageView, 15)
//    .topSpaceToView(self.contentView, 20)
//    .widthIs(250)
//    .heightIs(15);
//
//    self.lastLabel.sd_layout
//    .leftEqualToView(self.titleLabel)
//    .topSpaceToView(self.titleLabel, 15)
//    .widthIs(300)
//    .heightIs(13);
//
//    self.addLabel.sd_layout
//    .leftEqualToView(self.titleLabel)
//    .topSpaceToView(self.lastLabel, 10)
//    .widthIs(300)
//    .heightIs(13);
//
//    self.totalLabel.sd_layout
//    .leftEqualToView(self.titleLabel)
//    .topSpaceToView(self.addLabel, 10)
//    .widthIs(300)
//    .heightIs(13);
//
//
//
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//@end
