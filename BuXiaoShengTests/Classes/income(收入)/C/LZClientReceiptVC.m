//
//  LZClientReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户收款单列表

#import "LZClientReceiptVC.h"
#import "LZClientReceiptModel.h"
#import "LZClientReceiptCell.h"
#import "LZClientReceiptDetailVC.h"

@interface LZClientReceiptVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray <LZClientReceiptModel *> *list;

@end

@implementation LZClientReceiptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupListData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"客户收款单列表"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationRightClick) image:IMAGE(@"screen1")];

    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];

}

#pragma mark ----- 网络请求 -----
- (void)setupListData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15"
                             };
    [BXSHttp requestGETWithAppURL:@"finance/receipt_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _list = [LZClientReceiptModel LLMJParse:baseModel.data];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}



#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZClientReceiptCellid";
    LZClientReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZClientReceiptCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _list[indexPath.row];
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //获取cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    LZClientReceiptModel *model = _list[indexPath.row];
    LZClientReceiptDetailVC *vc = [[LZClientReceiptDetailVC alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)navigationRightClick{
    
}

@end
