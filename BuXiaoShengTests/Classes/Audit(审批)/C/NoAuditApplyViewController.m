//
//  NoAuditApplyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  报销单（未审批）

#import "NoAuditApplyViewController.h"
#import "LZReimbursementCell.h"
#import "LZReimbursementModel.h"
#import "LZPickerView.h"

static NSInteger const pageSize = 15;
@interface NoAuditApplyViewController ()<UITableViewDelegate,UITableViewDataSource,LZReimbursementCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <LZReimbursementModel *> *lists;
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选择中的付款方式id
@property (nonatomic, copy) NSString *customerId;///选择中的客户id
@property (nonatomic,assign) NSInteger pageIndex;//页数
@end

@implementation NoAuditApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupPayList];
    [self setupList];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self setupPayList];
//    [self setupListData];
//}

- (void)setupUI
{
    self.pageIndex = 1;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -LLNavViewHeight-88) style:UITableViewStylePlain];
    self.tableView .backgroundColor = LZHBackgroundColor;
    self.tableView .delegate = self;
    self.tableView .dataSource = self;
    //隐藏分割线
    self.tableView .separatorStyle = NO;
    [self.view addSubview:self.tableView];
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf setupList];
    }];
}

- (MJRefreshFooter *)reloadMoreData {
    WEAKSELF;
    MJRefreshFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex +=1;
        [weakSelf setupList];
    }];
    return footer;
}

#pragma mark ------- 网络请求 --------
//接口名称 银行列表
- (void)setupPayList{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        self.payNameAry = [NSMutableArray array];
        self.payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [self.payIdAry addObject:tempAry[i][@"id"]];
            [self.payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 销售单审批列表
- (void)setupList
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@(self.pageIndex),
                            @"pageSize":@(pageSize),
                            @"status":@"0"
                            };
    [BXSHttp requestGETWithAppURL:@"approval/expend_list.do" param:param success:^(id response) {
        
        if ([response isKindOfClass:[NSDictionary class]] && [response objectForKey:@"data"]) {
            if (1 == self.pageIndex) {
                [self.lists removeAllObjects];
            }
            
            NSArray *itemList = [response objectForKey:@"data"];
            if (itemList && itemList.count > 0) {
                for (NSDictionary *dic in itemList) {
                    LZReimbursementModel *model = [LZReimbursementModel mj_objectWithKeyValues:dic];
                    [self.lists addObject:model];
                }
                if (self.lists.count % pageSize) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [self.tableView.mj_footer endRefreshing];
                }
            } else {
                //                [LLHudTools showWithMessage:@"暂无更多数据"];
            }
            if (self.pageIndex == 1) {
                if (self.lists.count >= pageSize) {
                    self.tableView.mj_footer = [self reloadMoreData];
                } else {
                    self.tableView.mj_footer = nil;
                }
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } else {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZReimbursementCellId";
    LZReimbursementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[LZReimbursementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)didClickYesBtnInCell:(UITableViewCell *)cell{
    
    if (self.payNameAry.count < 1) {
        [LLHudTools showWithMessage:@"您暂无收款方式可选"];
        return;
    }
    WEAKSELF;
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.payNameAry titleDataArray:nil];
    pickerView.toolsView.frame = CGRectMake(0, APPHeight - 244 -180, APPWidth, 44);
    pickerView.picerView.frame = CGRectMake(0, APPHeight - 220 -165, APPWidth, 200);
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        

        //设置警告框
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定同意该审批？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            NSLog(@"取消执行");
            
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    NSInteger row = [titileString integerValue];
            _payIdStr = weakSelf.payIdAry[row];
            
            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
            LZReimbursementModel *model = _lists[indexPath.row];
            
            NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                     @"bankId":_payIdStr,
                                     @"approvalId":model.id,
                                     @"expendId":model.expendId
                                     };
            [BXSHttp requestGETWithAppURL:@"approval/expend_agree.do" param:param success:^(id response) {
                LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
                if ([baseModel.code integerValue] != 200) {
                    [LLHudTools showWithMessage:baseModel.msg];
                    return ;
                }
                [LLHudTools showWithMessage:@"提交成功"];
                [weakSelf setupList];
            } failure:^(NSError *error) {
                BXS_Alert(LLLoadErrorMessage);
            }];
     
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    };
    
    [self.view addSubview:pickerView];

}

- (void)didClickNoBtnInCell:(UITableViewCell *)cell{
    WEAKSELF;
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定拒绝该审批？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消执行");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        LZReimbursementModel *model = _lists[indexPath.row];
        
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"approvalId":model.id,
                                 @"expendId":model.expendId
                                 };
        [BXSHttp requestGETWithAppURL:@"approval/expend_refuse.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"提交成功"];
            [weakSelf setupList];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
        
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Getter && Setter
- (NSMutableArray<LZReimbursementModel *> *)lists {
    if (_lists == nil) {
        _lists = @[].mutableCopy;
    }
    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
