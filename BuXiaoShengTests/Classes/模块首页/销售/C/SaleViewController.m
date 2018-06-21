//
//  SaleViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售首页

#import "SaleViewController.h"
#import "HomeEntranceCell.h"
#import "SalesDemandViewController.h"
#import "OrderTrackingViewController.h"
#import "VisitRecordViewController.h"
#import "ClientManagerViewController.h"
#import "LZHTableView.h"
#import "FinancialCollectionViewCell.h"
#import "BackOrderViewController.h"
#import "LZHomeModel.h"

@interface SaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) UICollectionView *collectView;
@property (nonatomic, strong) NSArray <LZHomeModel *> *buttons;
@end

@implementation SaleViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [Utility navTitleView:@"销售"];
    self.view.backgroundColor = [UIColor whiteColor];;
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupBtns];
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

#pragma mark ----- 网络请求 -------
- (void)setupBtns
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buttonId":self.buttonId
                             };
    [BXSHttp requestGETWithAppURL:@"home/button_page.do" param:param success:^(id response) {
        
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.buttons = [LZHomeModel LLMJParse:baseModel.data];
//        if (self.buttons.count <5) {
//            self.collectView.frame = CGRectMake(0, 20, APPWidth, 110);
//        }else
//        {
//            self.collectView.frame = CGRectMake(0, 20, APPWidth, 220);
//        }
        [self.collectView reloadData];
        [self.mainTabelView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}


#pragma mark -------- collectionView --------
- (void)setCollectionView
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /5, 90);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = APPWidth *0.05;
    flow.sectionInset = UIEdgeInsetsMake(0, APPWidth *0.05, 0,APPWidth *0.05);//上左下右
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

    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    
    if ([model.paramsIos isEqualToString:@"beginOrder"]) {
        //开单
        SalesDemandViewController *vc = [[SalesDemandViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"tailOrder"])
    {   //订单跟踪
        OrderTrackingViewController *vc = [[OrderTrackingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"visitRecord"])
    {   //拜访记录
        VisitRecordViewController *vc = [[VisitRecordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"clientManager"])
    {   //客户管理
        ClientManagerViewController *vc = [[ClientManagerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"backOrder"])
    {   //退单
        BackOrderViewController *vc = [[BackOrderViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buttons.count;
}

////设置itme大小
//-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(APPWidth /5, 80);
//}
//
////设置每个item的边距
//-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
