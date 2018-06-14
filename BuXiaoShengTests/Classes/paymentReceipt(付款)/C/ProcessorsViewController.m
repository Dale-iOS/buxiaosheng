//
//  ProcessorsViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  加工商付款单（付款单）

#import "ProcessorsViewController.h"
#import "LZHTableView.h"
#import "ArrearsNameTextInputCell.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZPaymentOrderModel.h"
#import "UITextField+PopOver.h"
#import "LZPickerView.h"

@interface ProcessorsViewController ()<LZHTableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///供货商
@property (nonatomic, strong) ArrearsNameTextInputCell *titleCell;
///付款金额
@property (nonatomic, strong) TextInputCell *priceCell;
///联系人信息
@property (nonatomic, strong) TextInputCell *contactCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;
//产商数组
@property(nonatomic,strong)NSMutableArray *companyList;
@property(nonatomic,strong)NSMutableArray *companyNameAry;
@property(nonatomic,strong)NSMutableArray *companyIdAry;
@property (nonatomic, copy) NSString *companyId;///选择中的客户id
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选择中的付款方式id
@end

@implementation ProcessorsViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupCompanyList];
    [self setupPayList];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    //供货商
    self.titleCell = [[ArrearsNameTextInputCell alloc]init];
    self.titleCell.frame = CGRectMake(0, 0, APPWidth, 75);
    self.titleCell.titleLabel.text = @"加工商";
    self.titleCell.beforeLabel.text = @"前欠款:￥0";
    self.titleCell.contentTF.placeholder = @"请输入供货商";
    self.titleCell.contentTF.scrollView = self.view;
    self.titleCell.contentTF.positionType = ZJPositionBottomTwo;
    
    //付款金额
    self.priceCell = [[TextInputCell alloc]init];
    self.priceCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.priceCell.titleLabel.text = @"付款金额";
    self.priceCell.contentTF.placeholder = @"请输入金额";
    
    //联系人信息
    self.contactCell = [[TextInputCell alloc]init];
    self.contactCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.contactCell.titleLabel.text = @"付款方式";
    self.contactCell.contentTF.placeholder = @"请选择付款方式";
    self.contactCell.contentTF.enabled = NO;
    UITapGestureRecognizer *contactCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contactCellTapClick)];
    [self.contactCell addGestureRecognizer:contactCellTap];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.priceCell,self.contactCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight -64-44-44 , APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.saveBtn];
}

#pragma mark ---- 网络请求 ----
//接口名称 功能用到厂商列表
- (void)setupCompanyList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"type":@"2"
                             };
    [BXSHttp requestGETWithAppURL:@"factory/search_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _companyList = baseModel.data;
        _companyNameAry = [NSMutableArray array];
        _companyIdAry = [NSMutableArray array];
        for (int i = 0 ; i <_companyList.count; i++) {
            [_companyNameAry addObject:_companyList[i][@"name"]];
            [_companyIdAry addObject:_companyList[i][@"id"]];
        }
        //        名称cell设置数据源 获取产商id
        WEAKSELF
        [self.titleCell.contentTF popOverSource:_companyNameAry index:^(NSInteger index) {
            //设置名称 前欠款
            NSString *str = _companyList[index][@"arrear"];
            weakSelf.titleCell.beforeLabel.text = [NSString stringWithFormat:@"前欠款:￥%@",str];
            _companyId = _companyList[index][@"id"];
        }];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
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
        self.payNameAry = [NSMutableArray array];
        self.payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [self.payIdAry addObject:tempAry[i][@"id"]];
            [self.payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ------ 点击事件 ------
//    接口名称 添加付款单
- (void)saveBtnOnClickAction
{
    
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入并选择供货商");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.priceCell.contentTF.text]||[self.priceCell.contentTF.text isEqualToString:@"2"]) {
        BXS_Alert(@"请输入有效金额");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.contactCell.contentTF.text]) {
        BXS_Alert(@"请选择付款方式");
        return;
    }
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"amount":self.priceCell.contentTF.text,
                             @"bankId":self.payIdStr,
                             @"factoryId":_companyId,
                             @"remark":self.remarkTextView.textView.text,
                             @"type":@"2"
                             };
    [BXSHttp requestGETWithAppURL:@"finance/payment_add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [LLHudTools showWithMessage:@"提交成功"];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)contactCellTapClick{
    if (self.payNameAry.count < 1) {
        [LLHudTools showWithMessage:@"您暂无收款方式可选"];
        return;
    }
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.payNameAry titleDataArray:nil];
    pickerView.toolsView.frame = CGRectMake(0, APPHeight - 244 -60, APPWidth, 44);
    pickerView.picerView.frame = CGRectMake(0, APPHeight - 220 -45, APPWidth, 200);
    
    WEAKSELF
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        weakSelf.contactCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
        weakSelf.payIdStr = self.payIdAry[row];
        
    };
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
