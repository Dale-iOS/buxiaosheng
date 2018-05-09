//
//  InventoryDetailViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  仓库详情

#import "InventoryDetailViewController.h"

@interface InventoryDetailViewController ()
///总米数
@property (nonatomic, strong) UILabel *meterLbl;
///总码数
@property (nonatomic, strong) UILabel *codeLbl;
///总公斤
@property (nonatomic, strong) UILabel *kgLbl;
///总条数
@property (nonatomic, strong) UILabel *totalLbl;
@end

@implementation InventoryDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.titleView = [Utility navWhiteTitleView:@"广州大仓库"];
    //    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    //    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[Utility createImageWithColor:[UIColor colorWithHexString:@"#3d9bfa"]] forBarMetrics:UIBarMetricsDefault];
    
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"sale"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //修复navigationController侧滑关闭失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor greenColor]];
    [self setCustomLeftButton];
    //    self.title = @"银行明细";
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    //设置透明的背景图，便于识别底部线条有没有被隐藏
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    //此处使底部线条失效
    [navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = LZHBackgroundColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
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
    self.meterLbl.text = @"2390.00";
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
    .topSpaceToView(self.meterLbl, 15)
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
    self.codeLbl.text = @"2355.00";
    [bgBlueView addSubview:self.codeLbl];
    
    //布局
    self.codeLbl.sd_layout
    .topSpaceToView(bgBlueView, 30+64)
    .widthIs(APPWidth/3)
    .heightIs(36)
    .centerXEqualToView(bgBlueView);
    
    totalCodeLbl.sd_layout
    .topSpaceToView(self.codeLbl, 15)
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
    self.kgLbl.text = @"4325.00";
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
    .topSpaceToView(self.codeLbl, 15)
    .widthIs(APPWidth/3)
    .heightIs(14)
    .rightSpaceToView(bgBlueView, 0);
    
    lineView2.sd_layout
    .topEqualToView(totalKgLbl)
    .widthIs(1)
    .heightIs(14)
    .rightSpaceToView(totalKgLbl, 0);
    
    
    //总条数
    self.totalLbl = [[UILabel alloc]init];
    self.totalLbl.font = FONT(13);
    self.totalLbl.textAlignment = NSTextAlignmentCenter;
    self.totalLbl.textColor = [UIColor whiteColor];
    self.totalLbl.text = @"总条数：42565465";
    [bgBlueView addSubview:self.totalLbl];
    
    self.totalLbl.sd_layout
    .topSpaceToView(self.codeLbl, 45)
    .widthIs(APPWidth)
    .heightIs(14)
    .centerXEqualToView(bgBlueView);
    
    
    
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
    [rightButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
