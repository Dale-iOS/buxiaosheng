//
//  LZCollectionCheckVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  收款单详情（客户对账表）

#import "LZCollectionCheckVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "LZCollectionCheckModel.h"

@interface LZCollectionCheckVC ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///日期
@property (nonatomic, strong) UILabel *dateLbl;
///名称
@property (nonatomic, strong) TextInputCell *nameLblCell;
///收款金额
@property (nonatomic, strong) TextInputCell *priceLblCell;
///现欠款
@property (nonatomic, strong) TextInputCell *oweLblCell;
///收款账户
@property (nonatomic, strong) TextInputCell *accountLblCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
@property(nonatomic,strong)LZCollectionCheckModel *model;

@end

@implementation LZCollectionCheckVC
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"收款单详情"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.datasource = [NSMutableArray array];
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    //    [self setSectionTwo];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setSectionOne
{
    //日期
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 35)];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    self.dateLbl = [[UILabel alloc]init];
    self.dateLbl.textColor = CD_Text99;
    self.dateLbl.font = FONT(12);
    [whiteView addSubview:self.dateLbl];
    self.dateLbl.sd_layout
    .leftSpaceToView(whiteView, 15)
    .centerYEqualToView(whiteView)
    .widthIs(150)
    .heightIs(13);
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [whiteView addSubview:lineView];
    lineView.sd_layout
    .leftSpaceToView(whiteView, 0)
    .bottomSpaceToView(whiteView, 0)
    .widthIs(APPWidth)
    .heightIs(1);
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //名称
    self.nameLblCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.nameLblCell.lineView.hidden = YES;
    self.nameLblCell.titleLabel.text = @"名称";
    self.nameLblCell.userInteractionEnabled = NO;
    
    //收款金额
    self.priceLblCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.priceLblCell.lineView.hidden = YES;
    self.priceLblCell.titleLabel.text = @"收款金额";
    self.priceLblCell.userInteractionEnabled = NO;
    
    //现欠款
    self.oweLblCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.oweLblCell.lineView.hidden = YES;
    self.oweLblCell.titleLabel.text = @"现欠款";
    self.oweLblCell.userInteractionEnabled = NO;
    self.oweLblCell.contentTF.textColor = LZAppRedColor;
    
    //收款账户
    self.accountLblCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.accountLblCell.lineView.hidden = YES;
    self.accountLblCell.titleLabel.text = @"收款账户";
    self.accountLblCell.userInteractionEnabled = NO;
    
    //备注
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.userInteractionEnabled = NO;
    self.remarkTextView.lineView.hidden = YES;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[whiteView,self.nameLblCell,self.priceLblCell,self.oweLblCell,self.accountLblCell,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

#pragma mark --- 网络请求 ---
//接口名称 收款单详情
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderNo":self.orderNo
                             };
    [BXSHttp requestGETWithAppURL:@"finance_data/coustomer_receipt.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZCollectionCheckModel LLMJParse:baseModel.data];
        //赋值
        self.dateLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
        self.nameLblCell.contentTF.text = _model.customerName;
        self.priceLblCell.contentTF.text = _model.amount;
        self.oweLblCell.contentTF.text = _model.arrears;
        self.accountLblCell.contentTF.text = _model.bankName;
        self.remarkTextView.textView.text = _model.remark;
        [self.mainTabelView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
