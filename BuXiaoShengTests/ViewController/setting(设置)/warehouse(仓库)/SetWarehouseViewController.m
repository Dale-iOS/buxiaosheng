//
//  SetWarehouseViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/29.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  仓库页面

#import "SetWarehouseViewController.h"
#import "LLFactoryModel.h"
#import "AlterWarehouseViewController.h"

@interface SetWarehouseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <LLFactoryModel *> * warehouseModel;

@end

@implementation SetWarehouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"仓库"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellId"];
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:_tableView];
}

#pragma mark ------ 网络请求 --------
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestPOSTWithAppURL:@"house/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.warehouseModel = [LLFactoryModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.warehouseModel.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UITableViewCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.warehouseModel[indexPath.row].name;
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
//
    AlterWarehouseViewController *vc = [[AlterWarehouseViewController alloc]init];
    vc.isFormWarehouseAdd = false;
    vc.id = self.warehouseModel[indexPath.row].id;
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)navigationAddClick
{
    AlterWarehouseViewController *vc = [[AlterWarehouseViewController alloc]init];
    vc.isFormWarehouseAdd = true;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
