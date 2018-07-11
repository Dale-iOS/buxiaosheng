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
        label.backgroundColor = [UIColor greenColor];
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
        label.backgroundColor = [UIColor yellowColor];
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

