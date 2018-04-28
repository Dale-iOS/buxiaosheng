//
//  ClientNeedsViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ClientNeedsViewController.h"
#import "AuditTableViewCell.h"
#import "OutboundViewController.h"

@interface ClientNeedsViewController ()<UITableViewDelegate,UITableViewDataSource,AuditTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ClientNeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户需求"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(ToSearch) image:IMAGE(@"search")];
    
    [self setupUI];
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AuditTableViewCell";
    AuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AuditTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.delegate = self;
        cell.stateLabel.hidden = YES;
        [cell.yesBtn setTitle:@"出库" forState:UIControlStateNormal];
        [cell.noBtn setTitle:@"指派" forState:UIControlStateNormal];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OutboundViewController *vc = [[OutboundViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -------- AuditTableViewCellDelegate -------
- (void)didClickYesBtnInCell:(UITableViewCell *)cell
{
    NSLog(@"点击了YES");
}

- (void)didClickNoBtnInCell:(UITableViewCell *)cell
{
    NSLog(@"点击了NO");
}


#pragma mark ------ 点击事件 -------
- (void)ToSearch
{
    NSLog(@"点击了search");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
