//
//  DocumentBankDetailViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细详情页面

#import "DocumentBankDetailViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"

@interface DocumentBankDetailViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;

@property (strong, nonatomic) NSMutableArray *datasource;
///日期
@property (nonatomic, strong) UILabel *dateLabel;
///开单人
@property (nonatomic, strong) TextInputCell *workManCell;
///开单分点
@property (nonatomic, strong) TextInputCell *storeCell;
///单据来源
@property (nonatomic, strong) TextInputCell *sourceCell;
///收入
@property (nonatomic, strong) TextInputCell *incomeCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;

@end

@implementation DocumentBankDetailViewController
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
    self.navigationItem.titleView = [Utility navTitleView:@"银行明细详情"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = LZHBackgroundColor;
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setSectionOne
{
    //日期底图
    UIView *oneView = [[UIView alloc]init];
    oneView.backgroundColor = [UIColor whiteColor];
    oneView.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.font = FONT(12);
    self.dateLabel.textColor = CD_Text99;
    self.dateLabel.text = @"2018-3-30";
    [oneView addSubview:self.dateLabel];
    
    self.dateLabel.sd_layout
    .leftSpaceToView(oneView, 15)
    .centerYEqualToView(oneView)
    .widthIs(200)
    .heightIs(13);
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [oneView addSubview:lineView];
    lineView.sd_layout
    .bottomSpaceToView(oneView, 1)
    .widthIs(APPWidth)
    .heightIs(0.5)
    .leftSpaceToView(oneView, 0);
    
    //开单人
    self.workManCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.workManCell.titleLabel.text = @"开单人";
    self.workManCell.contentTF.text = @"冯伟";
    
    //开单分点
    self.storeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.storeCell.titleLabel.text = @"开单分点";
    self.storeCell.contentTF.text = @"海珠分店";
    
    //单据来源
    self.sourceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.sourceCell.titleLabel.text = @"单据来源";
    self.sourceCell.contentTF.text = @"销售单";
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[oneView,self.workManCell,self.storeCell,self.sourceCell];
    item.sectionView = headView;
    item.canSelected = NO;
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo
{
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
//    lineView.backgroundColor = LZHBackgroundColor;
//    
    self.incomeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.incomeCell.titleLabel.text = @"收入";
    self.incomeCell.contentTF.text = @"1682.00";
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.incomeCell,self.remarkTextView];
//    item.sectionView = lineView;
    item.canSelected = NO;
    [self.datasource addObject:item];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
