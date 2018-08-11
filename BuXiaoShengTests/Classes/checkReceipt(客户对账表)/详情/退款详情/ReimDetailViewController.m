//
//  CheckDetailViewController.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimDetailViewController.h"
#import "ReimCustomerCell.h"
#import "ReimColorsCell.h"
#import "ReimSubCell.h"
#import "LZBackOrderDetialModel.h"
#import "LZBackOrderDetialProductModel.h"

@interface ReimDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_orderDetailId;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LZBackOrderDetialModel *msgModel;
@property (nonatomic, strong) LZBackOrderDetialProductModel *productModel;
@end

@implementation ReimDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight = 200;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    
}

#pragma mark ----- 网络请求 -----
//接口名称 退货单详情
//接口文档：http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#430
//18814188198  666666
- (void)getMsgData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/refundy_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.msgModel = [LZBackOrderDetialModel LLMJParse:baseModel.data];
        _orderDetailId = self.msgModel.orderNo;
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 退货单产品列表
//接口文档：http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#431
//18814188198  666666
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
        self.productModel = [LZBackOrderDetialProductModel LLMJParse:baseModel.data];
        NSLog(@"123");
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
    return 5 + _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ReimCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimCustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimCustomerCell" owner:self options:nil] lastObject];
            
        }
        return cell;
    }else if (indexPath.row == 4){
        
        ReimSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimSubCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimSubCell" owner:self options:nil] lastObject];
            
        }
        cell.backgroundColor = [UIColor yellowColor];
        return cell;
        
    }
    else
    {
        ReimColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimColorsCell" owner:self options:nil] lastObject];

        }
        [cell loadContactData];
        return cell;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
