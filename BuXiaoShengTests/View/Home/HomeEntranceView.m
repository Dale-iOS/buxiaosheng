//
//  HomeEntranceView.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "HomeEntranceView.h"

@implementation HomeEntranceView
@synthesize imageView1,titile1,imageView2,titile2,imageView3,titile3;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.imageView1];
        [self addSubview:self.titile1];
        [self addSubview:self.imageView2];
        [self addSubview:self.titile2];
        [self addSubview:self.imageView3];
        [self addSubview:self.titile3];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

#pragma mark ------- lazy loading ---------
- (UIImageView *)imageView1
{
    if (!imageView1) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"sale");
        [self addSubview:(imageView1 = imageView)];
    }
    return imageView1;
}

- (UILabel *)titile1
{
    if (!titile1) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"销售";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:(titile1 = label)];
    }
    return titile1;
}

- (UIImageView *)imageView2
{
    if (!imageView2) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"financial");
        [self addSubview:(imageView2 = imageView)];
    }
    return imageView2;
}

- (UILabel *)titile2
{
    if (!titile2) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"财务";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:(titile2 = label)];
    }
    return titile2;
}

- (UIImageView *)imageView3
{
    if (!imageView3) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = IMAGE(@"warehouse");
        [self addSubview:(imageView3 = imageView)];
    }
    return imageView3;
}

- (UILabel *)titile3
{
    if (!titile3) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"仓库";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:(titile3 = label)];
    }
    return titile3;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
        make.left.equalTo(self).with.offset(UIAdaptiveRate(50));
        make.width.equalTo(@(UIAdaptiveRate(50)));
        make.height.equalTo(@(UIAdaptiveRate(50)));
    }];
    
    [self.titile1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //    make.top.equalTo(self.imageView1.mas_bottom).width.offset(UIAdaptiveRate(-10));
        //        make.left.equalTo(self.imageView1);
        //        make.right.equalTo(self.imageView1);
        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
        make.left.equalTo(self).with.offset(UIAdaptiveRate(50));
        make.width.equalTo(@(UIAdaptiveRate(50)));
        make.height.equalTo(@(UIAdaptiveRate(26)));
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
        make.left.equalTo(self.imageView1.mas_right).with.offset(UIAdaptiveRate(80));
        make.width.equalTo(@(UIAdaptiveRate(50)));
        make.height.equalTo(@(UIAdaptiveRate(50)));
    }];
    
    [self.titile2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
        make.left.equalTo(self.imageView2);
        //        make.right.equalTo(self.imageView2);
        //        make.left.equalTo(self).with.offset(UIAdaptiveRate(145));
        //        make.centerY.equalTo(self.imageView2);
        make.width.equalTo(@(50));
        make.height.equalTo(@(UIAdaptiveRate(26)));
    }];
    //
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
        make.left.equalTo(self.imageView2.mas_right).with.offset(UIAdaptiveRate(80));
        make.width.equalTo(@(UIAdaptiveRate(50)));
        make.height.equalTo(@(UIAdaptiveRate(50)));
    }];
    
    [self.titile3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
        make.left.equalTo(self.imageView3);
        
        make.width.equalTo(@(50));
        make.height.equalTo(@(UIAdaptiveRate(26)));
    }];
    
    
}


@end

