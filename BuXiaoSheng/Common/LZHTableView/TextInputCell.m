//
//  TextInputCell.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "TextInputCell.h"

@interface TextInputCell()
@end

@implementation TextInputCell
@synthesize titleLabel,contentTF,hintLabel,rightArrowImageVIew,lineView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentTF];
        [self addSubview:self.hintLabel];
        [self addSubview:self.rightArrowImageVIew];
        
//        [self setNeedsUpdateConstraints];
        [self setupSDlayout];
    }
    return self;
}

#pragma mark ----- lazy loding -----
- (UILabel *)titleLabel
{
    if (!titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UITextField *)contentTF
{
    if (!contentTF) {
        
        UITextField *tf = [[UITextField alloc]init];
        tf.textColor = CD_Text33;
        tf.font = FONT(14);
//        tf.backgroundColor = [UIColor redColor];
        tf.textAlignment = NSTextAlignmentLeft;
//        tf.delegate = self;
//        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:(contentTF = tf)];
    }
    return contentTF;
}

- (UILabel *)hintLabel
{
    if (!hintLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_textCC;
        label.text = @"选择收款方式";
        label.hidden = YES;
        label.textAlignment = NSTextAlignmentLeft;
//        label.hidden = YES;
        [self addSubview:(hintLabel = label)];
    }
    return hintLabel;
}

- (UIImageView *)rightArrowImageVIew
{
    if (!rightArrowImageVIew) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.hidden = YES;
        imageView.image = IMAGE(@"rightarrow");
        [self addSubview:(rightArrowImageVIew = imageView)];
    }
    return rightArrowImageVIew;
}

- (UIView *)lineView
{
    if (!lineView) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self addSubview:(lineView = view)];
    }
    return lineView;
}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).with.offset(15);
//        make.centerY.equalTo(self.mas_centerY);
//
//    }];
//}

//自动布局
- (void)setupSDlayout
{
    self.titleLabel.sd_layout
//    .topSpaceToView(self, 1)
    .topEqualToView(self)
    .leftSpaceToView(self, 15)
    .heightRatioToView(self, 1)
    .widthIs(100);
    
    self.contentTF.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self.titleLabel, 10)
    .heightRatioToView(self, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    self.rightArrowImageVIew.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, 15)
    .widthIs(8)
    .heightIs(14);
    
    self.hintLabel.sd_layout
    .topEqualToView(self)
    .rightSpaceToView(self.rightArrowImageVIew, 10)
//    .heightRatioToView(self, 1)
    .widthIs(90)
    .heightRatioToView(self, 1);
    
    self.lineView.sd_layout
    .bottomSpaceToView(self, 0)
    .widthRatioToView(self, 1)
    .leftSpaceToView(self, 0)
    .heightIs(1);
}

@end
