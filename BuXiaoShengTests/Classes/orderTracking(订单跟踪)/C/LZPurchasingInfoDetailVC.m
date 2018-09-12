//
//  LZPurchasingInfoDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  订单详情（来自采购信息列表）

#import "LZPurchasingInfoDetailVC.h"
#import "LZPurchasingInfoDetailModel.h"
#import "PurchaseDetailCell.h"
#import "LogistiscCell.h"
#import "LogEndCell.h"
#import "LogStartCell.h"


@interface LZPurchasingInfoDetailVC ()<UITableViewDelegate,UITableViewDataSource,WMRefreshCellDelegate>
@property (nonatomic, strong) LZPurchasingInfoDetailModel *detailModel;
@property (nonatomic, strong) LZPurchasingInfoDetaiLogisticslModel *logisticsModel;

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *infoDataArray;
@property (nonatomic, strong) NSMutableArray *logisticsDataArray;

@end

@implementation LZPurchasingInfoDetailVC

- (UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    app.h = 0.0;
    [self setupUI];
}

- (void)setupUI{
    app.isSelected = YES;
    self.navigationItem.titleView = [Utility navTitleView:@"订单详情"];
    [self.view addSubview:self.myTableView];
    _infoDataArray = [NSMutableArray array];
    _logisticsDataArray = [NSMutableArray array];
    self.myTableView.estimatedRowHeight = 200;
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self getProductDetail];
    
}

#pragma mark ---- 网络请求 ----
//接口名称 采购信息产品详情
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#305
- (void)getProductDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.buyId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/procurement_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _infoDataArray = [LZPurchasingInfoDetailModel LLMJParse:baseModel.data];
        _detailModel = _infoDataArray.firstObject;
        
        [self getProductLogistics];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 采购信息物流详情
//http://www.buxiaosheng.com:8083/workspace/myWorkspace.do?projectId=2#306
- (void)getProductLogistics{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.buyId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/procurement_logistics_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _logisticsDataArray = [LZPurchasingInfoDetaiLogisticslModel LLMJParse:baseModel.data];
        
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _infoDataArray.count;
    }else
    {
        NSInteger row = 1;
        if (![_detailModel.successTime isEqualToString:@"0"]) {
            row = row + 1;
        }
        return row + _logisticsDataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PurchaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseDetailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PurchaseDetailCell" owner:self options:nil] lastObject];
            
        }
        
        cell.indexPath = indexPath;
        cell.delegate = self;
        cell.detailModel = _infoDataArray[indexPath.row];
        return cell;
    }else
    {
        if (![_detailModel.successTime isEqualToString:@"0"]) {
            if (indexPath.row == 0) {
                LogStartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogStartCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LogStartCell" owner:self options:nil] lastObject];
                    
                }
                cell.detailModel = self.detailModel;
                return cell;
            }else if(indexPath.row == (1+_logisticsDataArray.count))
            {
                LogEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogEndCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LogEndCell" owner:self options:nil] lastObject];
                    
                }
                return cell;
            }else
            {
                LogistiscCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogistiscCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LogistiscCell" owner:self options:nil] lastObject];
                    
                }
                cell.logisticslModel = self.logisticsDataArray[indexPath.row-1];
                return cell;
            }
            
        }else
        {
            if(indexPath.row == (_logisticsDataArray.count))
            {
                LogEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogEndCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LogEndCell" owner:self options:nil] lastObject];
                    
                }
                return cell;
            }else
            {
                LogistiscCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogistiscCell"];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"LogistiscCell" owner:self options:nil] lastObject];
                    
                }
                cell.logisticslModel = self.logisticsDataArray[indexPath.row];;
                return cell;
            }
        }
        
        
    }
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 8)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    v.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return v;
}


#pragma mark -- 刷新cell
- (void)refreshCell:(NSIndexPath *)indexPath
{
    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    app.h = 0.0;
}

@end
