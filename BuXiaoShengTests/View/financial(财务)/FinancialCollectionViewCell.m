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
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.mas_offset(50);
            make.top.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
        }];
        [self.contentView addSubview:self.titileLabel];
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
            make.left.and.right.equalTo(self.contentView);
            make.height.mas_offset(15);
        }];
    }
    return self;
}

- (UIImageView *)iconImageView
{
    if (!iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        //        imageView.image = IMAGE(@"sale");
        imageView.backgroundColor = [UIColor clearColor];
//        imageView.frame = CGRectMake(0, 0, 50, 50);
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
        [self.contentView addSubview:(titileLabel = label)];
    }
    return titileLabel;
}

- (void)setModel:(LZHomeModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.logo]];
    self.titileLabel.text = model.name;
    if (model.name.length >4) {
        self.titileLabel.font = FONT(12);
    }
}

//- (void)setupUI
//{
//    //    iconImageView.image = IMAGE(@"sale");
//    iconImageView.sd_layout
//    .leftSpaceToView(self.contentView, 22)
//    .topSpaceToView(self.contentView, 0)
//    .widthIs(50)
//    .heightIs(50);
//    
//    titileLabel.text = @"销售";
//    titileLabel.sd_layout
//    .centerXEqualToView(iconImageView)
//    .topSpaceToView(iconImageView, 10)
//    .widthIs(72)
//    .heightIs(15);
//}

@end
