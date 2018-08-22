//
//  SaleViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售首页

#import "SaleViewController.h"
//#import "SalesDemandViewController.h"
#import "LZSalesDemandVC.h"
#import "OrderTrackingViewController.h"
#import "LZVisitRecordViewController.h"
#import "ClientManagerViewController.h"
#import "LZHTableView.h"
#import "FinancialCollectionViewCell.h"
#import "BackOrderViewController.h"
#import "LZHomeModel.h"

@interface SaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LZHTableViewDelegate>
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

- (void)setupUI
{
    self.mainTabelView.delegate = self;

	UIView * ci = [[UIView alloc]init];
	ci.backgroundColor = [UIColor redColor];
	ci.userInteractionEnabled = NO;
	[self.view addSubview:ci];
	
//    [self.mainTabelView setIsScrollEnable:NO];
    
    
    UIButton *button = [UIButton new];
    button.frame = self.view.bounds;
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    
    
    self.datasource = [NSMutableArray array];
    [self setupSectionOne];
    self.mainTabelView.dataSoure = self.datasource;
    [self.view addSubview:self.mainTabelView];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        [tableView setIsScrollEnable:NO];
//        tableView.tableView.allowsSelection = NO;
        //        tableView.tableHeaderView = self.headView;
        //        tableView.backgroundColor = [UIColor yellowColor];
//        [tableView setIsScrollEnable:YES];
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
//        SalesDemandViewController *vc = [[SalesDemandViewController alloc]init];
        LZSalesDemandVC *vc = [[LZSalesDemandVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"tailOrder"])
    {   //订单跟踪
        OrderTrackingViewController *vc = [[OrderTrackingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"visitRecord"])
    {   //拜访记录
        LZVisitRecordViewController *vc = [[LZVisitRecordViewController alloc]init];
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

- (void)setupSectionOne
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    [self setCollectionView];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.collectView];
    item.canSelected = YES;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
