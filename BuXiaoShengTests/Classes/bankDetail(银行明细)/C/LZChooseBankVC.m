//
//  LZChooseBankVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细筛选侧栏

#import "LZChooseBankVC.h"
#import "GBTagListView.h"

@interface LZChooseBankVC ()
{
    NSString *_typeStr;
    NSArray *_typeAry;
//    GBTagListView*_typeTag;
    
    NSMutableArray *_payNameAry;//银行名称数组
    NSMutableArray *_payIdAry;//银行id数组
    NSString *_bankStr;
    
    NSString *_incomeStr;//收入
    NSArray *_incomeAry;
}
@end

@implementation LZChooseBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPayList];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化 类型
    _typeAry = @[@"预收款单",@"销售单",@"退货单",@"客户收款单",@"费用单",@"加工商付款单",@"供货商付款单",@"生产商付款单",@"采购入库结算",@"现金银行互转",@"其他收入"];
    _incomeAry = @[@"收入",@"支出"];

}

//设置标签
- (void)setupTagList{
    //选择筛选
    UILabel *chooseLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, APPWidth*0.75, 29)];
    chooseLbl.text = @"  选择筛选";
    chooseLbl.font = FONT(14);
    chooseLbl.textColor = CD_Text99;
    chooseLbl.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:chooseLbl];
    
    //选择筛选
    UILabel *moneyLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, chooseLbl.bottom +3, APPWidth*0.75, 29)];
    moneyLbl.text = @"  类型:";
    moneyLbl.font = FONT(12);
    moneyLbl.textColor = CD_Text66;
    moneyLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:moneyLbl];
    
    GBTagListView *typeTagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0,moneyLbl.bottom+5, APPWidth *0.75, 0)];
    /**允许点击 */
    typeTagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    typeTagList.canTouchNum=2;
    /**控制是否是单选模式 */
    typeTagList.isSingleSelect=YES;
    typeTagList.signalTagColor=[UIColor whiteColor];
    [typeTagList setTagWithTagArray:_typeAry];
    //    WEAKSELF;
    [typeTagList setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _typeStr = arr[0];
        }
        //        [_typeTag removeFromSuperview];
        //        GBTagListView*selectItems=[[GBTagListView alloc]initWithFrame:CGRectMake(0,tagList.frame.origin.y+tagList.frame.size.height+40 , APPWidth, 0)];
        //        selectItems.signalTagColor=[UIColor whiteColor];
        //        selectItems.canTouch=NO;
        //        [selectItems setMarginBetweenTagLabel:20 AndBottomMargin:20];
        //        [selectItems setTagWithTagArray:arr];
        //        [weakSelf.view addSubview:selectItems];
        //        _typeTag=selectItems;
        
    }];
    [self.view addSubview:typeTagList];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, typeTagList.bottom+5, APPWidth*0.75-10, 0.5)];
    line1.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line1];
    
    
    
    //初始化 银行
    //选择筛选
    UILabel *bankLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, line1.bottom +3, APPWidth*0.75, 29)];
    bankLbl.text = @"  银行:";
    bankLbl.font = FONT(12);
    bankLbl.textColor = CD_Text66;
    bankLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bankLbl];
    
    GBTagListView *bankTagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0,bankLbl.bottom+5, APPWidth *0.75, 0)];
    /**允许点击 */
    bankTagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    bankTagList.canTouchNum=2;
    /**控制是否是单选模式 */
    bankTagList.isSingleSelect=YES;
    bankTagList.signalTagColor=[UIColor whiteColor];
    [bankTagList setTagWithTagArray:_payNameAry];
    //    WEAKSELF;
    [bankTagList setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _bankStr = arr[0];
        }
        //        [_typeTag removeFromSuperview];
        //        GBTagListView*selectItems=[[GBTagListView alloc]initWithFrame:CGRectMake(0,tagList.frame.origin.y+tagList.frame.size.height+40 , APPWidth, 0)];
        //        selectItems.signalTagColor=[UIColor whiteColor];
        //        selectItems.canTouch=NO;
        //        [selectItems setMarginBetweenTagLabel:20 AndBottomMargin:20];
        //        [selectItems setTagWithTagArray:arr];
        //        [weakSelf.view addSubview:selectItems];
        //        _typeTag=selectItems;
        
    }];
    [self.view addSubview:bankTagList];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, bankTagList.bottom+5, APPWidth*0.75-10, 0.5)];
    line2.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line2];
    
    
    //初始化 收入
    UILabel *incomeLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, line2.bottom +3, APPWidth*0.75, 29)];
    incomeLbl.text = @"  收入:";
    incomeLbl.font = FONT(12);
    incomeLbl.textColor = CD_Text66;
    incomeLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:incomeLbl];
    
    GBTagListView *incomeTagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0,incomeLbl.bottom+5, APPWidth *0.75, 0)];
    /**允许点击 */
    incomeTagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    incomeTagList.canTouchNum=2;
    /**控制是否是单选模式 */
    incomeTagList.isSingleSelect=YES;
    incomeTagList.signalTagColor=[UIColor whiteColor];
    [incomeTagList setTagWithTagArray:_incomeAry];
    //    WEAKSELF;
    [incomeTagList setDidselectItemBlock:^(NSArray *arr) {
        if (arr.count >0) {
            _incomeStr = arr[0];
        }
        //        [_typeTag removeFromSuperview];
        //        GBTagListView*selectItems=[[GBTagListView alloc]initWithFrame:CGRectMake(0,tagList.frame.origin.y+tagList.frame.size.height+40 , APPWidth, 0)];
        //        selectItems.signalTagColor=[UIColor whiteColor];
        //        selectItems.canTouch=NO;
        //        [selectItems setMarginBetweenTagLabel:20 AndBottomMargin:20];
        //        [selectItems setTagWithTagArray:arr];
        //        [weakSelf.view addSubview:selectItems];
        //        _typeTag=selectItems;
        
    }];
    [self.view addSubview:incomeTagList];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(10, incomeTagList.bottom+5, APPWidth*0.75-10, 0.5)];
    line3.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:line3];
    
    
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

//接口名称 银行列表
- (void)setupPayList{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        _payNameAry = [NSMutableArray array];
        _payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [_payIdAry addObject:tempAry[i][@"id"]];
            [_payNameAry addObject:tempAry[i][@"name"]];
        }
        [self setupTagList];


    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)saveBtnClick{
//    if (self.selectBlock) {
//        self.selectBlock(_type);
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
