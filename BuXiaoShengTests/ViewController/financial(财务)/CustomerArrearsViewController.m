//
//  CustomerArrearsViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户欠款表页面

#import "CustomerArrearsViewController.h"
#import "CustomerArrearsTableViewCell.h"

@interface CustomerArrearsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@end

@implementation CustomerArrearsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"客户欠款表"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toScreenClick) image:IMAGE(@"screen1")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupHeadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.bottom, APPWidth, APPHeight -64-10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    //隐藏分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

//设置顶部
- (void)setupHeadView
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, 49)];
    self.headView.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:self.headView];
    
    //客户名称
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"客户名称";
    titleLbl.textColor = CD_Text33;
    titleLbl.font = FONT(14);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:titleLbl];
    
    //应收借欠
    UILabel *borrowLbl = [[UILabel alloc]init];
    borrowLbl.text = @"应收借欠";
    borrowLbl.textColor = CD_Text33;
    borrowLbl.font = FONT(14);
    borrowLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:borrowLbl];
    
    //最后还款日期
    UILabel *payDateLbl = [[UILabel alloc]init];
    payDateLbl.text = @"最后还款日期 ";
    payDateLbl.textColor = CD_Text33;
    payDateLbl.font = FONT(14);
    payDateLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:payDateLbl];
    
    //业务员
    UILabel *workerLbl = [[UILabel alloc]init];
    workerLbl.text = @"业务员";
    workerLbl.textColor = CD_Text33;
    workerLbl.font = FONT(14);
    workerLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:workerLbl];
    
    titleLbl.sd_layout
    .leftSpaceToView(self.headView, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    borrowLbl.sd_layout
    .leftSpaceToView(titleLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    payDateLbl.sd_layout
    .leftSpaceToView(borrowLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    workerLbl.sd_layout
    .leftSpaceToView(payDateLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
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
    static NSString *cellid = @"CustomerArrearsTableViewCell";
    
    CustomerArrearsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[CustomerArrearsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
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
