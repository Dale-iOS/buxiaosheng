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
#import "BRPickerView.h"
#import "NSDate+BRPickerView.h"
#import "LZSubjectModel.h"

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
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;


///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;
@property(nonatomic,strong)NSMutableArray *approverList;
@property(nonatomic,strong)NSMutableArray *approverNameAry;
@property(nonatomic,strong)NSMutableArray *approverIdAry;
@property(nonatomic,copy)NSString *approverId;
@property(nonatomic,copy)NSString *dateStr;
@property(nonatomic,copy)LZSubjectModel *didCostModel;
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
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}


- (void)setupUI
{
    
    self.navigationItem.titleView = [Utility navTitleView:@"日常支出登记"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toList) image:IMAGE(@"new_lists")];
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
    self.overheadCell.contentTF.placeholder = @"请选择开销类型";
    self.collectionCell.titleLabel.text = @"支出金额";
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
    self.timeCell.contentTF.enabled = NO;
    UITapGestureRecognizer *timeCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeCellTapClick)];
    [self.timeCell addGestureRecognizer:timeCellTap];
    
    self.auditCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.auditCell.rightArrowImageVIew.hidden = NO;
    self.auditCell.contentTF.enabled = NO;
    UITapGestureRecognizer *auditCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(auditCellTapClick)];
    [self.auditCell addGestureRecognizer:auditCellTap];
    
    self.timeCell.titleLabel.text = @"做账时间";
    self.timeCell.contentTF.placeholder = @"请选择时间";
    self.auditCell.titleLabel.text = @"审批人";
    self.auditCell.contentTF.placeholder = @"请选择审批人";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.timeCell,self.auditCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionThree
{
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
//    headView.backgroundColor = LZHBackgroundColor;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
//    item.sectionView = headView;
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
//    if ([BXSTools stringIsNullOrEmpty:self.overheadCell.contentTF.text]) {
//        BXS_Alert(@"请选择开销类型");
//        return;
//    }
    if ([BXSTools stringIsNullOrEmpty:self.collectionCell.contentTF.text]) {
        BXS_Alert(@"请输入金额");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.timeCell.contentTF.text]) {
        BXS_Alert(@"请选择时间");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.auditCell.contentTF.text]) {
        BXS_Alert(@"请选择审批人");
        return;
    }

    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"approverId":_approverId,
                             @"costsubjectId":_didCostModel.id,
                             @"remark":self.remarkTextView.textView.text,
                             @"tallyTime":_dateStr,
                             @"amount":self.collectionCell.contentTF.text
                             };
    [BXSHttp requestGETWithAppURL:@"finance/expend_add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [LLHudTools showWithMessage:@"提交成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}
- (void)toList
{
    [self.navigationController pushViewController:[[LZSpendingListVC alloc]init] animated:YES];
}

//开销类型点击事件
- (void)overheadCellTapClick{
    //    强制当前输入法收起
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    SubjectViewController *vc = [[SubjectViewController alloc]init];
    vc.isFromSpend = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc setDidClickBlock:^(LZSubjectModel *blockModel) {
        _didCostModel = blockModel;
        self.overheadCell.contentTF.text = _didCostModel.name;
    }];
}

//选择做账时间
- (void)timeCellTapClick{
    //    强制当前输入法收起
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
    //            NSDate *maxDate = [NSDate date];
    NSDate *maxDate = [NSDate br_setYear:2050 month:1 day:1];
    [BRDatePickerView showDatePickerWithTitle:@"选择做账时间" dateType:BRDatePickerModeYMD defaultSelValue:self.timeCell.contentTF.text minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        self.timeCell.contentTF.text =  selectValue;
        
        _dateStr = [selectValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

//选择审批人
- (void)auditCellTapClick{
    
    //    强制当前输入法收起
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
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
