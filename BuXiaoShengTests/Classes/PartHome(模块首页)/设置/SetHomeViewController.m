//
//  SetHomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  设置页面

#import "SetHomeViewController.h"
#import "SettingCell.h"
#import "LZHTableView.h"
#import "SetBranchViewController.h"
#import "SetWarehouseViewController.h"
#import "CashBankViewController.h"
#import "AuditManagerViewController.h"
#import "SubjectViewController.h"
#import "OrganizationViewController.h"
#import "ProductViewController.h"
#import "RecipeViewController.h"
#import "SetCompanyViewController.h"
#import "SetClientViewController.h"
#import "LoginViewController.h"

@interface SetHomeViewController ()<LZHTableViewDelegate>
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///店铺
//@property (nonatomic, strong) SettingCell *storeCell;
///仓库
@property (nonatomic, strong) SettingCell *warehouseCell;
///现金银行
@property (nonatomic, strong) SettingCell *bankCell;
///审批人管理
@property (nonatomic, strong) SettingCell *auditManagerCell;
///科目
@property (nonatomic, strong) SettingCell *subjectCell;
///组织结构
@property (nonatomic, strong) SettingCell *organizationCell;
///产品资料
@property (nonatomic, strong) SettingCell *productCell;
///客户
@property (nonatomic, strong) SettingCell *clientCell;
///厂商
@property (nonatomic, strong) SettingCell *companyCell;
///配方
@property (nonatomic, strong) SettingCell *recipeCell;
///切换用户按钮
@property (nonatomic, strong) UIButton *changeUserBtn;

@end

@implementation SetHomeViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"设置"];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -49)];
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
    [self setupSectionOne];
    [self setupSectionTwo];
    [self setupSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
    self.changeUserBtn = [UIButton new];
    [self.changeUserBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.changeUserBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    self.changeUserBtn.titleLabel.font = FONT(14);
    [self.changeUserBtn setBackgroundColor:[UIColor whiteColor]];
    self.changeUserBtn.frame = CGRectMake(0, APPHeight -49, APPWidth, 49);
    [self.changeUserBtn addTarget:self action:@selector(changeUserBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeUserBtn];
    
}

- (void)setupSectionOne
{
//    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 69)];
//    remarkView.backgroundColor = LZHBackgroundColor;

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //店铺
//    self.storeCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
//    self.storeCell.iconImageView.image = IMAGE(@"store");
//    self.storeCell.titleLabel.text = @"店铺";
//    UITapGestureRecognizer *storeCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(storeCellTapAction)];
//    [self.storeCell addGestureRecognizer:storeCellTap];
    
    //仓库
    self.warehouseCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.warehouseCell.iconImageView.image = IMAGE(@"warehouse1");
    self.warehouseCell.titleLabel.text = @"仓库";
    UITapGestureRecognizer *warehouseCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(warehouseCellTapAction)];
    [self.warehouseCell addGestureRecognizer:warehouseCellTap];
    
    
    //现金银行
    self.bankCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.bankCell.iconImageView.image = IMAGE(@"bank");
    self.bankCell.titleLabel.text = @"现金银行";
    UITapGestureRecognizer *bankCellCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bankCellTapAction)];
    [self.bankCell addGestureRecognizer:bankCellCellTap];
    
    
    
    //审批人管理
    self.auditManagerCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.auditManagerCell.iconImageView.image = IMAGE(@"auditManager");
    self.auditManagerCell.titleLabel.text = @"审批人管理";
    UITapGestureRecognizer *auditManagerCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(auditManagerCellTapAction)];
    [self.auditManagerCell addGestureRecognizer:auditManagerCellTap];
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.warehouseCell,self.bankCell,self.auditManagerCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}


