//
//  SaleViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SaleViewController.h"
#import "HomeEntranceCell.h"
#import "SalesDemandViewController.h"
#import "OrderTrackingViewController.h"
#import "VisitRecordViewController.h"
#import "ClientManagerViewController.h"
#import "LZHTableView.h"
#import "FinancialCollectionViewCell.h"
#import "BackOrderViewController.h"

@interface SaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectView;
@end

@implementation SaleViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"销售";
    self.navigationItem.titleView = [Utility navTitleView:@"销售"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];;
    
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
        
        cell.iconImageView.image = IMAGE(@"beginOrder");
        cell.titileLabel.text = @"开单";
    }
    else if (indexPath.row == 1)
    {
        cell.iconImageView.image = IMAGE(@"tailOrder");
        cell.titileLabel.text = @"订单跟踪";
    }
    else if (indexPath.row == 2)
    {
        cell.iconImageView.image = IMAGE(@"visitRecord");
        cell.titileLabel.text = @"拜访记录";
    }
    else if (indexPath.row == 3)
    {
        cell.iconImageView.image = IMAGE(@"clientManager");
        cell.titileLabel.text = @"客户管理";
    }
    else if (indexPath.row == 4)
    {
        cell.iconImageView.image = IMAGE(@"backOrder");
        cell.titileLabel.text = @"退单";
    }
//    else if (indexPath.row == 5)
//    {
//        cell.iconImageView.image = IMAGE(@"StockDemand");
//        cell.titileLabel.text = @"备货需求";
//    }
//    else if (indexPath.row == 6)
//    {
//        cell.iconImageView.image = IMAGE(@"ProcurementProcessing");
//        cell.titileLabel.text = @"采购加工";
//    }
//    else if (indexPath.row == 7)
//    {
//        cell.iconImageView.image = IMAGE(@"StockTracking");
//        cell.titileLabel.text = @"备货跟踪";
//    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        //开单
        SalesDemandViewController *vc = [[SalesDemandViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        //订单跟踪
        OrderTrackingViewController *vc = [[OrderTrackingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
    else if (indexPath.row == 2)
    {
        //拜访记录
        VisitRecordViewController *vc = [[VisitRecordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        //客户管理
        ClientManagerViewController *vc = [[ClientManagerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        //退单
        BackOrderViewController *vc = [[BackOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];;
       
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
//    else if (indexPath.row == 7)
//    {
//        //备货跟踪
//        StockTrackingViewController *vc = [[StockTrackingViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}


//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
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


//----------


















//- (void)setupUI
//{
//    //设置item的属性
//    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
//    flow.itemSize = CGSizeMake(APPWidth /4, 94);
//    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//    //创建collectionView
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, APPWidth, 100) collectionViewLayout:flow];
//    //复用
//    [collectionView registerClass:[HomeEntranceCell class] forCellWithReuseIdentifier:@"cellid"];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    collectionView.backgroundColor = [UIColor yellowColor];
//    
//    [self.view addSubview:collectionView];
//    
//}
//
////一组返回item数量
//- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 10;
//}
// 
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellID = @"cellid";
////    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    
//    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
//    
//    cell.iconImageView.image = IMAGE(@"sale");
////    cell.backgroundColor = [UIColor redColor];
//    cell.iconImageView.backgroundColor = [UIColor whiteColor];
//    
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"点击了 %ld",(long)indexPath.row);
//    
//    if (indexPath.row == 0) {
//        
//        SalesDemandViewController *vc = [[SalesDemandViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 1)
//    {
//        OrderTrackingViewController *vc = [[OrderTrackingViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 2)
//    {
//        VisitRecordViewController *vc = [[VisitRecordViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    else if (indexPath.row == 3)
//    {
//        ClientManagerViewController *vc = [[ClientManagerViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}
//
////设置itme大小
//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(APPWidth /4, 50);
//}
//
////设置每个item的边距
//-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
