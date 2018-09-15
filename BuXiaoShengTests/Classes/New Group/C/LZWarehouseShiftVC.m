//
//  LZWarehouseShiftVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/9/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  库存互转页面

#import "LZWarehouseShiftVC.h"

@interface LZWarehouseShiftVC ()
@property (nonatomic, strong) UIButton *verifyBtn;//确认按钮
@end

@implementation LZWarehouseShiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Utility navWhiteTitleView:@"库存互转"];
    //
    [self.navigationController.navigationBar setBackgroundImage:[Utility createImageWithColor:[UIColor colorWithHexString:@"#3d9bfa"]] forBarMetrics:UIBarMetricsDefault];
    
    [self setCustomLeftButton];
//    [self setupPayList];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //恢复到设置背景图之前的外观
    
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

- (void)setupUI
{
    self.verifyBtn = [[UIButton alloc]init];
    [self.verifyBtn setBackgroundColor:LZAppBlueColor];
    [self.verifyBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.verifyBtn.titleLabel.font = FONT(15);
    [self.verifyBtn addTarget:self action:@selector(changeBtnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.verifyBtn];
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_offset(50);
    }];
}

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
    [rightButton setTitle:@"确认" forState:UIControlStateNormal];
    rightButton.tintColor = [UIColor whiteColor];
    rightButton.autoresizesSubviews = YES;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [rightButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    //    UIview来做导航栏右按钮
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


#pragma mark --- 网络请求 ---
//接口名称 银行列表
//- (void)setupPayList{
//
//    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
//    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//        NSMutableArray *tempAry = baseModel.data;
//        self.payNameAry = [NSMutableArray array];
//        self.payIdAry = [NSMutableArray array];
//        self.balanceAry = [NSMutableArray array];
//        for (int i = 0; i <tempAry.count; i++) {
//            [self.payIdAry addObject:tempAry[i][@"id"]];
//            [self.payNameAry addObject:tempAry[i][@"name"]];
//            [self.balanceAry addObject:tempAry[i][@"amount"]];
//        }
//    } failure:^(NSError *error) {
//        BXS_Alert(LLLoadErrorMessage);
//    }];
//}

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
