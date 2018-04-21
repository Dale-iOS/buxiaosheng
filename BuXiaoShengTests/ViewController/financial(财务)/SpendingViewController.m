//
//  SpendingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SpendingViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"

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

@end

@implementation SpendingViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
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
    
}

- (void)setSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    self.overheadCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.overheadCell.rightArrowImageVIew.hidden = NO;
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

- (void)toList
{
    NSLog(@"点击了列表图标");
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
