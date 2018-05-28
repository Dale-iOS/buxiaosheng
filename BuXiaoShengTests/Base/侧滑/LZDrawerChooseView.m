//
//  LZDrawerChooseView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDrawerChooseView.h"

@implementation LZDrawerChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _alphaiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        _alphaiView.backgroundColor = [UIColor clearColor];
        _alphaiView.alpha = 0.8;
        [self addSubview:_alphaiView];
        
        //白色底图
        _bgWhiteView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth *0.25, 0, APPWidth *0.75, APPHeight)];
        _bgWhiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgWhiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_bgWhiteView addGestureRecognizer:tap];
        
        //确认按钮
        _makeSureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, APPHeight -50, APPWidth *0.75, 50)];
        [_makeSureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_makeSureBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
        
        [_bgWhiteView addSubview:_makeSureBtn];
        
    }
    return self;
}

#pragma mark ------ 点击事件 -------
- (void)tapClick
{
    NSLog(@"点击了白色底图");
}

@end
