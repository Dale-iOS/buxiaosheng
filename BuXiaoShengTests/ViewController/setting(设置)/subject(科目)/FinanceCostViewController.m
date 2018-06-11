//
//  FinanceCostViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  财务费用（科目页面）

#import "FinanceCostViewController.h"
#import "ModifySubjectViewController.h"
#import "LZSearchBar.h"
#import "LZSubjectModel.h"

@interface FinanceCostViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSArray <LZSubjectModel *> * subjects;
@end

@implementation FinanceCostViewController

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
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, APPHeight -self.searchBar.bottom -LLNavViewHeight -44) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)setupData
{
    NSDictionary *param = @{
                            @"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"20",
                            @"searchName":self.searchBar.text,
                            @"type":@"2"
                            };
    [BXSHttp requestGETWithAppURL:@"costsubject/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.subjects = [LZSubjectModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subjects.count;
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
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.subjects[indexPath.row].name;
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZSubjectModel *model = [LZSubjectModel LLMJParse:self.subjects[indexPath.row]];
    //执行回调block
    if (self.didClickBlock) {
        self.didClickBlock(model);
    }

    ModifySubjectViewController *vc = [[ModifySubjectViewController alloc]init];
    vc.id = self.subjects[indexPath.row].id;
    if (!_isFromSpend) {
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


#pragma mark ----- searchBarDelegate --------
- (void)searchBarSearchButtonClicked:(LZSearchBar *)searchBar
{
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
