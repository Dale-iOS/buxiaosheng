//
//  LZSearchWarehouseVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSearchWarehouseVC.h"
#import "LZSearchBar.h"
#import "LZInventoryDetailCell.h"
#import "LZInventoryDetailModel.h"
#import "LZDrawerChooseView.h"
#import "HXTagsView.h"
#import "LLCashBankModel.h"

@interface LZSearchWarehouseVC ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource,LZDrawerChooseViewDelegate>
@property(nonatomic,strong)LZSearchBar*searchBar;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)NSArray<LZInventoryDetailModel *> *listsAry;
@property(nonatomic,strong)LZDrawerChooseView *chooseView;
@property(nonatomic,strong)UIView *bottomBlackView;//侧滑的黑色底图
@property(nonatomic,strong)NSArray * unitsAry;
@property(nonatomic,strong)UILabel *unitTitleLbl;
@end

@implementation LZSearchWarehouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
    [self setupUnitData];
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"查找全库存"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenAddClick) image:IMAGE(@"screen3")];
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入品名或批号搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, 39)];
    _headView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.view addSubview:_headView];
    //品名
    UILabel *nameLbl = [[UILabel alloc]init];
    nameLbl.font = FONT(14);
    nameLbl.textColor = CD_Text33;
    nameLbl.textAlignment = NSTextAlignmentCenter;
    nameLbl.text = @"品名";
    [_headView addSubview:nameLbl];
    [nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_headView);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //条数
    UILabel *lineLbl = [[UILabel alloc]init];
    lineLbl.font = FONT(14);
    lineLbl.textColor = CD_Text33;
    lineLbl.textAlignment = NSTextAlignmentCenter;
    lineLbl.text = @"条数";
    [_headView addSubview:lineLbl];
    [lineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(nameLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //数量
    UILabel *numLbl = [[UILabel alloc]init];
    numLbl.font = FONT(14);
    numLbl.textColor = CD_Text33;
    numLbl.textAlignment = NSTextAlignmentCenter;
    numLbl.text = @"数量";
    [_headView addSubview:numLbl];
    [numLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(lineLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //单位
    UILabel *unitLbl = [[UILabel alloc]init];
    unitLbl.font = FONT(14);
    unitLbl.textColor = CD_Text33;
    unitLbl.textAlignment = NSTextAlignmentCenter;
    unitLbl.text = @"单位";
    [_headView addSubview:unitLbl];
    [unitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(numLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    //仓库
    UILabel *warehouseLbl = [[UILabel alloc]init];
    warehouseLbl.font = FONT(14);
    warehouseLbl.textColor = CD_Text33;
    warehouseLbl.textAlignment = NSTextAlignmentCenter;
    warehouseLbl.text = @"仓库";
    [_headView addSubview:warehouseLbl];
    [warehouseLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView);
        make.left.equalTo(unitLbl.mas_right);
        make.width.mas_offset(APPWidth *0.2);
        make.centerY.equalTo(_headView);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headView.bottom, APPWidth, APPHeight) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LZInventoryDetailCell class] forCellReuseIdentifier:@"LZInventoryDetailCell"];
    [self.view addSubview:_tableView];
    //    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.equalTo(self.view);
    //        make.top.equalTo(_headView);
    //    }];
    
    [self setupchooseView];
}

#pragma mark ---- 网络请求 ----
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"house_stock/house_search.do" param:param success:^(id response) {
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
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZInventoryDetailCell";
    LZInventoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LZInventoryDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _listsAry[indexPath.row];
    return cell;
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

- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self setupData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
