//
//  SetBranchViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  分店设置

#import "SetBranchViewController.h"
#import "AlterBranchViewController.h"
#import "SetBranchCell.h"

@interface SetBranchViewController ()<UITableViewDelegate,UITableViewDataSource,SetBranchCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SetBranchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"分店设置"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
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
    return 279;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"SetBranchCellid";
    SetBranchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[SetBranchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
//        cell.textLabel.text = @"大龙纺";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
 
}

- (void)didClickAlterBtnInCell:(UITableViewCell *)cell
{
    AlterBranchViewController *vc = [[AlterBranchViewController alloc]init];
    vc.isFormBranchAdd = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navigationAddClick
{
    AlterBranchViewController *vc = [[AlterBranchViewController alloc]init];
    vc.isFormBranchAdd = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
