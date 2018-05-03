//
//  DefaultBankCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加银行默认

#import "DefaultBankCell.h"

@implementation DefaultBankCell
@synthesize selectImageView,titleLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        [self setupSDlayout];
    }
    return self;
}

#pragma mark ----- lazy loding -----
- (UIImageView *)selectImageView
{
    if (!selectImageView) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:(selectImageView = imageView)];
    }
    return selectImageView;
}

- (UILabel *)titleLabel
{
    if (!titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentLeft;
        label.text = @"设为默认";
        [self addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

//自动布局
- (void)setupSDlayout
{
    self.selectImageView.sd_layout
    .widthIs(19)
    .heightIs(19)
    .leftSpaceToView(self, 15)
    .centerYEqualToView(self);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.selectImageView, 10)
    .widthIs(250)
    .heightIs(15)
    .centerYEqualToView(self);
}


@end
