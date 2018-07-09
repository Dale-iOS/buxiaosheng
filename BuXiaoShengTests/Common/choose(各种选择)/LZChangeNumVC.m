//
//  LZChangeNumVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChangeNumVC.h"

@interface LZChangeNumVC ()

@end

@implementation LZChangeNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.originalValue = 33;
    
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.backgroundColor = LZHBackgroundColor;
    titleLbl.text = @"  修改数量";
    titleLbl.textColor = CD_Text99;
    titleLbl.font = FONT(12);
    titleLbl.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44);
        make.height.mas_offset(30);
    }];
    
    UILabel *hintLbl = [[UILabel alloc]init];
    hintLbl.text = [NSString stringWithFormat:@"全部加减 总数量： %ld",self.originalValue];
//    hintLbl.text = @"全部加减 总数量 33.0";
    hintLbl.textColor = LZAppBlueColor;
    hintLbl.font = FONT(12);
    
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"全部加减 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    hintLbl.attributedText = temgpStr;
    
    [self.view addSubview:hintLbl];
    [hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(titleLbl.mas_bottom).offset(15);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    
    //    加号按钮
    UIButton *additionBtn = [[UIButton alloc]init];
    [additionBtn setBackgroundImage:IMAGE(@"addition") forState:UIControlStateNormal];
    [additionBtn addTarget:self action:@selector(additionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:additionBtn];
    [additionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(hintLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];

    //    减号按钮
    UIButton *subtractionBtn = [[UIButton alloc]init];
    [subtractionBtn setBackgroundImage:IMAGE(@"subtraction") forState:UIControlStateNormal];
    [subtractionBtn addTarget:self action:@selector(subtractionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subtractionBtn];
    [subtractionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(additionBtn.mas_right).offset(15);
        make.top.equalTo(hintLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    //    乘号按钮
    UIButton *multiplicationBtn = [[UIButton alloc]init];
    [multiplicationBtn setBackgroundImage:IMAGE(@"multiplication") forState:UIControlStateNormal];
    [multiplicationBtn addTarget:self action:@selector(multiplicationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:multiplicationBtn];
    [multiplicationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(subtractionBtn.mas_right).offset(15);
        make.top.equalTo(hintLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    //    除号按钮
    UIButton *divisionBtn = [[UIButton alloc]init];
    [divisionBtn setBackgroundImage:IMAGE(@"division") forState:UIControlStateNormal];
    [divisionBtn addTarget:self action:@selector(divisionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:divisionBtn];
    [divisionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(multiplicationBtn.mas_right).offset(15);
        make.top.equalTo(hintLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
}

#pragma mark ---- 点击事件 ----
- (void)additionBtnClick{
    
}

- (void)subtractionBtnClick{
    
}

- (void)multiplicationBtnClick{
    
}

- (void)divisionBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
