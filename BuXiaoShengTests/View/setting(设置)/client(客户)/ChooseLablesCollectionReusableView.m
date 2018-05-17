//
//  ChooseLablesCollectionReusableView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ChooseLablesCollectionReusableView.h"
@interface ChooseLablesCollectionReusableView ()<UITextFieldDelegate>
@end

@implementation ChooseLablesCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, APPWidth *0.75 -20, 34)];
        self.tf.placeholder = @"   输入自定义选项";
        self.tf.layer.borderColor = CD_Text99.CGColor;
        self.tf.layer.borderWidth = 0.5;
        self.tf.layer.cornerRadius = 5.0f;
        self.tf.textColor = CD_Text33;
        self.tf.delegate = self;
        [self addSubview:self.tf];
        
//        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
//        self.titleLbl.textColor = [UIColor blackColor];
//        [self addSubview:self.titleLbl];

    }
    return self;
}

- (void)setupUI
{
    
}

@end
