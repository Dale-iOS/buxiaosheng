//
//  FinancialCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "FinancialCollectionViewCell.h"

@implementation FinancialCollectionViewCell
@synthesize iconImageView,titileLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titileLabel];
        [self setupUI];
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        //        imageView.image = IMAGE(@"sale");
        imageView.backgroundColor = [UIColor clearColor];
        imageView.frame = CGRectMake(0, 0, 50, 50);
        [self.contentView addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titileLabel
{
    if (!titileLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"阿四季豆阿萨德";
        [self.contentView addSubview:(titileLabel = label)];
    }
    return titileLabel;
}

- (void)setupUI
{
    //    iconImageView.image = IMAGE(@"sale");
    iconImageView.sd_layout
    .leftSpaceToView(self.contentView, 22)
    .topSpaceToView(self.contentView, 0)
    .widthIs(50)
    .heightIs(50);
    
    titileLabel.text = @"销售";
    titileLabel.sd_layout
    .centerXEqualToView(iconImageView)
    .topSpaceToView(iconImageView, 10)
    .widthIs(72)
    .heightIs(15);
}

@end
