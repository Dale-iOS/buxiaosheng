//
//  StockTrackingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  备货跟踪页面

#import "StockTrackingViewController.h"
#import "StockTrackingCell.h"

@interface StockTrackingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation StockTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"备货跟踪"];
    
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
    static NSString *cellID = @"StockTrackingCell";
    StockTrackingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[StockTrackingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
//        cell.delegate = self;
//        cell.stateLabel.hidden = YES;
//        [cell.yesBtn setTitle:@"出库" forState:UIControlStateNormal];
//        [cell.noBtn setTitle:@"指派" forState:UIControlStateNormal];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
