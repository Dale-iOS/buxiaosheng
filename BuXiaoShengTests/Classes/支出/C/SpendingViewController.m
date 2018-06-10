//
//  SpendingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  日常支出登记页面

#import "SpendingViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "LZClientModel.h"
#import "LZPickerView.h"
#import "SubjectViewController.h"
#import "LZSpendingListVC.h"

@interface SpendingViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///开销类型
@property (nonatomic, strong) TextInputCell *overheadCell;
///收款金额
@property (nonatomic, strong) TextInputCell *collectionCell;
///时间
@property (nonatomic, strong) TextInputCell *timeCell;
///审批人
@property (nonatomic, strong) TextInputCell *auditCell;
///支出方式
@property (nonatomic, strong) TextInputCell *spendingCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;


///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;
@property(nonatomic,strong)NSMutableArray *approverList;
@property(nonatomic,strong)NSMutableArray *approverNameAry;
@property(nonatomic,strong)NSMutableArray *approverIdAry;
@property(nonatomic,copy)NSString *approverId;
@end

@implementation SpendingViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupAuditmanList];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight)];
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}


- (void)setupUI
{
    
    self.navigationItem.titleView = [Utility navTitleView:@"日常支出登记"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toList) image:IMAGE(@"list")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight - 44, APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.saveBtn];
    
}

- (void)setSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    self.overheadCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.overheadCell.rightArrowImageVIew.hidden = NO;
    self.overheadCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(overheadCellTapClick)];
    [self.overheadCell addGestureRecognizer:tap];
    
    
    
    self.collectionCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    
    self.overheadCell.titleLabel.text = @"开销类型";
    self.overheadCell.contentTF.text = @"车费";
    self.collectionCell.titleLabel.text = @"收款金额";
    self.collectionCell.contentTF.placeholder = @"请输入金额";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.overheadCell,self.collectionCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    self.timeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.timeCell.rightArrowImageVIew.hidden = NO;
    
    self.auditCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.auditCell.rightArrowImageVIew.hidden = NO;
    self.auditCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.auditCell addGestureRecognizer:tap];
    
    self.spendingCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.spendingCell.rightArrowImageVIew.hidden = NO;
    
    self.timeCell.titleLabel.text = @"时间";
    self.timeCell.contentTF.text = @"2018-4-11";
    self.auditCell.titleLabel.text = @"审批人";
    self.auditCell.contentTF.placeholder = @"请选择";
    self.spendingCell.titleLabel.text = @"支出方式";
    self.spendingCell.contentTF.text = @"中国银行";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.timeCell,self.auditCell,self.spendingCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionThree
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

#pragma mark ----- 网络请求 -----
-(void)setupAuditmanList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"approver/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _approverList = baseModel.data;
        _approverNameAry = [NSMutableArray array];
        _approverIdAry = [NSMutableArray array];
        for (int i = 0; i <_approverList.count; i++) {
            [_approverIdAry addObject:_approverList[i][@"id"]];
            [_approverNameAry addObject:_approverList[i][@"memberName"]];
        }
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark -------- 点击事件 ----------
- (void)saveBtnOnClickAction
{
    NSLog(@"点击了 提交 按钮");
}
- (void)toList
{
    [self.navigationController pushViewController:[[LZSpendingListVC alloc]init] animated:YES];
}

//开销类型点击事件
- (void)overheadCellTapClick{
    SubjectViewController *vc = [[SubjectViewController alloc]init];
    vc.isFromExpendVC = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_approverNameAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        self.auditCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
        _approverId = _approverList[row][@"id"];
    };
    
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
