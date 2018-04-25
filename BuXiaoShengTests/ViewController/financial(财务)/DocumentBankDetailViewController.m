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
    self.navigationItem.titleView = [Utility navTitleView:@"银行明细"];
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
    .bottomSpaceToView(oneView, -1)
    .widthIs(APPWidth)
    .heightIs(0.5)
    .leftSpaceToView(oneView, 0);
    
    
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[oneView];
    item.sectionView = headView;
    item.canSelected = NO;
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo
{
    
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
