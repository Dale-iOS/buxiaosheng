//
//  LZChooseProductsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseProductsVC.h"
#import "LZSearchBar.h"


@interface LZChooseProductsVC ()<UITableViewDelegate, UITableViewDataSource ,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSArray <LZProductDetailModel *> *lists;
@end

@implementation LZChooseProductsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupProductsLists];
}

- (void)setupUI{
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight -30, APPWidth *0.75, 40)];
    self.searchBar.placeholder = @"输入品名搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom).offset(10);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
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
    static NSString *cellID = @"uitableviewcellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    LZProductDetailModel *model = _lists[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中的产品
    LZProductDetailModel *model = _lists[indexPath.row];
    if (self.selectVCBlock) {
        self.selectVCBlock(model);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 网络请求 ---
//接口名称 功能用到产品列表
- (void)setupProductsLists{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        _lists = [LZProductDetailModel LLMJParse:baseModel.data];
        [_tableView reloadData]; 
    } failure:^(NSError *error) {
        
    }];
}

//搜索框搜索代理
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"searchName":searchText
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.lists = [LZProductDetailModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
