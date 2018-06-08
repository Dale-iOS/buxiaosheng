//
//  IncomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  收款单页面

#import "IncomeViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "ArrearsNameTextInputCell.h"
#import "UIView+LLXAlertPop.h"

@interface IncomeViewController ()<LZHTableViewDelegate>
{
    UILabel *lab;
}
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
///客户收款单VC
@property (nonatomic, strong) UIViewController *peymentVC;
///调整金额VC
@property (nonatomic, strong) UIViewController *moneyVC;

///收款金额
@property (nonatomic, strong) TextInputCell *collectionCell;
///现欠款
@property (nonatomic, strong) TextInputCell *arrearsCell;
///收款账户
@property (nonatomic, strong) TextInputCell *accountCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///名称
@property (nonatomic, strong) ArrearsNameTextInputCell *titileCell;
///灰色背景条1
@property (nonatomic, strong) UIView *headerView1;
///灰色背景条2
@property (nonatomic, strong) UIView *headerView2;
///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;



@end

@implementation IncomeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
  
}


- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64+40, APPWidth, APPHeight)];
//        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"收款单"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    
    UISegmentedControl *sgc = [[UISegmentedControl alloc]initWithItems:@[@"客户收款单",@"调整金额"]];
    sgc.selectedSegmentIndex = 0;
    sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:sgc];
    
    sgc.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight - 44, APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.saveBtn];
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, APPWidth, 20)];
    lab.textColor = [UIColor redColor];
    lab.textAlignment = 1;
    [self.view addSubview:lab];
    
    
}

- (void)setSectionOne
{
    self.headerView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    self.headerView1.backgroundColor = LZHBackgroundColor;
    
    self.headerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    self.headerView2.backgroundColor = LZHBackgroundColor;
    
//    名称
    self.titileCell = [[ArrearsNameTextInputCell alloc]init];
    self.titileCell.frame = CGRectMake(0, 0, APPWidth, 75);
    
//    收款金额
    self.collectionCell = [[TextInputCell alloc]init];
    self.collectionCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
//    现欠款
    self.arrearsCell = [[TextInputCell alloc]init];
    self.arrearsCell.contentTF.textColor = [UIColor redColor];
    self.arrearsCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
//    收款账户
    self.accountCell = [[TextInputCell alloc]init];
    self.accountCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
//    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    
    self.titileCell.titleLabel.text = @"名称";
    self.titileCell.beforeLabel.text = @"前欠款:￥2500";
    self.titileCell.contentTF.text = @"李先生";
    self.collectionCell.titleLabel.text = @"收款金额";
    self.collectionCell.contentTF.text = @"￥500";
    self.arrearsCell.titleLabel.text = @"现欠款";
    self.arrearsCell.contentTF.text = @"￥2000";
    self.accountCell.titleLabel.text = @"收款账户";
    self.accountCell.contentTF.text = @"男装现金";
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.accountCell,self.headerView2,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = self.headerView1;
    [self.datasource addObject:item];
}

- (void)segClick:(UISegmentedControl *)sgc
{
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.canSelected = NO;
    item.sectionView = self.headerView1;
    
    if (sgc.selectedSegmentIndex == 0) {

//        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
        item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.headerView2,self.remarkTextView];
        [self.datasource replaceObjectAtIndex:0 withObject:item];
        [self.mainTabelView reloadData];
        
    }else if (sgc.selectedSegmentIndex == 1)
    {
//        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
        item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,self.accountCell,self.headerView2,self.remarkTextView];
        [self.datasource replaceObjectAtIndex:0 withObject:item];
        [self.mainTabelView reloadData];
    }
    
}


#pragma mark ----- 点击按钮 -------
- (void)saveBtnOnClickAction
{
    NSLog(@"点击了保存");
    
    NSArray *arrayTitle = @[@"民生银行",@"农业银行"];
    
    NSArray *arrayImage = @[@"back",@"homesetup"];
    
    
    [self.view createAlertViewTitleArray:arrayTitle arrayImage:arrayImage textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16] spacing:-15 actionBlock:^(UIButton * _Nullable button, NSInteger didRow) {
        //获取点击事件
        NSLog(@"%@,%ld",button.currentTitle,(long)didRow);
        lab.text = [NSString stringWithFormat:@"%@,下标%ld",button.currentTitle,(long)didRow];
    }];

}



- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
