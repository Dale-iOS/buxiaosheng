//
//  LZSearchVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  搜索页面

#import "LZSearchVC.h"
#import "salesDemandModel.h"
@interface LZSearchVC ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray <productListModel *> *products;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LZSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:self.titleStr];
    
    // 创建UISearchController, 这里使用当前控制器来展示结果
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    search.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = NO;
    // 是否自动隐藏导航
    //    search.hidesNavigationBarDuringPresentation = NO;
    self.searchController = search;
    // 将searchBar赋值给tableView的tableHeaderView
    self.tableView.tableHeaderView = search.searchBar;
    
    search.searchBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (_searchType) {
        case searchProduct:
            [self setupProductData];
            break;
        case searchProductColor:
            [self setupProductColorData];
            break;
        default:
            break;
    }
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _datas;
}

- (NSMutableArray *)results {
    if (_results == nil) {
        _results = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _results;
}
#pragma mark ------ 网络请求 ------
- (void)setupProductData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        _products = [productListModel LLMJParse:baseModel.data];
        
        if (_products) {
            for (int i = 0; i <_products.count; i++) {
                productListModel *model = [productListModel LLMJParse:_products[i]];
                [_datas addObject:model.name];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupProductColorData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"productId":@"13"
                             };
    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        _products = [productListModel LLMJParse:baseModel.data];
        
        if (_products) {
            for (int i = 0; i <_products.count; i++) {
                productListModel *model = [productListModel LLMJParse:_products[i]];
                [_datas addObject:model.name];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        
        return self.results.count ;
        
    }
    
    return self.datas.count;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active ) {
        
        cell.textLabel.text = [self.results objectAtIndex:indexPath.row];
    } else {
        
        cell.textLabel.text = [self.datas objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.searchController.active) {
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
        if (self.TitleBtnBlock) {
            self.TitleBtnBlock(self.results[indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
        if (self.TitleBtnBlock) {
            self.TitleBtnBlock(self.datas[indexPath.row]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            [self.results addObject:str];
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
