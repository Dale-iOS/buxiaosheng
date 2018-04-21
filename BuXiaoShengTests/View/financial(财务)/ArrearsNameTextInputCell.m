//
//  ArrearsNameTextInputCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  名称 前欠款(收款单)

#import "ArrearsNameTextInputCell.h"

@implementation ArrearsNameTextInputCell
@synthesize titleLabel,beforeLabel,contentTF,lineView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentTF];
        [self addSubview:self.beforeLabel];
        [self addSubview:self.lineView];
      
        [self setupSDlayout];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil) {
        
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

- (UILabel *)beforeLabel
{
    if (beforeLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(12);
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:(beforeLabel = label)];
    }
    return beforeLabel;
}

- (UIView *)lineView
{
    if (lineView == nil) {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self addSubview:(lineView = view)];
    }
    return lineView;
}

- (void)setupSDlayout
{
    self.titleLabel.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self, 20)
    .widthIs(29)
    .heightIs(15);
    
    self.beforeLabel.sd_layout
    .leftSpaceToView(self, 15)
    .topSpaceToView(self.titleLabel, 10)
    .widthIs(200)
    .heightIs(13);
    
    self.contentTF.sd_layout
    .leftSpaceToView(self, 120)
    .topSpaceToView(self, 20)
    .rightSpaceToView(self, 15)
    .heightIs(15);
    
    self.lineView.sd_layout
    .bottomSpaceToView(self, 1)
    .widthRatioToView(self, 1)
    .leftSpaceToView(self, 0)
    .heightIs(1);
}

@end
