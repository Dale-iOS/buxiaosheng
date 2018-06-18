//
//  BankTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BankTableViewCell.h"
#import "LZBankDetailModel.h"

@implementation BankTableViewCell
@synthesize bgView,cornerWhiteBgView,iconImageView,titleLabel,lastLabel,addLabel,totalLabel,bottomBgView;
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
//        //        阴影的颜色
//        view.layer.shadowColor = [UIColor blackColor].CGColor;
//        //        阴影的透明度
//        view.layer.shadowOpacity = 0.7f;
//        //        阴影的偏移量
//        view.layer.shadowOffset = CGSizeMake(4,4);
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
        imageView.image = IMAGE(@"icbc");
        imageView.hidden = YES;
        [contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
//        label.text = @"中国工商银行";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
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
//        label.text = @"上期：5623.10";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        [contentView addSubview:(lastLabel = label)];
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
        label.hidden = YES;
        [contentView addSubview:(addLabel = label)];
    }
    return addLabel;
}

- (UILabel *)totalLabel
{
    if (totalLabel == nil)
    {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"累计：2454545.00";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = FONT(12);
        label.textColor = CD_Text66;
        label.hidden = YES;
        [contentView addSubview:(totalLabel = label)];
    }
    return totalLabel;
}

- (UIView *)bottomBgView
{
    if (bottomBgView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
        view.hidden = YES;
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
    .heightIs(75);
    
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
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView, -25)
    .topSpaceToView(self.contentView, 20)
    .widthIs(250)
    .heightIs(15);
    
    self.lastLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.titleLabel, 15)
    .widthIs(300)
    .heightIs(13);
    
    self.addLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.lastLabel, 10)
    .widthIs(300)
    .heightIs(13);
    
    self.totalLabel.sd_layout
    .leftEqualToView(self.titleLabel)
    .topSpaceToView(self.addLabel, 10)
    .widthIs(300)
    .heightIs(13);

}

- (void)setModel:(LZBankDetailListModel *)model{
    _model = model;
    self.titleLabel.text = _model.bankName;
    self.lastLabel.text = [NSString stringWithFormat:@"余额：%@",_model.amount];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
