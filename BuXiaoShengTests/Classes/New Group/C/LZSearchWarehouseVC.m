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

@interface LZSearchWarehouseVC ()<LZSearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)LZSearchBar*searchBar;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headView;
@end

@implementation LZSearchWarehouseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"搜索全库存"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenAddClick) image:IMAGE(@"screen3")];
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入品名或批号搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 39)];
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
        make.left.equalTo(nameLbl);
        make.width.mas_offset(APPWidth *0.2);
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
        make.left.equalTo(lineLbl);
        make.width.mas_offset(APPWidth *0.2);
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
        make.left.equalTo(numLbl);
        make.width.mas_offset(APPWidth *0.2);
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
        make.left.equalTo(unitLbl);
        make.width.mas_offset(APPWidth *0.2);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_headView.mas_bottom);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZInventoryDetailCell";
    LZInventoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LZInventoryDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)screenAddClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
