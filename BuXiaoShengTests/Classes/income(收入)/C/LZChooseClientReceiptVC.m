//
//  LZChooseClientReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户收款单列表筛选

#import "LZChooseClientReceiptVC.h"
#import "GBTagListView.h"

@interface LZChooseClientReceiptVC ()
{
    NSString *_type;
    NSArray *_typeAry;
    GBTagListView *_typeTag;
}
@end

@implementation LZChooseClientReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _typeAry = @[@"客户收款单",@"调整金额"];
    
    //选择筛选
    UILabel *chooseLbl = [[UILabel alloc]init];
    chooseLbl.text = @"  选择筛选";
    chooseLbl.font = FONT(14);
    chooseLbl.textColor = CD_Text99;
    chooseLbl.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:chooseLbl];
    [chooseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(29);
    }];
    
    //选择筛选
    UILabel *moneyLbl = [[UILabel alloc]init];
    moneyLbl.text = @"  类型";
    moneyLbl.font = FONT(12);
    moneyLbl.textColor = CD_Text99;
    moneyLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moneyLbl];
    [moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chooseLbl.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(29);
    }];
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(10,120, APPWidth, 0)];
    /**允许点击 */
    tagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum=2;
    /**控制是否是单选模式 */
    tagList.isSingleSelect=YES;
    tagList.signalTagColor=[UIColor whiteColor];
    [tagList setTagWithTagArray:_typeAry];
    //    __weak __typeof(self)weakSelf = self;
    [tagList setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _type = arr[0];
        }
        
        [_typeTag removeFromSuperview];
        
    }];
    [self.view addSubview:tagList];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagList.mas_bottom).offset(10);
        make.left.and.right.equalTo(self.view).offset(10);
        make.height.mas_offset(0.5);
    }];
    
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setTitle:@"确 认" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = FONT(15);
    saveBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setBackgroundColor:LZAppBlueColor];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_offset(44);
        make.bottom.equalTo(self.view);
    }];
}

- (void)saveBtnClick{
    if (self.selectBlock) {
        self.selectBlock(_type);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
