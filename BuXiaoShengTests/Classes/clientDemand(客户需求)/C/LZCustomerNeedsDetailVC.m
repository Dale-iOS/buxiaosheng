//
//  LZCustomerNeedsDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZCustomerNeedsDetailVC.h"
#import "NeedTotalCell.h"
#import "NeedCustomerCell.h"
#import "NeedColorsCell.h"
#import "LZCustomerNeedsDetailModel.h"

@interface LZCustomerNeedsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) LZCustomerNeedsDetailModel *customerNeedModel;

@end

@implementation LZCustomerNeedsDetailVC
- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _myTableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"仓库出库详情"];
    [self.view addSubview:self.myTableView];
    _dataArray = [NSMutableArray array];
    self.myTableView.estimatedRowHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self setupData];
    
}


#pragma mark ---- 网络请求 ----
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#
- (void)setupData{
    //    已出库订单详情（客户信息）
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_customer_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
        self.customerNeedModel = [LZCustomerNeedsDetailModel LLMJParse:baseModel.data];
        NSLog(@"123");
        [self setupProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#
- (void)setupProductData{
    //    已出库订单详情（产品信息）
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"sale/already_product_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
       
        self.dataArray = [LZCustomerNeedsDetailProductModel LLMJParse:baseModel.data];
       
        [self.myTableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2+_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NeedCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeedCustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NeedCustomerCell" owner:self options:nil] lastObject];
            
        }
        cell.dataModel = self.customerNeedModel;
        return cell;
    }else if (indexPath.row == _dataArray.count + 1) {
        NeedTotalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeedTotalCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NeedTotalCell" owner:self options:nil] lastObject];
            
        }
        cell.dataArray = _dataArray;
        return cell;
    }
    else
    {
        NeedColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NeedColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NeedColorsCell" owner:self options:nil] lastObject];
            
        }
        if (self.dataArray.count > 0) {
            cell.productModel = self.dataArray[indexPath.row - 1];
        }
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
