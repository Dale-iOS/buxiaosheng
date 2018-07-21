//
//  LZChangeNumVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChangeNumVC.h"

@interface LZChangeNumVC ()
{
    UILabel *_hintLbl;//总数量
    double _total;//计算中的数量值
    UIButton *_verifyBtn;//确认按钮
}
@end

@implementation LZChangeNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
//    self.originalValue = 10;
    
    NSString *tempStr = [NSString stringWithFormat:@"%zd",self.originalValue];
    _total = [tempStr doubleValue];
    
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
    
    //总数量 用于改变
    _hintLbl = [[UILabel alloc]init];
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %ld",self.originalValue];
    _hintLbl.textColor = LZAppRedColor;
    _hintLbl.font = FONT(12);
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    [self.view addSubview:_hintLbl];
    [_hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(titleLbl.mas_bottom).offset(15);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    //原始总数量
    UILabel *firstLbl = [[UILabel alloc]init];
    firstLbl.text = [NSString stringWithFormat:@"初始 总数量： %ld",self.originalValue];
    firstLbl.textColor = LZAppBlueColor;
    firstLbl.font = FONT(12);
    NSMutableAttributedString *temgpStr1 = [[NSMutableAttributedString alloc] initWithString:firstLbl.text];
    NSRange oneRange1 = [[temgpStr1 string] rangeOfString:[NSString stringWithFormat:@"初始 总数量："]];
    [temgpStr1 addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange1];
    firstLbl.attributedText = temgpStr1;
    [self.view addSubview:firstLbl];
    [firstLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(_hintLbl.mas_bottom).offset(5);
        make.width.mas_offset(250);
        make.height.mas_offset(15);
    }];
    
    //重置按钮
    UIButton *restartBtn = [[UIButton alloc]init];
    [restartBtn setBackgroundImage:IMAGE(@"restart") forState:UIControlStateNormal];
    [restartBtn addTarget:self action:@selector(restartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restartBtn];
    [restartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(_hintLbl.mas_bottom).offset(5);
        make.width.mas_offset(50);
        make.height.mas_offset(19);
    }];
    
    
    //    加号按钮
    UIButton *additionBtn = [[UIButton alloc]init];
    [additionBtn setBackgroundImage:IMAGE(@"addition") forState:UIControlStateNormal];
    [additionBtn addTarget:self action:@selector(additionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:additionBtn];
    [additionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
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
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
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
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
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
        make.top.equalTo(firstLbl.mas_bottom).offset(15);
        make.height.mas_offset(29);
        make.width.mas_offset((APPWidth *0.75 -15*5)/4);
    }];
    
    
    //确认按钮
    _verifyBtn = [[UIButton alloc]init];
    _verifyBtn.backgroundColor = LZAppBlueColor;
    [_verifyBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(verifyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_verifyBtn];
    [_verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
}

#pragma mark ---- 点击事件 ----
//加号方法
- (void)additionBtnClick{
    _total++;
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    if (self.NumValueBlock) {
        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    }
}
//减号方法
- (void)subtractionBtnClick{
    _total--;
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    if (self.NumValueBlock) {
        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    }
}
//乘号方法
- (void)multiplicationBtnClick{
    _total = _total *0.9;
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    if (self.NumValueBlock) {
        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    }
}
//除号方法
- (void)divisionBtnClick{
    _total = _total /0.9;
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %.1lf",_total];
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
    if (self.NumValueBlock) {
        self.NumValueBlock([NSString stringWithFormat:@"%.1lf",_total]);
    }
}
//重置方法
- (void)restartClick{
 
    _hintLbl.text = [NSString stringWithFormat:@"当前 总数量： %zd",self.originalValue];

    _total = [[NSString stringWithFormat:@"%zd",self.originalValue] doubleValue];
    
    NSMutableAttributedString *temgpStr = [[NSMutableAttributedString alloc] initWithString:_hintLbl.text];
    NSRange oneRange = [[temgpStr string] rangeOfString:[NSString stringWithFormat:@"当前 总数量："]];
    [temgpStr addAttribute:NSForegroundColorAttributeName value:CD_Text99 range:oneRange];
    _hintLbl.attributedText = temgpStr;
}

//确认按钮方法
- (void)verifyBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
