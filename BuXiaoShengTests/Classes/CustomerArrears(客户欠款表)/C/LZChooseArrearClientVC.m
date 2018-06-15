//
//  LZChooseArrearClientVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseArrearClientVC.h"
#import "TTGTextTagCollectionView.h"

@interface LZChooseArrearClientVC ()

@end

@implementation LZChooseArrearClientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //选择筛选
    UILabel *chooseLbl = [[UILabel alloc]init];
    chooseLbl.text = @"  选择筛选";
    chooseLbl.font = FONT(14);
    chooseLbl.textColor = CD_Text99;
    chooseLbl.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:chooseLbl];
    [chooseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(29);
    }];
    
    //选择筛选
    UILabel *moneyLbl = [[UILabel alloc]init];
    moneyLbl.text = @" 还款金额排序";
    moneyLbl.font = FONT(12);
    moneyLbl.textColor = CD_Text99;
    moneyLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moneyLbl];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseLbl.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(29);
    }];
    
    TTGTextTagCollectionView *tagMoneyCollectionView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tagMoneyCollectionView];
    [tagMoneyCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLbl.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    [tagMoneyCollectionView addTags:@[@"金额从高到低", @"金额从低到高"]];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagMoneyCollectionView.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view).offset(10);
        make.height.mas_offset(0.5);
    }];
    
    //选择筛选
    UILabel *dateLbl = [[UILabel alloc]init];
    dateLbl.text = @" 最后还款日期";
    dateLbl.font = FONT(12);
    dateLbl.textColor = CD_Text99;
    dateLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateLbl];
    [dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(29);
    }];
    
    TTGTextTagCollectionView *tagDateCollectionView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tagDateCollectionView];
    [tagDateCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateLbl.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    [tagDateCollectionView addTags:@[@"从远到进", @"从近到远"]];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagDateCollectionView.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view).offset(10);
        make.height.mas_offset(0.5);
    }];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"确认" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = FONT(15);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
