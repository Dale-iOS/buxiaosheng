//
//  InventoryViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  库存页面（仓库库存页面）

#import "InventoryViewController.h"
#import "InventoryCell.h"
#import "BankConversionViewController.h"
#import "InventoryDetailViewController.h"
#import "LZInventoryModel.h"
#import "LZSearchWarehouseVC.h"
#import "LZWarehouseShiftVC.h"
@interface InventoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
///总米数
@property (nonatomic, strong) UILabel *meterLbl;
///总码数
@property (nonatomic, strong) UILabel *codeLbl;
///总公斤
@property (nonatomic, strong) UILabel *kgLbl;
@property(nonatomic,strong)LZInventoryModel *model;
@property(nonatomic,strong)NSArray <LZInventoryListModel*> *listAry;
@property (nonatomic, strong) UIButton *changeBtn;//库存互转按钮
@end


@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.titleView = [Utility navWhiteTitleView:@"库存"];
    
    [self.navigationController.navigationBar setBackgroundImage:[Utility createImageWithColor:[UIColor colorWithHexString:@"#3d9bfa"]] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //修复navigationController侧滑关闭失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setCustomLeftButton];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //设置透明的背景图，便于识别底部线条有没有被隐藏
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    //此处使底部线条失效
    [navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = LZHBackgroundColor;
    
    [self setupDetailData];
    
}

- (void)setupUI
{
    
    UIView *bgBlueView = [[UIView alloc]init];
    bgBlueView.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    bgBlueView.frame = CGRectMake(0, 0, APPWidth, LZHScale_HEIGHT(250)  +64);
    [self.view addSubview:bgBlueView];
    
    //总米数
    UILabel *totalMeterLbl = [[UILabel alloc]init];
    totalMeterLbl.font = FONT(13);
    totalMeterLbl.textAlignment = NSTextAlignmentCenter;
    totalMeterLbl.textColor = [UIColor whiteColor];
    totalMeterLbl.text = @"总米数";
    [bgBlueView addSubview:totalMeterLbl];
    
    //具体米数
    self.meterLbl = [[UILabel alloc]init];
    self.meterLbl.font = [UIFont boldSystemFontOfSize:18];
    self.meterLbl.textColor = [UIColor whiteColor];
    self.meterLbl.textAlignment = NSTextAlignmentCenter;
    [bgBlueView addSubview:self.meterLbl];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor whiteColor];
    [bgBlueView addSubview:lineView1];
    
    //布局
    self.meterLbl.sd_layout
    .topSpaceToView(bgBlueView, 30+64)
    .widthIs(APPWidth/3)
    .heightIs(36)
    .leftSpaceToView(bgBlueView, 0);
    
    totalMeterLbl.sd_layout
    .topSpaceToView(self.meterLbl, 10)
    .widthIs(APPWidth/3)
    .heightIs(14)
    .leftSpaceToView(bgBlueView, 0);
    
    lineView1.sd_layout
    .topEqualToView(totalMeterLbl)
    .widthIs(1)
    .heightIs(14)
    .leftSpaceToView(bgBlueView, APPWidth/3);
    
    
    
    //总码数
    UILabel *totalCodeLbl = [[UILabel alloc]init];
    totalCodeLbl.font = FONT(13);
    totalCodeLbl.textAlignment = NSTextAlignmentCenter;
    totalCodeLbl.textColor = [UIColor whiteColor];
    totalCodeLbl.text = @"总码数";
    [bgBlueView addSubview:totalCodeLbl];
    
    //具体码数
    self.codeLbl = [[UILabel alloc]init];
    self.codeLbl.font = [UIFont boldSystemFontOfSize:18];
    self.codeLbl.textColor = [UIColor whiteColor];
    self.codeLbl.textAlignment = NSTextAlignmentCenter;
    [bgBlueView addSubview:self.codeLbl];
    
    //布局
    self.codeLbl.sd_layout
    .topSpaceToView(bgBlueView, 30+64)
    .widthIs(APPWidth/3)
    .heightIs(36)
    .centerXEqualToView(bgBlueView);
    
    totalCodeLbl.sd_layout
    .topSpaceToView(self.codeLbl, 10)
    .widthIs(APPWidth/3)
    .heightIs(14)
    .centerXEqualToView(bgBlueView);
    
    
    //总公斤
    UILabel *totalKgLbl = [[UILabel alloc]init];
    totalKgLbl.font = FONT(13);
    totalKgLbl.textAlignment = NSTextAlignmentCenter;
    totalKgLbl.textColor = [UIColor whiteColor];
    totalKgLbl.text = @"总公斤";
    [bgBlueView addSubview:totalKgLbl];
    
    //具体公斤
    self.kgLbl = [[UILabel alloc]init];
    self.kgLbl.font = [UIFont boldSystemFontOfSize:18];
    self.kgLbl.textColor = [UIColor whiteColor];
    self.kgLbl.textAlignment = NSTextAlignmentCenter;
    [bgBlueView addSubview:self.kgLbl];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor whiteColor];
    [bgBlueView addSubview:lineView2];
    
    //布局
    self.kgLbl.sd_layout
    .topSpaceToView(bgBlueView, 30+64)
    .widthIs(APPWidth/3)
    .heightIs(36)
    .rightSpaceToView(bgBlueView, 0);
    
    totalKgLbl.sd_layout
    .topSpaceToView(self.codeLbl, 10)
    .widthIs(APPWidth/3)
    .heightIs(14)
    .rightSpaceToView(bgBlueView, 0);
    
    lineView2.sd_layout
    .topEqualToView(totalKgLbl)
    .widthIs(1)
    .heightIs(14)
    .rightSpaceToView(totalKgLbl, 0);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, bgBlueView.height -20, APPWidth -30, APPHeight -bgBlueView.height+20 -50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.changeBtn = [[UIButton alloc]init];
    [self.changeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.changeBtn setTitle:@"仓库互转" forState:UIControlStateNormal];
    [self.changeBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
    self.changeBtn.titleLabel.font = FONT(15);
    [self.changeBtn addTarget:self action:@selector(changeBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeBtn];
    self.changeBtn.sd_layout
    .topSpaceToView(self.tableView, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(50);
    
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listAry.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"InventoryCell";
    
    InventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[InventoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _listAry[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZInventoryListModel *model = _listAry[indexPath.row];
    InventoryDetailViewController *vc = [[InventoryDetailViewController alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

//恢复到设置背景图之前的外观
- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = nil;
    
    //恢复到之前的状态
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:nil
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:nil];
}

//设置导航栏按钮
- (void)setCustomLeftButton {
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:@"whiteback"] forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.tintColor = [UIColor whiteColor];
    leftButton.autoresizesSubviews = YES;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [leftButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView* rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.frame = rightButtonView.frame;
    [rightButton setImage:[UIImage imageNamed:@"wihtesearch"] forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    rightButton.tintColor = [UIColor whiteColor];
    rightButton.autoresizesSubviews = YES;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma mark ----- 网络请求 ------
- (void)setupDetailData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"house_stock/index.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZInventoryModel LLMJParse:baseModel.data];
        NSArray *tempAry = baseModel.data;
        if (tempAry.count >0) {
            self.meterLbl.text = [NSString stringWithFormat:@"%.1f",_model.totalRice.doubleValue];
            self.codeLbl.text = [NSString stringWithFormat:@"%.1f",_model.totalCode.doubleValue];
            self.kgLbl.text = [NSString stringWithFormat:@"%.1f",_model.totalKg.doubleValue];
            _listAry = _model.itemList;
            [self.tableView reloadData];
        }
//        self.meterLbl.text = _model.totalRice;
//        self.codeLbl.text = _model.totalCode;
//        self.kgLbl.text = _model.totalKg;
//        _listAry = _model.itemList;
//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)rightButtonClick
{
    LZSearchWarehouseVC *vc = [[LZSearchWarehouseVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//点击仓库互转按钮点击事件
- (void)changeBtnClickAction{
    LZWarehouseShiftVC *vc = [[LZWarehouseShiftVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
