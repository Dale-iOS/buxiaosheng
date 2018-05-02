//
//  CashBankViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  现金银行页面

#import "CashBankViewController.h"
#import "CashBankTableViewCell.h"
#import "AddBankViewController.h"

@interface CashBankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation CashBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"现金银行"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //隐藏分割线
    self.tableView.separatorStyle = NO;

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
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CashBankTableViewCell";
    CashBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[CashBankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    return cell;
}

- (void)navigationAddClick
{
    NSLog(@"点击了添加");
    
    AddBankViewController *vc = [[AddBankViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
