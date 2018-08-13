//
//  CheckDetailViewController.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//  退单详情页面

#import "ReimDetailViewController.h"
#import "ReimCustomerCell.h"
#import "ReimColorsCell.h"
#import "ReimSubCell.h"
#import "LZBackOrderDetialModel.h"
#import "LZBackOrderDetialProductModel.h"

@interface ReimDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) LZBackOrderDetialModel *msgModel;
@property (nonatomic, strong) LZBackOrderDetialProductModel *productModel;
@end

@implementation ReimDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"退单详情"];
    _dataArray = [NSMutableArray array];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.estimatedRowHeight = 200;
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    [self getMsgData];
}

#pragma mark ----- 网络请求 -----
//接口名称 退货单详情
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
        [self getProductData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 退货单产品列表
- (void)getProductData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"refundyId":self.msgModel.refundyId
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/refundy_product.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.dataArray = [LZBackOrderDetialProductModel LLMJParse:baseModel.data];
        
        __block NSInteger totalNum = 0;
        __block NSInteger totalLine = 0;
        __block NSInteger totalMoney = 0;
        [self.dataArray enumerateObjectsUsingBlock:^(LZBackOrderDetialProductModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            totalNum += [obj.houseNum integerValue];
            totalLine += [obj.total integerValue];
            totalMoney += [obj.refundAmount integerValue];
        }];
        self.msgModel.totalNum = [NSString stringWithFormat:@"%ld",totalNum];
        self.msgModel.totalLine = [NSString stringWithFormat:@"%ld",totalLine];
        self.msgModel.tatalMoney = [NSString stringWithFormat:@"%ld",totalMoney];
        
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
    return 2 + _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //客户资料
        ReimCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimCustomerCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimCustomerCell" owner:self options:nil] lastObject];
            
        }
        cell.msgModel = self.msgModel;
        return cell;
    }else if (indexPath.row == self.dataArray.count+1){
//        最下方的总计
        ReimSubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimSubCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimSubCell" owner:self options:nil] lastObject];
            
        }
        cell.model = self.msgModel;
        
        return cell;
        
    }
    else
    {
//        产品内容
        ReimColorsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReimColorsCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ReimColorsCell" owner:self options:nil] lastObject];

        }
        if (self.dataArray.count >0) {
//            这里也是不知道要减几
            cell.productModel = self.dataArray[indexPath.row -1];
//            NSLog(@"123");
        }
        
        return cell;
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
