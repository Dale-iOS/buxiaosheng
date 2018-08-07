//
//  BankDetailViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行明细页面1

#import "BankDetailViewController.h"
#import "BankTableViewCell.h"
#import "BankConversionViewController.h"
#import "LZBankDetailModel.h"
#import "BankDetailListViewController.h"

@interface BankDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
///金额显示
@property (nonatomic, strong) UILabel *priceLbl;
///银行互转按钮
@property (nonatomic, strong) UIButton *conversionBtn;
@property(nonatomic,strong)LZBankDetailModel *model;
@property(nonatomic,strong)NSArray<LZBankDetailListModel*> *lists;

@end

@implementation BankDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.titleView = [Utility navWhiteTitleView:@"银行明细"];
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
    
    
    [self setupDetail];
}

- (void)setupUI
{
    
    
    UIView *bgBlueView = [[UIView alloc]init];
    bgBlueView.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
    bgBlueView.frame = CGRectMake(0, 0, APPWidth, LZHScale_HEIGHT(250)  +64);
    [self.view addSubview:bgBlueView];
    
    //总金额
    UILabel *totalMoneyLbl = [[UILabel alloc]init];
    totalMoneyLbl.font = FONT(13);
    totalMoneyLbl.textAlignment = NSTextAlignmentCenter;
    totalMoneyLbl.textColor = [UIColor whiteColor];
    totalMoneyLbl.text = @"总资金（元）";
    [bgBlueView addSubview:totalMoneyLbl];
    
    //具体金钱数
    self.priceLbl = [[UILabel alloc]init];
    self.priceLbl.font = [UIFont boldSystemFontOfSize:35];
    self.priceLbl.textColor = [UIColor whiteColor];
    self.priceLbl.textAlignment = NSTextAlignmentCenter;
//    self.priceLbl.text = @"2390.00";
    [bgBlueView addSubview:self.priceLbl];
    
    //布局
    self.priceLbl.sd_layout
    .topSpaceToView(bgBlueView, 32+64)
    .widthIs(APPWidth)
    .heightIs(36)
    .centerXEqualToView(bgBlueView);
    
    totalMoneyLbl.sd_layout
    .topSpaceToView(self.priceLbl, 15)
    .widthIs(APPWidth)
    .heightIs(14)
    .centerXEqualToView(bgBlueView);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, bgBlueView.height -20, APPWidth -30, APPHeight -bgBlueView.height+20-44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    

    
    //银行互转
    self.conversionBtn = [UIButton new];
    self.conversionBtn.frame = CGRectMake(0, APPHeight -44, APPWidth, 44);
    self.conversionBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [self.conversionBtn setTitle:@"银行互转" forState:UIControlStateNormal];
    [self.conversionBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [self.conversionBtn addTarget:self action:@selector(conversionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.conversionBtn.titleLabel.font = FONT(14);
    [self.view addSubview:self.conversionBtn];
    
}

#pragma mark --- 网络请求 ---
- (void)setupDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"finance_data/bank_detail_index.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZBankDetailModel LLMJParse:baseModel.data];
//        int total = [_model.totalAmount intValue];
        self.priceLbl.text = [NSString stringWithFormat:@"%.2f",_model.totalAmount.floatValue];
        _lists = _model.itemList;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"bankTableViewCell";
    
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[BankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LZBankDetailListModel *model = _lists[indexPath.row];
    BankDetailListViewController *vc = [[BankDetailListViewController alloc]init];
    vc.typeId = model.bankId;
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
    [rightButton addTarget:self action:@selector(navSearchClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark ---- 点击事件 ----
- (void)conversionBtnClick
{
    NSLog(@"点击了银行互转");
    
    BankConversionViewController *vc = [[BankConversionViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)navSearchClick{
    BankDetailListViewController *vc = [[BankDetailListViewController alloc]init];
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
