//
//  ManagerCostViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  管理费用(科目页面)

#import "ManagerCostViewController.h"
#import "ModifySubjectViewController.h"
#import "LZSearchBar.h"

@interface ManagerCostViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@end

@implementation ManagerCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    //    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    //    self.headView.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, APPHeight -self.searchBar.bottom -LLNavViewHeight -44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.text = @"管理费用";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"管理费用 = %@",cell.textLabel.text);
    
    ModifySubjectViewController *vc = [[ModifySubjectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
