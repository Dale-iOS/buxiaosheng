//
//  AuditViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  审批页面

#import "AuditViewController.h"
#import "AuditTableViewCell.h"

@interface AuditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;

@end

@implementation AuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    
    self.navigationItem.titleView = [Utility navTitleView:@"审批"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0+40+64, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.SegmentedBgView];
    
    
    UISegmentedControl *sgc = [[UISegmentedControl alloc]initWithItems:@[@"未审批",@"已审批"]];
    sgc.selectedSegmentIndex = 0;
    sgc.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [sgc addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:sgc];
    
    sgc.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
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
    }
    return cell;
}

- (void)segClick:(UISegmentedControl *)sgc
{
    if (sgc.selectedSegmentIndex == 0) {

        NSLog(@"segClick1111");
    }else if (sgc.selectedSegmentIndex == 1)
    {
        NSLog(@"segClick2222");
    }
    
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
