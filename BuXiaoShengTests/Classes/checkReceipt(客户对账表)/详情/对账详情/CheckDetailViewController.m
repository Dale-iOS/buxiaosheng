//
//  CheckDetailViewController.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//  客户对账详情页面

#import "CheckDetailViewController.h"
#import "CustomerCell.h"
#import "ColorsCell.h"
#import "Tools.h"
#import "LZCollectionCheckDetailMsgModel.h"
#import "LZCollectionCheckDetailProductModel.h"

@interface CheckDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_orderDetailId;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LZCollectionCheckDetailMsgModel *msgModel;
@property (nonatomic, strong) LZCollectionCheckDetailProductModel *productModel;

@end

@implementation CheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:self.title];
    _dataArray = [NSMutableArray array];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight = 200;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    //请求
    [self getMsgData];
}

#pragma mark ----- 网络请求 -----
//接口名称 销售单详情
//接口文档：http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#428
//18814188198   666666
- (void)getMsgData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.msgModel = [LZCollectionCheckDetailMsgModel LLMJParse:baseModel.data];
        _orderDetailId = self.msgModel.orderDetailId;
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 销售单产品列表
//接口文档：http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#427
//18814188198   666666
- (void)getProductData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderDetailId":_orderDetailId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/order_product.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.dataArray = [LZCollectionCheckDetailProductModel LLMJParse:baseModel.data];
        
        [self.tableview reloadData];
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
    return 1 + _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerCell" owner:self options:nil] lastObject];
            
        }
        cell.msgModel = self.msgModel;
        return cell;
    }
    else
    {
        ColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ColorsCell" owner:self options:nil] lastObject];

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

@end
