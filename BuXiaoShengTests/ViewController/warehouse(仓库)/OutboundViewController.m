//
//  OutboundViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  出库页面

#import "OutboundViewController.h"
#import "LZHTableView.h"

@interface OutboundViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

@end

@implementation OutboundViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"出库"];
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
//    [self setupSectionOne];
    [self setupSectionTwo];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
}

- (void)setupSectionOne
{
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 69)];
    remarkView.backgroundColor = [UIColor colorWithHexString:@"#ff7b7b"];
    
    UILabel *remarkTitleLbl = [[UILabel alloc]init];
    remarkTitleLbl.textColor = [UIColor whiteColor];
    remarkTitleLbl.font = FONT(12);
    remarkTitleLbl.text = @"告知仓库注意事项:";
    [remarkView addSubview:remarkTitleLbl];
    remarkTitleLbl.sd_layout
    .leftSpaceToView(remarkView, 15)
    .topSpaceToView(remarkView, 10)
    .widthIs(110)
    .heightIs(13);
    
    UILabel *remarkContentLbl = [[UILabel alloc]init];
    remarkContentLbl.textColor = [UIColor whiteColor];
    remarkContentLbl.font = FONT(12);
    remarkContentLbl.numberOfLines = 2;
    remarkContentLbl.text = @"告知仓库注意事项告知仓库注意事项告知仓库注意事项告知仓库注意事项告知仓库注意事项";
    [remarkView addSubview:remarkContentLbl];
    remarkContentLbl.sd_layout
    .leftSpaceToView(remarkView, 15)
    .topSpaceToView(remarkTitleLbl, 3)
    .widthIs(APPWidth -30)
    .heightIs(40);
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[remarkView];
    item.canSelected = NO;
    [self.datasource addObject:item];
}

- (void)setupSectionTwo
{
    
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 69)];
    remarkView.backgroundColor = [UIColor colorWithHexString:@"#ff7b7b"];
    
    UILabel *remarkTitleLbl = [[UILabel alloc]init];
    remarkTitleLbl.textColor = [UIColor whiteColor];
    remarkTitleLbl.font = FONT(12);
    remarkTitleLbl.text = @"告知仓库注意事项:";
    [remarkView addSubview:remarkTitleLbl];
    remarkTitleLbl.sd_layout
    .leftSpaceToView(remarkView, 15)
    .topSpaceToView(remarkView, 10)
    .widthIs(110)
    .heightIs(13);
    
    UILabel *remarkContentLbl = [[UILabel alloc]init];
    remarkContentLbl.textColor = [UIColor whiteColor];
    remarkContentLbl.font = FONT(12);
    remarkContentLbl.numberOfLines = 2;
    remarkContentLbl.text = @"告知仓库注意事项告知仓库注意事项告知仓库注意事项告知仓库注意事项告知仓库注意事项";
    [remarkView addSubview:remarkContentLbl];
    remarkContentLbl.sd_layout
    .leftSpaceToView(remarkView, 15)
    .topSpaceToView(remarkTitleLbl, 3)
    .widthIs(APPWidth -30)
    .heightIs(40);
    
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView1.backgroundColor = LZHBackgroundColor;
    
    UIView *orderNumView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    orderNumView.backgroundColor = [UIColor whiteColor];
    UILabel *orderNumLbl = [[UILabel alloc]init];
    orderNumLbl.font = FONT(13);
    orderNumLbl.textColor = CD_Text99;
    orderNumLbl.text = @"单号：354643484348";
    [orderNumView addSubview:orderNumLbl];
    orderNumLbl.sd_layout
    .leftSpaceToView(orderNumView, 15)
    .widthIs(APPWidth -30)
    .heightIs(14)
    .centerYEqualToView(orderNumView);
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView2.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionView = remarkView;
    item.sectionRows = @[lineView1,orderNumView,lineView2];
    item.canSelected = NO;
    [self.datasource addObject:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
