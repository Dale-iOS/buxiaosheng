//
//  SalesDemandCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SalesDemandCell.h"

@implementation SalesDemandCell
@synthesize titleTF,colorTF,lineTF,numberTF,priceTF;
#define contentView  self.contentView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupAutoLayout];
    }
    return self;
}

#pragma mark ------ lazy loding ------
- (UITextField *)titleTF
{
    if (!titleTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        [contentView addSubview:(titleTF = tf)];
    }
    return titleTF;
}

- (UITextField *)colorTF
{
    if (!colorTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        [contentView addSubview:(colorTF = tf)];
    }
    return colorTF;
}

- (UITextField *)lineTF
{
    if (!lineTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        [contentView addSubview:(lineTF = tf)];
    }
    return lineTF;
}

- (UITextField *)numberTF
{
    if (!numberTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        [contentView addSubview:(numberTF = tf)];
    }
    return numberTF;
}

- (UITextField *)priceTF
{
    if (!priceTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        [contentView addSubview:(priceTF = tf)];
    }
    return priceTF;
}

- (void)setupAutoLayout
{
    self.titleTF.sd_layout
    .leftSpaceToView(contentView, 8)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth *0.32)
    .heightIs(65);
    
    self.colorTF.sd_layout
    .leftSpaceToView(self.titleTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth *0.2)
    .heightIs(65);
    
    self.lineTF.sd_layout
    .leftSpaceToView(self.colorTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth *0.14)
    .heightIs(65);
    
    self.numberTF.sd_layout
    .leftSpaceToView(self.lineTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth *0.2)
    .heightIs(65);
    
    self.priceTF.sd_layout
    .leftSpaceToView(self.numberTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(APPWidth *0.14)
    .heightIs(65);
}

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
