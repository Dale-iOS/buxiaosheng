//
//  LZPaymentOrderListDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPaymentOrderListDetailVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZClientReceiptDetailModel.h"

@interface LZPaymentOrderListDetailVC ()<LZHTableViewDelegate>
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

@implementation LZPaymentOrderListDetailVC
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
    
    self.navigationItem.titleView = [Utility navTitleView:@"付款单详情"];
    
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
//    _dateLbl.text = @"12313213";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    lineView.backgroundColor = LZHBackgroundColor;
    
    
    //名称
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.nameCell.lineView.hidden = YES;
    self.nameCell.titleLabel.text = @"供货商：";
    self.nameCell.userInteractionEnabled = NO;
    self.nameCell.contentTF.sd_layout
    .topEqualToView(self.nameCell.titleLabel)
    .leftSpaceToView(self.nameCell.titleLabel, -10)
    .heightRatioToView(self.nameCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    //    收款金额
    self.collectionCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.collectionCell.titleLabel.text = @"付款金额：";
    self.collectionCell.lineView.hidden = YES;
    self.collectionCell.contentTF.textColor = LZAppRedColor;
    self.collectionCell.userInteractionEnabled = NO;
    self.collectionCell.contentTF.sd_layout
    .topEqualToView(self.collectionCell.titleLabel)
    .leftSpaceToView(self.collectionCell.titleLabel, -10)
    .heightRatioToView(self.collectionCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    //    现欠款
    self.arrearsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.arrearsCell.titleLabel.text = @"付款方式：";
    self.arrearsCell.userInteractionEnabled = NO;
    self.arrearsCell.lineView.hidden = YES;
    self.arrearsCell.contentTF.sd_layout
    .topEqualToView(self.arrearsCell.titleLabel)
    .leftSpaceToView(self.arrearsCell.titleLabel, -10)
    .heightRatioToView(self.arrearsCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
//    //    收款账户
//    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
//    self.accountCell.titleLabel.text = @"收款账户";
//    self.accountCell.contentTF.enabled = NO;
//    self.accountCell.lineView.hidden = YES;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注：";
    self.remarkTextView.lineView.hidden = YES;
    self.remarkTextView.userInteractionEnabled = NO;
    self.remarkTextView.textView.sd_layout
    .leftSpaceToView(self.remarkTextView, 100)
    .topSpaceToView(self.remarkTextView, 7)
    .widthIs(APPWidth -120 -15)
    .heightIs(60);
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headview.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_dateLbl,lineView,self.nameCell,self.collectionCell,self.arrearsCell,self.remarkTextView];
    item.sectionView = headview;
    item.canSelected = NO;
    [self.dataSource addObject:item];
}

- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"finance/payment_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZClientReceiptDetailModel LLMJParse:baseModel.data];
        
        //详情赋值
        _dateLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
        if ([_model.type integerValue] == 0) {
            self.nameCell.titleLabel.text = @"供货商：";
        }else if ([_model.type integerValue] == 1){
            self.nameCell.titleLabel.text = @"生产商：";
        }else if ([_model.type integerValue] == 2){
            self.nameCell.titleLabel.text = @"加工商：";
        }
        self.nameCell.contentTF.text = _model.factoryName;
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
