//
//  HomeViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "HomeViewController.h"
#import "LZHTableView.h"
#import "HomeEntranceView.h"
#import "SaleViewController.h"

@interface HomeViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property (nonatomic, strong) UIView *headView;
///首页入口cell
@property (nonatomic, strong) HomeEntranceView *entranceViewCell;

@end

@implementation HomeViewController
@synthesize mainTabelView,headView;

//- (id)init
//{
//    self = [self init];
//    if (self) {
//
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self setupUI];
}

#pragma mark -------- lazy loading --------
- (UIView *)headView
{
    if (!headView) {
        
        //首页自定义导航栏底图View
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 14, self.view.frame.size.width, 45)];
        headerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:(headView = headerView)];
        
        //龙纺布行 label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 75, 19)];
        titleLabel.text = @"龙纺布行";
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:titleLabel];
        
        //导航栏右上角设置按钮
        UIButton *setupBtn = [UIButton new];
        setupBtn.frame = CGRectMake(self.view.frame.size.width -15-20, 15, 20, 20);
        [setupBtn setBackgroundImage:[UIImage imageNamed:@"homesetup"] forState:UIControlStateNormal];
        [setupBtn addTarget:self action:@selector(setupBtnOnClickAciont) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:setupBtn];
        
        //阴影
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.startPoint = CGPointMake(0.5, 0);
        layer.endPoint = CGPointMake(0.5, 1);
        layer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#eeeeee"].CGColor,(id)[UIColor whiteColor].CGColor, nil];
        layer.locations = @[@0.0f,@0.9f];
        layer.frame = CGRectMake(0, 45, self.view.frame.size.width, 5);
        
        [headerView.layer insertSublayer:layer atIndex:0];
    }
    return headView;
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

- (void)iniSectionOne
{
    
    _entranceViewCell = [[HomeEntranceView alloc]init];
    _entranceViewCell.frame = CGRectMake(0, 0, APPWidth, 120);
    _entranceViewCell.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(entranceViewCellTapOnClick)];
    [_entranceViewCell addGestureRecognizer:tap];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //    item.sectionView = self.headView;
    item.sectionRows = @[_entranceViewCell];
    [self.datasource addObject:item];
    
}

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    self.mainTabelView.tableHeaderView = self.headView;
    
    [self iniSectionOne];
    
    self.mainTabelView.dataSoure = self.datasource;
    
}

#pragma  mark -------- tableViewDelegate --------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellId = @"cell";
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//    }
//    return cell;
//}

#pragma mark -------- 点击事件 -----------
- (void)setupBtnOnClickAciont
{
    NSLog(@"点击了右上角的设置按钮");
}

//点击销售入口按钮
- (void)entranceViewCellTapOnClick
{
    //    NSLog(@"entranceViewCellTapOnClick");
    SaleViewController *saleVC = [[SaleViewController alloc]init];
    [self.navigationController pushViewController:saleVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

