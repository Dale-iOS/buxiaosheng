//
//  LZChooseArrearClientVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseArrearClientVC.h"
#import "TTGTextTagCollectionView.h"
#import "GBTagListView.h"

@interface LZChooseArrearClientVC ()
{
    NSArray *_moneyAry;
    NSArray *_dateAry;
    GBTagListView *_moneyTag;
    GBTagListView *_dateTag;
    NSString *_moneyStr;
    NSString *_dateStr;
}
@end

@implementation LZChooseArrearClientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _moneyAry = @[@"金额从高到低",@"金额从低到高"];
    _dateAry = @[@"日期从远到近",@"日期从近到远"];
    _moneyStr = @"";
    _dateStr = @"";
    
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
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(10,120, APPWidth, 0)];
    /**允许点击 */
    tagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum=2;
    /**控制是否是单选模式 */
    tagList.isSingleSelect=YES;
    tagList.signalTagColor=[UIColor whiteColor];
    [tagList setTagWithTagArray:_moneyAry];
//    __weak __typeof(self)weakSelf = self;
    [tagList setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _moneyStr = arr[0];
        }

        [_moneyTag removeFromSuperview];

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
    
    GBTagListView *tagList1=[[GBTagListView alloc]initWithFrame:CGRectMake(10,210, APPWidth, 0)];
    /**允许点击 */
    tagList1.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList1.canTouchNum=2;
    /**控制是否是单选模式 */
    tagList1.isSingleSelect=YES;
    tagList1.signalTagColor=[UIColor whiteColor];
    [tagList1 setTagWithTagArray:_dateAry];
//    __weak __typeof(self)weakSelf = self;
    [tagList1 setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _dateAry = arr[0];
        }

        [_moneyTag removeFromSuperview];

    }];
    [self.view addSubview:tagList1];
    
//    //选择筛选
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

    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tagList1.mas_bottom).offset(10);
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
    if (self.setectBlock) {
        self.setectBlock(_moneyStr, _dateStr);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
