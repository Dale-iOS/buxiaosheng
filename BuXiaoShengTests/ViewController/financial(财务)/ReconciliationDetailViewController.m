//
//  ReconciliationDetailViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  客户对账单详情

#import "ReconciliationDetailViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"

@interface ReconciliationDetailViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///日期
@property (nonatomic, strong) UILabel *dateLbl;
///单据来源
@property (nonatomic, strong) TextInputCell *sourceCell;
///单号
@property (nonatomic, strong) TextInputCell *orderNumCell;
///品名
@property (nonatomic, strong) TextInputCell *nameCell;
///数量
@property (nonatomic, strong) TextInputCell *numCell;
///结算单位
@property (nonatomic, strong) TextInputCell *unitCell;
///单价
@property (nonatomic, strong) TextInputCell *unitPriceCell;
///应收账款
@property (nonatomic, strong) TextInputCell *shouldCollectCell;
///金额
@property (nonatomic, strong) TextInputCell *priceCell;
///已收账款
@property (nonatomic, strong) TextInputCell *didCollectCell;
///累计欠款
@property (nonatomic, strong) TextInputCell *totailArrearsCell;
///摘要
@property (nonatomic, strong) TextInputTextView *summaryTextView;

@end

@implementation ReconciliationDetailViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    
    self.navigationItem.titleView = [Utility navTitleView:@"客户对账表详情"];
    //    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
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
//    self.dateLbl.text = @"2018-3-30";
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
    
    
    //单据来源
    self.sourceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.sourceCell.lineView.hidden = YES;
    self.sourceCell.titleLabel.text = @"单据来源";
//    self.sourceCell.contentTF.text = @"客户收据单";
    self.sourceCell.userInteractionEnabled = NO;
    
    //单号
    self.orderNumCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.orderNumCell.lineView.hidden = YES;
    self.orderNumCell.titleLabel.text = @"单号";
//    self.orderNumCell.contentTF.text = @"fasdnja";
    self.orderNumCell.userInteractionEnabled = NO;
    
    //品名
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.nameCell.lineView.hidden = YES;
    self.nameCell.titleLabel.text = @"品名";
//    self.nameCell.contentTF.text = @"缕空皮章仔";
    self.nameCell.userInteractionEnabled = NO;
    
    //数量
    self.numCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.numCell.lineView.hidden = YES;
    self.numCell.titleLabel.text = @"数量";
//    self.numCell.contentTF.text = @"45461";
    self.numCell.userInteractionEnabled = NO;
    
    //单价
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.unitCell.lineView.hidden = YES;
    self.unitCell.titleLabel.text = @"结算单位";
//    self.unitCell.contentTF.text = @"片";
    self.unitCell.userInteractionEnabled = NO;
    
    //单价
    self.unitPriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.unitPriceCell.lineView.hidden = YES;
    self.unitPriceCell.titleLabel.text = @"单价";
//    self.unitPriceCell.contentTF.text = @"15";
    self.unitPriceCell.userInteractionEnabled = NO;
    

    //应收账款
    self.shouldCollectCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.shouldCollectCell.lineView.hidden = YES;
    self.shouldCollectCell.titleLabel.text = @"应收账款";
//    self.shouldCollectCell.contentTF.text = @"56000.00";
    self.shouldCollectCell.contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    self.shouldCollectCell.userInteractionEnabled = NO;
    
    //金额
    self.priceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.priceCell.lineView.hidden = YES;
    self.priceCell.titleLabel.text = @"金额";
//    self.priceCell.contentTF.text = @"450.00";
    self.priceCell.contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    self.priceCell.userInteractionEnabled = NO;
    
    //已收账款
    self.didCollectCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.didCollectCell.lineView.hidden = YES;
    self.didCollectCell.titleLabel.text = @"已收账款";
//    self.didCollectCell.contentTF.text = @"23000.00";
    self.didCollectCell.contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    self.didCollectCell.userInteractionEnabled = NO;
    
    //累计欠款
    self.totailArrearsCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 32)];
    self.totailArrearsCell.lineView.hidden = YES;
    self.totailArrearsCell.titleLabel.text = @"已收账款";
//    self.totailArrearsCell.contentTF.text = @"23000.00";
    self.totailArrearsCell.contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    self.totailArrearsCell.userInteractionEnabled = NO;
    
    //摘要
    self.summaryTextView = [[TextInputTextView alloc]init];
    self.summaryTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.summaryTextView.titleLabel.text = @"摘要";
//    self.summaryTextView.textView.placeholder = @"请输入摘要内容";
    self.summaryTextView.userInteractionEnabled = NO;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
//    item.sectionRows = @[whiteView,self.sourceCell,self.orderNumCell,self.nameCell,self.unitCell];
    item.sectionRows = @[whiteView,self.sourceCell,self.orderNumCell,self.nameCell,self.numCell,self.unitCell,self.unitPriceCell,self.shouldCollectCell,self.priceCell,self.didCollectCell,self.totailArrearsCell,self.summaryTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
