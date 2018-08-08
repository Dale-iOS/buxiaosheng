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
@property (nonatomic, strong) UIView *recallView;
@property (nonatomic, strong) LZAuditDetailModel *model;
@end

@implementation LZAuditDetailVC
@synthesize myTabelView,headerView,infoView,recallView;

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

- (UIView *)recallView{
    if (recallView == nil) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, APPWidth, 60);
        UIButton *btn = [UIButton new];
        [btn setTitle:@"撤回" forState:UIControlStateNormal];
//        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setBackgroundImage:IMAGE(@"recallBottom") forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(15);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(recallBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(150);
            make.height.mas_offset(44);
            make.center.mas_equalTo(view);
        }];
        recallView = view;
    }
    return recallView;
}

- (void)setupSectionOne{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    lineView.backgroundColor = LZHBackgroundColor;
    
    self.headerView.frame = CGRectMake(0, 0, APPWidth, 75);
    
    self.infoView.frame = CGRectMake(0, 0, APPWidth, 210);
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.headerView,lineView,self.infoView];
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
        _model = [LZAuditDetailModel LLMJParse:baseModel.data];
        self.headerView.model = _model;
        self.infoView.model = _model;
        if ([_model.status integerValue] == 0) {
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
            headerView.backgroundColor = LZHBackgroundColor;
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
            lineView.backgroundColor = LZHBackgroundColor;
            
            self.headerView.frame = CGRectMake(0, 0, APPWidth, 75);
            
            self.infoView.frame = CGRectMake(0, 0, APPWidth, 210);
            
            LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
            item.sectionRows = @[self.headerView,lineView,self.infoView,self.recallView];
            item.canSelected = YES;
            item.sectionView = headerView;
            [self.datasourse replaceObjectAtIndex:0 withObject:item];
        }
        [self.myTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (void)recallBtnAction{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":_model.id
                             };
    [BXSHttp requestGETWithAppURL:@"finance/revoke_expend.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
