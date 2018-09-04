//
//  SettingCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell
@synthesize iconImageView,titleLabel,rightArrowImageVIew,lineView,rigthLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightArrowImageVIew];
        [self addSubview:self.rigthLabel];
        
        [self setupSDlayout];
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (iconImageView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        [self addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titleLabel
{
    if (titleLabel == nil) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UIImageView *)rightArrowImageVIew
{
    if (rightArrowImageVIew == nil) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.hidden = YES;
        imageView.image = IMAGE(@"rightarrow");
        [self addSubview:(rightArrowImageVIew = imageView)];
    }
    return rightArrowImageVIew;
}

- (UILabel *)rigthLabel
{
    if (rigthLabel == nil) {
        UILabel *label = [[UILabel alloc]init];
        label.hidden = YES;
        label.font = FONT(14);
        label.textColor = CD_Text99;
        label.textAlignment = NSTextAlignmentRight;
//        label.backgroundColor = [UIColor redColor];
        [self addSubview:(rigthLabel = label)];
    }
    return rigthLabel;
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

- (void)setupSDlayout
{
    self.iconImageView.sd_layout
    .leftSpaceToView(self, 15)
    .widthIs(19)
    .heightIs(19)
    .centerYEqualToView(self);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.iconImageView, 15)
    .widthIs(250)
    .heightIs(15)
    .centerYEqualToView(self);
    
    self.rightArrowImageVIew.sd_layout
    .topSpaceToView(self, 17)
    .rightSpaceToView(self, 15)
    .widthIs(8)
    .heightIs(14);
    
    self.rigthLabel.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, 15)
    .widthIs(40)
    .heightIs(15);
    
    self.lineView.sd_layout
    .bottomSpaceToView(self, 0)
    .widthRatioToView(self, 1)
    .leftSpaceToView(self, 0)
    .heightIs(1);
}

@end
