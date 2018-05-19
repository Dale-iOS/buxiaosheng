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

        self.userInteractionEnabled = YES;
        
        self.tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, APPWidth *0.75 -20, 34)];
        self.tf.placeholder = @"   输入自定义选项";
        self.tf.layer.borderColor = CD_Text99.CGColor;
        self.tf.layer.borderWidth = 0.5;
        self.tf.layer.cornerRadius = 5.0f;
        self.tf.textColor = CD_Text33;
        self.tf.delegate = self;
        self.tf.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.tf];
        
        
        //添加按钮的白色底图
        UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 25)];
        addView.backgroundColor = [UIColor whiteColor];
        addView.userInteractionEnabled = YES;
        UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [addView addGestureRecognizer:tap];


        UILabel *addLbl = [[UILabel alloc]init];
        addLbl.backgroundColor = [UIColor whiteColor];
        addLbl.text = @"添加";
        addLbl.textAlignment = NSTextAlignmentCenter;
        addLbl.textColor = CD_Text66;
        addLbl.font = FONT(12);
        addLbl.userInteractionEnabled = NO;
        [addView addSubview:addLbl];
        addLbl.sd_layout
        .widthIs(25)
        .heightIs(13)
        .centerXEqualToView(addView)
        .centerYEqualToView(addView);

        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = CD_Text99;
        [addView addSubview:lineView];
        lineView.sd_layout
        .heightIs(15)
        .widthIs(1)
        .centerYEqualToView(addView)
        .leftSpaceToView(addView, 0);


        self.tf.rightView = addView;
        self.tf.rightViewMode = UITextFieldViewModeAlways;
        
//        self.titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 300, 20)];
//        self.titleLbl.textColor = [UIColor blackColor];
//        [self addSubview:self.titleLbl];

    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 0) {
        self.tfStr = string;
        return YES;
    }
    return NO;
}

- (void)tapClick
{
    if ([self.delegate respondsToSelector:@selector(didClickAddBtnInTextfeild:)]) {
        [self.delegate didClickAddBtnInTextfeild:self];
    }
}

@end
