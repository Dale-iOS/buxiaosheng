//
//  HomeEntranceCell.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "HomeEntranceCell.h"
#import "SDAutoLayout.h"
@interface HomeEntranceCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titileLabel;

@end

@implementation HomeEntranceCell
@synthesize iconImageView,titileLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [self addSubview:(iconImageView = imageView)];
    }
    return iconImageView;
}

- (UILabel *)titileLabel
{
    if (!titileLabel) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:(titileLabel = label)];
    }
    return titileLabel;
}

- (void)setupUI
{
    
}












@end
