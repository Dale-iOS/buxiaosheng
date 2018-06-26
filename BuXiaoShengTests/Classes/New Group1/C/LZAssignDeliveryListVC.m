//
//  LZAssignDeliveryListVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZAssignDeliveryListVC.h"

@interface LZAssignDeliveryListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *dateLbl;
@end

@implementation LZAssignDeliveryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"指派送货列表"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) image:IMAGE(@"screenDate")];
    
    //设置tableview顶部试图
    _headView = [[UIView alloc]initWithFrame:CGRectZero];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(LLNavViewHeight);
        make.height.mas_offset(34);
    }];
    
    _dateLbl = [[UILabel alloc]init];
    _dateLbl.font = FONT(13);
    _dateLbl.textColor = CD_Text99;
    _dateLbl.text = @"   全部";
    [_headView addSubview:_dateLbl];
    [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView).offset(15);
        make.right.equalTo(_headView).offset(-15);
        make.height.mas_offset(14);
        make.centerY.equalTo(_headView);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [_headView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_headView);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(_headView).offset(-0.5);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);
    }];
}

#pragma mark ---- tableviewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"AssignDeliveryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
//    cell.model = _lists[indexPath.row];
    return cell;
}

#pragma mark --- 点击事件 ---
- (void)selectornavRightBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
