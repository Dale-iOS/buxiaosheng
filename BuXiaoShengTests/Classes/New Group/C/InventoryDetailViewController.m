//
//  InventoryDetailViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  仓库详情页面

#import "InventoryDetailViewController.h"
#import "CustomerArrearsTableViewCell.h"
#import "LZInventoryDetailModel.h"
#import "LZSearchBar.h"
#import "LZDrawerChooseView.h"
#import "HXTagsView.h"
#import "LLCashBankModel.h"


@interface InventoryDetailViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate,LZDrawerChooseViewDelegate>
///总米数
@property (nonatomic, strong) UILabel *meterLbl;
///总码数
@property (nonatomic, strong) UILabel *codeLbl;
///总公斤
@property (nonatomic, strong) UILabel *kgLbl;
///总条数
@property (nonatomic, strong) UILabel *totalLbl;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property(nonatomic,strong)NSArray <LZInventoryDetailModel *> *listsAry;
@property(nonatomic,strong)LZInventoryDetailModel *titleModel;
@property (nonatomic, strong) LZSearchBar *searchBar;
@property(nonatomic,strong)LZDrawerChooseView *chooseView;
@property(nonatomic,strong)UIView *bottomBlackView;//侧滑的黑色底图
@property(nonatomic,strong)NSArray * unitsAry;
@property(nonatomic,strong)UILabel *unitTitleLbl;
@end