- (void)setupSectionTwo
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //科目
    self.subjectCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.subjectCell.iconImageView.image = IMAGE(@"subject");
    self.subjectCell.titleLabel.text = @"科目";
    UITapGestureRecognizer *subjectCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subjectCellTapAction)];
    [self.subjectCell addGestureRecognizer:subjectCellTap];
    
    
    //组织架构
    self.organizationCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.organizationCell.iconImageView.image = IMAGE(@"organization");
    self.organizationCell.titleLabel.text = @"组织架构";
    UITapGestureRecognizer *organizationCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(organizationCellTapAction)];
    [self.organizationCell addGestureRecognizer:organizationCellTap];
    
    
    //产品资料
    self.productCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.productCell.iconImageView.image = IMAGE(@"product");
    self.productCell.titleLabel.text = @"产品资料";
    UITapGestureRecognizer *productCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(productCellTapAction)];
    [self.productCell addGestureRecognizer:productCellTap];
    
    
    //客户
    self.clientCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.clientCell.iconImageView.image = IMAGE(@"client");
    self.clientCell.titleLabel.text = @"客户管理";
    UITapGestureRecognizer *clientCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clientCellTapAction)];
    [self.clientCell addGestureRecognizer:clientCellTap];
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.subjectCell,self.organizationCell,self.productCell,self.clientCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupSectionThree
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //厂商
    self.companyCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.companyCell.iconImageView.image = IMAGE(@"company");
    self.companyCell.titleLabel.text = @"厂商";
    UITapGestureRecognizer *companyCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(companyCellTapAction)];
    [self.companyCell addGestureRecognizer:companyCellTap];
    
    //配方表
    self.recipeCell = [[SettingCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.recipeCell.iconImageView.image = IMAGE(@"recipe");
    self.recipeCell.titleLabel.text = @"配方表";
    UITapGestureRecognizer *recipeCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recipeCellTapAction)];
    [self.recipeCell addGestureRecognizer:recipeCellTap];
    
    //暂时隐藏配方表
   
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
//    item.sectionRows = @[self.companyCell,self.recipeCell];
    item.sectionRows = @[self.companyCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}


#pragma mark ------ 点击事件 --------
//店铺
- (void)storeCellTapAction
{
    SetBranchViewController *vc = [[SetBranchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//仓库
- (void)warehouseCellTapAction
{
    NSLog(@"warehouseCellTapAction");
    
    SetWarehouseViewController *vc = [[SetWarehouseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//现金银行
- (void)bankCellTapAction
{
    NSLog(@"bankCellTapAction");
    
    CashBankViewController *vc = [[CashBankViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//审批人管理
- (void)auditManagerCellTapAction
{
    NSLog(@"auditManagerCellTapAction");
    
    AuditManagerViewController *vc = [[AuditManagerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//科目
- (void)subjectCellTapAction
{
    NSLog(@"subjectCellTapAction");
    
    SubjectViewController *vc = [[SubjectViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//组织架构
- (void)organizationCellTapAction
{
    NSLog(@"organizationCellTapAction");
    
    OrganizationViewController *vc = [[OrganizationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//产品资料
- (void)productCellTapAction
{
    NSLog(@"productCellTapAction");
    
    ProductViewController *vc = [[ProductViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//客户
- (void)clientCellTapAction
{
    NSLog(@"clientCellTapAction");
    
    SetClientViewController *vc = [[SetClientViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//厂商
- (void)companyCellTapAction
{
    NSLog(@"companyCellTapAction");
    
    SetCompanyViewController *vc = [[SetCompanyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//配方表
- (void)recipeCellTapAction
{
    NSLog(@"recipeCellTapAction");
    
    RecipeViewController *vc = [[RecipeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


//切换用户
- (void)changeUserBtnClick
{
    NSDictionary * param = @{@"token":[BXSUser currentUser].token,
                             @"userId":[BXSUser currentUser].userId
                             };
    [LLHudTools showLoadingMessage:LLLoadingMessage];
    [BXSHttp requestGETWithAppURL:@"login_out.do" param:param success:^(id response) {
        [LLHudTools dismiss];
        if ([response[@"code"] integerValue] == 200) {
            [BXSUser deleteUser];
            //[[NSNotificationCenter defaultCenter] postNotificationName:LLLoginStateNotification object:nil];
            //[self.navigationController pushViewController:[LoginViewController new] animated:true];
            UINavigationController * navVc = [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
            [UIApplication sharedApplication].keyWindow.rootViewController = navVc;
        }
         [LLHudTools showWithMessage:response[@"msg"]];
    } failure:^(NSError *error) {
         [LLHudTools dismiss];
    }];
    NSLog(@"点击了 切换用户 按钮");

    
    
    
    
    
//    LoginViewController *vc = [[LoginViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
