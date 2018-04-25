//
//  BankDetailListViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细页面

#import "BankDetailListViewController.h"
#import "BankDetailListTableViewCell.h"
#import "DocumentBankDetailViewController.h"

@interface BankDetailListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *tableViewHeadView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *headDateLbl;

@end

@implementation BankDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    //tableview顶部试图
    self.tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.tableViewHeadView.backgroundColor = [UIColor whiteColor];
    
    //本月
    UILabel *monthLabel = [[UILabel alloc]init];
    monthLabel.text = @"本月";
    monthLabel.textColor = CD_Text33;
    monthLabel.font = FONT(14);
    [self.tableViewHeadView addSubview:monthLabel];
    
    //日期
    self.headDateLbl = [[UILabel alloc]init];
    self.headDateLbl.text = @"2018-4-11";
    self.headDateLbl.textAlignment = NSTextAlignmentRight;
    self.headDateLbl.textColor = CD_Text66;
    [self.tableViewHeadView addSubview:self.headDateLbl];
    
    UIButton *dateBtn = [[UIButton alloc]init];
    [dateBtn setImage:IMAGE(@"bankdate") forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(dateBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [dateBtn setBackgroundColor:[UIColor clearColor]];
    [self.tableViewHeadView addSubview:dateBtn];
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.tableViewHeadView addSubview:lineView];
    
    monthLabel.sd_layout
    .leftSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(40)
    .heightIs(15);
    
    dateBtn.sd_layout
    .rightSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(16)
    .heightIs(16);
    
    self.headDateLbl.sd_layout
    .rightSpaceToView(dateBtn, 10)
    .centerYEqualToView(self.tableViewHeadView)
    .heightIs(15)
    .widthIs(200);
    
    lineView.sd_layout
    .bottomSpaceToView(self.tableViewHeadView, -1)
    .heightIs(1)
    .widthIs(APPWidth)
    .leftSpaceToView(self.tableViewHeadView, 0);
    
    self.navigationItem.titleView = [Utility navTitleView:@"银行明细"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = LZHBackgroundColor;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10 +64, APPWidth, APPHeight -64-10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableViewHeadView;
    self.tableView.backgroundColor = [UIColor clearColor];
    //隐藏分割线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    static NSString *cellid = @"BankDetailListTableViewCell";
    
    BankDetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[BankDetailListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocumentBankDetailViewController *vc = [[DocumentBankDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dateBtnOnClick
{
    NSLog(@"点击了dateBtnOnClick");
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
