//
//  LZClientReceiptDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  详情页面

#import "LZClientReceiptDetailVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZClientReceiptDetailModel.h"

@interface LZClientReceiptDetailVC ()<LZHTableViewDelegate>
@property(nonatomic,weak)LZHTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
///日期
@property(nonatomic,strong)UILabel *dateLbl;
///名称
@property(nonatomic,strong)TextInputCell *nameCell;
///收款金额
@property(nonatomic,strong)TextInputCell *collectionCell;
///现欠款
@property(nonatomic,strong)TextInputCell *arrearsCell;
///收款账户
@property(nonatomic,strong)TextInputCell *accountCell;
///备注
@property(nonatomic,strong)TextInputTextView *remarkTextView;
@property(nonatomic,strong)LZClientReceiptDetailModel *model;
@end

@implementation LZClientReceiptDetailVC
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}

- (LZHTableView *)myTableView
{
    if (myTableView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        [self.view addSubview:(myTableView = tableView)];
        
    }
    return myTableView;
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"详情"];
    
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.myTableView];
    [self setSectionOne];
    self.myTableView.dataSoure = self.dataSource;
}

- (void)setSectionOne{
    
    _dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APPWidth -15*2, 34)];
    _dateLbl.backgroundColor = [UIColor whiteColor];
    _dateLbl.textColor = CD_Text99;
    _dateLbl.font = FONT(12);
    _dateLbl.text = @"12313213";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    lineView.backgroundColor = LZHBackgroundColor;
    
    
    //名称
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.nameCell.lineView.hidden = YES;
    self.nameCell.titleLabel.text = @"名称";
    self.nameCell.userInteractionEnabled = NO;
    
    //    收款金额
    self.collectionCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.collectionCell.titleLabel.text = @"收款金额";
    self.collectionCell.lineView.hidden = YES;
    self.collectionCell.userInteractionEnabled = NO;
    
    //    现欠款
    self.arrearsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.arrearsCell.contentTF.textColor = [UIColor redColor];
    self.arrearsCell.titleLabel.text = @"现欠款";
    self.arrearsCell.userInteractionEnabled = NO;
    self.arrearsCell.lineView.hidden = YES;
    
    //    收款账户
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.accountCell.titleLabel.text = @"收款账户";
    self.accountCell.contentTF.enabled = NO;
    self.accountCell.lineView.hidden = YES;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.lineView.hidden = YES;
    self.remarkTextView.userInteractionEnabled = NO;
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headview.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_dateLbl,lineView,self.nameCell,self.collectionCell,self.arrearsCell,self.accountCell,self.remarkTextView];
    item.sectionView = headview;
    item.canSelected = NO;
    [self.dataSource addObject:item];
}

- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"finance/receipt_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZClientReceiptDetailModel LLMJParse:baseModel.data];
        
        //详情赋值
        _dateLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
        self.nameCell.contentTF.text = _model.customerName;
        self.collectionCell.contentTF.text = _model.amount;
        self.arrearsCell.contentTF.text = _model.bankName;
        self.remarkTextView.textView.text = _model.remark;
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
