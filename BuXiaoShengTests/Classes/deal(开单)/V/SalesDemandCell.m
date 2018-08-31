//
//  SalesDemandCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SalesDemandCell.h"


@interface SalesDemandCell()<UITextFieldDelegate>
@end;

@implementation SalesDemandCell

@synthesize titleTF,colorTF,lineTF,numberTF,priceTF;
#define contentView  self.contentView

-(void)setModel:(productListModel *)model {
    _model = model;
    titleTF.text = model.name;
    lineTF.text = @"1";
    priceTF.text = model.shearPrice;
    colorTF.text = model.colorModel.name;
    numberTF.text = model.number;
}

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
        tf.delegate = self;
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"请选择品名";
        tf.delegate = self;
        tf.userInteractionEnabled = YES;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(titleTF = tf)];
    }
    return titleTF;
}

- (UITextField *)colorTF
{
    if (!colorTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.delegate = self;
        tf.font = FONT(14);
        tf.textColor = CD_Text33;
        tf.placeholder = @"请选择颜色";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
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
//        tf.placeholder = @"条数";
        tf.delegate = self;
        tf.text = @"1";
        tf.enabled = NO;
        tf.textAlignment = NSTextAlignmentCenter;
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
        tf.placeholder = @"数量";
        tf.delegate = self;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.textAlignment = NSTextAlignmentCenter;
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
        //tf.userInteractionEnabled = false;
        tf.placeholder = @"单价";
        tf.delegate = self;
        tf.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:(priceTF = tf)];
    }
    return priceTF;
}

- (void)setupAutoLayout
{
//    [self.titleTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(contentView).offset(0);
//        make.centerY.equalTo(contentView);
//        make.width.offset(LZHScale_WIDTH(240));
//        make.height.offset(65);
//    }];
    
    self.titleTF.sd_layout
    .leftSpaceToView(contentView, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(240))
    .heightIs(65);
    
    self.colorTF.sd_layout
    .leftSpaceToView(self.titleTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.lineTF.sd_layout
    .leftSpaceToView(self.colorTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);
    
    self.numberTF.sd_layout
    .leftSpaceToView(self.lineTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(150))
    .heightIs(65);
    
    self.priceTF.sd_layout
    .leftSpaceToView(self.numberTF, 0)
    .centerYEqualToView(contentView)
    .widthIs(LZHScale_WIDTH(105))
    .heightIs(65);

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.titleTF]) {
//        if ([self.delegate respondsToSelector:@selector(didClickTitleTextField:)]) {
//            [self.delegate didClickTitleTextField:self.titleTF];
//        }
        if ([self.delegate respondsToSelector:@selector(didClickTitleTextField:andCell:)]) {
            [self.delegate didClickTitleTextField:self.titleTF andCell:self];
        }
    }
    if ([textField isEqual:self.colorTF]) {
        if ([self.delegate respondsToSelector:@selector(didClickColorTextField:)]) {
            [self.delegate didClickColorTextField:self];
        }
    }
    if (textField == self.titleTF || textField == self.colorTF) {
        return false;
    }
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.numberTF) {
        self.model.number = textField.text;
        if ([self.delegate respondsToSelector:@selector(didClickNumberTextField:)]) {
            [self.delegate didClickNumberTextField:self];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.numberTF) {
        if ([self.delegate respondsToSelector:@selector(didClickNumberTextField:)]) {
            [self.delegate didClickNumberTextField:self];
        }
    }
    return true;
}



- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