@implementation InventoryDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
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
    
    [self setupData];
    [self setupDetailData];
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
    
    
    //总条数
    self.totalLbl = [[UILabel alloc]init];
    self.totalLbl.font = FONT(13);
    self.totalLbl.textAlignment = NSTextAlignmentCenter;
    self.totalLbl.textColor = [UIColor whiteColor];
    [bgBlueView addSubview:self.totalLbl];
    
    self.totalLbl.sd_layout
    .topSpaceToView(self.codeLbl, 45)
    .widthIs(APPWidth)
    .heightIs(14)
    .centerXEqualToView(bgBlueView);
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, bgBlueView.bottom, APPWidth, 44)];
    self.searchBar.placeholder = @"输入品名或批号搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, 39)];
    self.headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:self.headView];
    
    [self setupHeadView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.bottom, APPWidth, APPHeight -64-10) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    //隐藏分割线
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
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
    [rightButton setImage:[UIImage imageNamed:@"whiteScreen"] forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    rightButton.tintColor = [UIColor whiteColor];
    rightButton.autoresizesSubviews = YES;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [rightButton addTarget:self action:@selector(screenAddClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


//设置顶部
- (void)setupHeadView
{
    
    
    //客户名称
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"品名";
    titleLbl.textColor = CD_Text33;
    titleLbl.font = FONT(14);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:titleLbl];
    
    //应收借欠
    UILabel *lineLbl = [[UILabel alloc]init];
    lineLbl.text = @"条数";
    lineLbl.textColor = CD_Text33;
    lineLbl.font = FONT(14);
    lineLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:lineLbl];
    
    //最后还款日期
    UILabel *numLbl = [[UILabel alloc]init];
    numLbl.text = @"数量";
    numLbl.textColor = CD_Text33;
    numLbl.font = FONT(14);
    numLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:numLbl];
    
    //业务员
    UILabel *unitLbl = [[UILabel alloc]init];
    unitLbl.text = @"单位";
    unitLbl.textColor = CD_Text33;
    unitLbl.font = FONT(14);
    unitLbl.textAlignment = NSTextAlignmentCenter;
    [self.headView addSubview:unitLbl];
    
    titleLbl.sd_layout
    .leftSpaceToView(self.headView, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    lineLbl.sd_layout
    .leftSpaceToView(titleLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    numLbl.sd_layout
    .leftSpaceToView(lineLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
    
    unitLbl.sd_layout
    .leftSpaceToView(numLbl, 0)
    .heightRatioToView(self.headView, 1)
    .widthIs(APPWidth/4)
    .topSpaceToView(self.headView, 0);
}

#pragma mark ----- 网络请求 ------
//接口：仓库产品列表
- (void)setupDetailData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"houseId":self.id,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_product_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _listsAry = [LZInventoryDetailModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口：仓库库存信息
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"houseId":self.id,
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _titleModel = [LZInventoryDetailModel LLMJParse:baseModel.data];
        self.navigationItem.titleView = [Utility navWhiteTitleView:_titleModel.houseName];
        self.meterLbl.text = _titleModel.totalRice;
        self.codeLbl.text = _titleModel.totalCode;
        self.kgLbl.text = _titleModel.totalKg;
        self.totalLbl.text = [NSString stringWithFormat:@"总条数：%@",_titleModel.total];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//单位列表
- (void)setupUnitData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product_unit/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _unitsAry = baseModel.data;
        NSMutableArray *muAry = [NSMutableArray array];
        for (int i = 0; i <_unitsAry.count; i++) {
            [muAry addObject:_unitsAry[i][@"name"]];
        }
        HXTagsView *tagsUnitView = [[HXTagsView alloc] initWithFrame:CGRectMake(APPWidth *0.25, _unitTitleLbl.bottom,  APPWidth *0.75, 0)];
        tagsUnitView.type = 1;
        tagsUnitView.masksToBounds = YES;
        tagsUnitView.isFixedTat = YES;
        tagsUnitView.fixedContentSize = CGSizeMake(APPWidth *0.18, 35);
        [tagsUnitView setTagAry:muAry delegate:self];
        [_chooseView addSubview:tagsUnitView];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listsAry.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"CustomerArrearsTableViewCell";
    
    CustomerArrearsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        
        cell = [[CustomerArrearsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _listsAry[indexPath.row];
    return cell;
}

- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"houseId":self.id,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_product_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _listsAry = [LZInventoryDetailModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- 抽屉 -----
//点击筛选
- (void)screenAddClick{
    _bottomBlackView.alpha = 0.65;
    _bottomBlackView.hidden = NO;
    [UIView animateWithDuration:0.35 animations:^{
        _chooseView .frame = CGRectMake(0, 0, APPWidth, APPHeight);
    }];
    
    [_chooseView setColorTFBlock:^(NSString *colorName, NSString *colorId, NSString *productId) {
        
    }];
}

//初始化抽屉
- (void)setupchooseView{
    
    //抽屉时的黑色底图
    _bottomBlackView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bottomBlackView.backgroundColor = [UIColor blackColor];
    _bottomBlackView.hidden = YES;
    [self.view addSubview:_bottomBlackView];
    
    _chooseView = [[LZDrawerChooseView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, APPHeight)];
    _chooseView.delegate = self;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_chooseView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_chooseView.alphaiView addGestureRecognizer:tap];
    
    //    抽屉UI
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(APPWidth *0.25, LLNavViewHeight -29, APPWidth *0.75, 29)];
    titleLbl.backgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
    titleLbl.font = FONT(12);
    titleLbl.textColor = CD_Text99;
    titleLbl.text = @"  选择筛选";
    [_chooseView addSubview:titleLbl];
    //单行不滚动 ===============
    NSArray *tagAry = @[@"从多到少",@"从少到多"];
    
    UILabel *titleLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(APPWidth *0.25, titleLbl.bottom , APPWidth *0.75, 29)];
    titleLbl2.backgroundColor = [UIColor whiteColor];
    titleLbl2.font = FONT(12);
    titleLbl2.textColor = CD_Text99;
    titleLbl2.text = @"  数量排序";
    [_chooseView addSubview:titleLbl2];
    
    //单行不需要设置高度,内部根据初始化参数自动计算高度
    HXTagsView *tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(APPWidth *0.25, titleLbl2.bottom,  APPWidth *0.75, 0)];
    tagsView.type = 1;
    tagsView.masksToBounds = YES;
    tagsView.isFixedTat = YES;
    tagsView.fixedContentSize = CGSizeMake(APPWidth *0.25, 35);
    [tagsView setTagAry:tagAry delegate:self];
    [_chooseView addSubview:tagsView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth *0.25, tagsView.bottom, APPWidth *0.75, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_chooseView addSubview:lineView];
    
    _unitTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(APPWidth *0.25, lineView.bottom, APPWidth *0.75, 29)];
    _unitTitleLbl.backgroundColor = [UIColor whiteColor];
    _unitTitleLbl.font = FONT(12);
    _unitTitleLbl.textColor = CD_Text99;
    _unitTitleLbl.text = @"  单位";
    [_chooseView addSubview:_unitTitleLbl];
    //单行不滚动 ===============
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.35 animations:^{
        _bottomBlackView.alpha = 0;
        _chooseView .frame = CGRectMake(APPWidth, 0, APPWidth, APPHeight);
        
    } completion:nil];
    
}

//侧栏确定按钮方法
- (void)didClickMakeSureBtnWithName:(NSString *)chooseStr WithId:(NSString *)chooseId WithProductId:(NSString *)chooseProductId
{
    [self dismiss];
}

#pragma mark --- HXTagsViewDelegate ---

/**
 *  tagsView代理方法
 *
 *  @param tagsView tagsView
 *  @param sender   tag:sender.titleLabel.text index:sender.tag
 */
- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
    
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
