//
//  WarehouseHomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  仓库首页页面

#import "WarehouseHomeViewController.h"
#import "LZHTableView.h"
#import "FinancialCollectionViewCell.h"
#import "WarehouserTableViewCell.h"
#import "ClientNeedsViewController.h"
#import "OutboundViewController.h"
#import "WithSingleViewControllerViewController.h"
#import "AssignDeliveryViewController.h"
#import "DyeingDemandViewController.h"
#import "StockTrackingViewController.h"

@interface WarehouseHomeViewController ()<UICollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableViewHeadView;
@property (nonatomic, strong) UILabel *dateLbl;

@end

@implementation WarehouseHomeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"仓库"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 14+45, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        //        tableView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}


#pragma mark -------- collectionView --------
- (void)setCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 100);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, APPWidth, 200) collectionViewLayout:flow];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    //    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    
    if (indexPath.row == 0) {
        
        cell.iconImageView.image = IMAGE(@"clientneeds");
        cell.titileLabel.text = @"客户需求";
    }
    else if (indexPath.row == 1)
    {
        cell.iconImageView.image = IMAGE(@"assigndelivery");
        cell.titileLabel.text = @"指派送货";
    }
    else if (indexPath.row == 2)
    {
        cell.iconImageView.image = IMAGE(@"withsingle");
        cell.titileLabel.text = @"跟单";
    }
    else if (indexPath.row == 3)
    {
        cell.iconImageView.image = IMAGE(@"warehouse11");
        cell.titileLabel.text = @"库存";
    }
    else if (indexPath.row == 4)
    {
        cell.iconImageView.image = IMAGE(@"DyeingRequirements");
        cell.titileLabel.text = @"织染需求";
    }
    else if (indexPath.row == 5)
    {
        cell.iconImageView.image = IMAGE(@"StockDemand");
        cell.titileLabel.text = @"备货需求";
    }
    else if (indexPath.row == 6)
    {
        cell.iconImageView.image = IMAGE(@"ProcurementProcessing");
        cell.titileLabel.text = @"采购加工";
    }
    else if (indexPath.row == 7)
    {
        cell.iconImageView.image = IMAGE(@"StockTracking");
        cell.titileLabel.text = @"备货跟踪";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {

        //客户需求
        ClientNeedsViewController *vc = [[ClientNeedsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        //指派送货
        OutboundViewController *vc = [[OutboundViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        //跟单
        AssignDeliveryViewController *vc = [[AssignDeliveryViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        //库存
        WithSingleViewControllerViewController *vc = [[WithSingleViewControllerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        //染指需求
        DyeingDemandViewController *vc = [[DyeingDemandViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    else if (indexPath.row == 5)
//    {
    //
//        BankDetailListViewController *vc = [[BankDetailListViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 6)
//    {
//        //备货需求
//        CustomerArrearsViewController *vc = [[CustomerArrearsViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    else if (indexPath.row == 7)
    {
        //备货跟踪
        StockTrackingViewController *vc = [[StockTrackingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(APPWidth /5, 80);
}

//设置每个item的边距
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)setupUI
{
    [self.mainTabelView setIsScrollEnable:NO];
    
    self.datasource = [NSMutableArray array];
    
    [self setupSectionOne];
    [self setupSectionTwo];
    
    self.mainTabelView.dataSoure = self.datasource;
    
}


- (void)setupSectionOne
{
    
    [self setCollectionView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.collectView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionTwo
{
    //tablve头部试图
    self.tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    
    //动态图标
    UIImageView *dynamicIV = [[UIImageView alloc]init];
    dynamicIV.image = IMAGE(@"dynamic");
    [self.tableViewHeadView addSubview:dynamicIV];
    dynamicIV.sd_layout
    .widthIs(22)
    .heightIs(22)
    .leftSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView);
    
    //仓库动态lbl
    UILabel *dynamicLbel = [[UILabel alloc]init];
    dynamicLbel.textColor = CD_Text33;
    dynamicLbel.font = FONT(14);
    dynamicLbel.text = @"仓库动态";
    [self.tableViewHeadView addSubview:dynamicLbel];
    dynamicLbel.sd_layout
    .leftSpaceToView(dynamicIV, 10)
    .widthIs(100)
    .centerYEqualToView(self.tableViewHeadView)
    .heightIs(15);
    
    //筛选按钮
    UIButton *dateBtn = [UIButton new];
    [dateBtn setImage:IMAGE(@"bankdate") forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tableViewHeadView addSubview:dateBtn];
    dateBtn.sd_layout
    .widthIs(16)
    .heightIs(16)
    .rightSpaceToView(self.tableViewHeadView, 15)
    .centerYEqualToView(self.tableViewHeadView);
    
    //日期
    self.dateLbl = [[UILabel alloc]init];
    self.dateLbl.font = FONT(14);
    self.dateLbl.textAlignment = NSTextAlignmentRight;
    self.dateLbl.textColor = CD_Text66;
    self.dateLbl.text = @"2018-4-2";
    [self.tableViewHeadView addSubview:self.dateLbl];
    self.dateLbl.sd_layout
    .rightSpaceToView(self.tableViewHeadView, 40)
    .centerYEqualToView(self.tableViewHeadView)
    .widthIs(150)
    .heightIs(15);
    
    //线
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [self.tableViewHeadView addSubview:lineView];
    lineView.sd_layout
    .bottomSpaceToView(self.tableViewHeadView, 1)
    .widthIs(APPWidth)
    .heightIs(1)
    .leftSpaceToView(self.tableViewHeadView, 0);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -20-200-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.tableViewHeadView;

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.tableView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

#pragma mark ------ tableViewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"WarehouserTableViewCell";
    WarehouserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        
        cell = [[WarehouserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

#pragma mark ----- 点击事件 -------
- (void)dateBtnClick
{
    NSLog(@"dateBtnClick");
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
