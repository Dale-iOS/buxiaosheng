//
//  LZSearchVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  搜索页面

#import "LZSearchVC.h"

@interface LZSearchVC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (nonatomic, strong) NSMutableArray <LLSalesColorListModel *> *color_list;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation LZSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar = [UISearchBar
                      new];
    [self.view addSubview:self.searchBar];
    self.searchBar.delegate =self;
    self.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    self.searchBar.placeholder= @"请输入您要搜索的颜色";
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-5);
        make.height.mas_equalTo(35);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom).offset(12);
    }];
    
    [self setupProductColorData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark ------ 网络请求 ------

- (void)setupProductColorData
{
    NSDictionary * param = nil;
    if (!self.searchBar.text) {
        param = @{@"companyId":[BXSUser currentUser].companyId,
                  @"productId":self.productId
                  };
    }else {
        param = @{@"companyId":[BXSUser currentUser].companyId,
                  @"productId":self.productId,
                  @"searchName":self.searchBar.text.length == 0 ? @"" :self.searchBar.text
                  };
    }
    
    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.color_list = [LLSalesColorListModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.color_list.count;
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
     cell.textLabel.text = [self.color_list objectAtIndex:indexPath.row].name;
     cell.textLabel.textColor = [UIColor darkGrayColor];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.SearchVCBlock) {
        self.SearchVCBlock(self.color_list[indexPath.row]);
    }
    [self dismissViewControllerAnimated:true completion:nil];
}



#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     [self setupProductColorData];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
     [self setupProductColorData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
