//
//  LZAuditDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  审批详情页面

#import "LZAuditDetailVC.h"
#import "LZHTableView.h"
#import "LZAuditDetailHeaderCell.h"
#import "LZAuditDetailInfoView.h"
#import "LZAuditDetailModel.h"

@interface LZAuditDetailVC ()<LZHTableViewDelegate>
@property (nonatomic, weak) LZHTableView *myTabelView;
@property (nonatomic, strong) NSMutableArray *datasourse;
@property (nonatomic, strong) LZAuditDetailHeaderCell *headerView;
@property (nonatomic, strong) LZAuditDetailInfoView *infoView;
@end

@implementation LZAuditDetailVC
@synthesize myTabelView,headerView,infoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self requestData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"审批详情"];
    
    [self.view addSubview:self.myTabelView];
    self.datasourse = [NSMutableArray array];
    self.myTabelView.delegate = self;
    [self setupSectionOne];
    self.myTabelView.dataSoure = self.datasourse;
}

#pragma mark ---- lzhTabelView ----
- (LZHTableView *)myTabelView{
    if (myTabelView == nil) {
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.tableView.allowsSelection = YES;
        [tableView setIsScrollEnable:NO];
        [self.view addSubview:(myTabelView = tableView)];
    }
    return myTabelView;
}

- (LZAuditDetailHeaderCell *)headerView{
    if (headerView == nil) {
        LZAuditDetailHeaderCell *temp = [[LZAuditDetailHeaderCell alloc]init];
        headerView = temp;
    }
    return headerView;
}

- (LZAuditDetailInfoView *)infoView{
    if (infoView == nil) {
        LZAuditDetailInfoView *temp = [[LZAuditDetailInfoView alloc]init];
        infoView = temp;
    }
    return infoView;
}

- (void)setupSectionOne{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.headerView,self.infoView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasourse addObject:item];
}

#pragma mark ---- 网络请求 ----
- (void)requestData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"finance/expend_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        LZAuditDetailModel *model = [LZAuditDetailModel LLMJParse:baseModel.data];
        self.headerView.model = model;
        self.infoView.model = model;
        [self.myTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
