//
//  CustomerReconciliationViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户对账

#import "CustomerReconciliationViewController.h"
#import "CustomerReconciliationTableViewCell.h"
#import "ReconciliationDetailViewController.h"

@interface CustomerReconciliationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeadView;
@property (nonatomic, strong) UILabel *companyLbl;
///最后还款
@property (nonatomic, strong) UILabel *lastpayDateLbl;
///累计欠款
@property (nonatomic ,strong) UILabel *totalborrowLbl;

@end

@implementation CustomerReconciliationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    [self setupTableviewHeadView];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户欠款表"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableViewHeadView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //隐藏分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self setupBottomView];
}

- (void)setupTableviewHeadView
{
    //tableview顶部试图
    self.tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 39)];
    self.tableViewHeadView.backgroundColor = [UIColor whiteColor];
    
    //公司
    self.companyLbl = [[UILabel alloc]init];
    self.companyLbl.text = @"蔡怕啥.灵类似经公司";
    self.companyLbl.textColor = CD_Text99;
    self.companyLbl.font = FONT(14);
    [self.tableViewHeadView addSubview:self.companyLbl];
    
    //导出
    UILabel *outLbl = [[UILabel alloc]init];
    outLbl.text = @"导出";
    outLbl.textAlignment = NSTextAlignmentRight;
    outLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    [self.tableViewHeadView addSubview:outLbl];
    
    //导出按钮
    UIButton *outBtn = [[UIButton alloc]init];
    [outBtn setImage:IMAGE(@"export") forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(outBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [outBtn setBackgroundColor:[UIColor clearColor]];
    [self.tableViewHeadView addSubview:outBtn];
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.tableViewHeadView addSubview:lineView];
    
    self.companyLbl.sd_layout
    .leftSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(APPWidth/3)
    .heightIs(15);
    
    outBtn.sd_layout
    .rightSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(16)
    .heightIs(16);
    
    outLbl.sd_layout
    .rightSpaceToView(outBtn, 10)
    .centerYEqualToView(self.tableViewHeadView)
    .heightIs(15)
    .widthIs(50);
    
    lineView.sd_layout
    .bottomSpaceToView(self.tableViewHeadView, -1)
    .heightIs(1)
    .widthIs(APPWidth)
    .leftSpaceToView(self.tableViewHeadView, 0);
    
}


- (void)setupBottomView
{
    //最后还款
    self.lastpayDateLbl = [[UILabel alloc]init];
    self.lastpayDateLbl.backgroundColor = [UIColor whiteColor];
    self.lastpayDateLbl.textAlignment = NSTextAlignmentCenter;
    self.lastpayDateLbl.font = FONT(12);
    self.lastpayDateLbl.textColor = CD_Text99;
    self.lastpayDateLbl.text = @"最后还款：2018-3-30";
    [self.view addSubview:self.lastpayDateLbl];
    self.lastpayDateLbl.sd_layout
    .leftSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(APPWidth/2)
    .heightIs(44);
    
    //累计欠款
    self.totalborrowLbl = [[UILabel alloc]init];
    self.totalborrowLbl.backgroundColor = [UIColor whiteColor];
    self.totalborrowLbl.textAlignment = NSTextAlignmentCenter;
    self.totalborrowLbl.font = FONT(12);
    self.totalborrowLbl.textColor = CD_Text99;
    self.totalborrowLbl.text = @"累计欠款：454541.00";
    [self.view addSubview:self.totalborrowLbl];
    self.totalborrowLbl.sd_layout
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .widthIs(APPWidth/2)
    .heightIs(44);
    
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"CustomerReconciliationTableViewCell";
    
    CustomerReconciliationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[CustomerReconciliationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReconciliationDetailViewController *vc = [[ReconciliationDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ------- 点击事件 ---------
- (void)outBtnOnClick
{
    NSLog(@"outBtnOnClick");
}

- (void)toScreenClick
{
    NSLog(@"toScreenClick");
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
