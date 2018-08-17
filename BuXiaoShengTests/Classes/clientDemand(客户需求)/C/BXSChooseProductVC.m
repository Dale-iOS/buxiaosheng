//
//  BXSChooseProductVC.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSChooseProductVC.h"
#import "salesDemandModel.h"
@interface BXSChooseProductVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BXSChooseProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"选择产品"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(clickTrue) title:@"确定"];
    
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    self.mainTable.sd_resetLayout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.rowHeight = 50.f;
    //cell
    [self.mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell cellID]];
    
}

- (void)loadData {
    
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.dataSource = [productListModel LLMJParse:baseModel.data];
        [self.mainTable reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark ---- Click
- (void)clickTrue {
    
}

#pragma mark ---- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell cellID]];
    productListModel *model = self.dataSource[indexPath.row];
    cell.textLabel.textColor = Text33;
    cell.textLabel.font = FONT(15);
    cell.textLabel.text = model.name;
    return cell;
}


#pragma mark ---- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    !_selectProduct?:_selectProduct(self.dataSource[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
