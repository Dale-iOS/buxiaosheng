//
//  LZAddRecipeVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改配方材料页面

#import "LZAddRecipeVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "LZRecipeModel.h"
#import "LZRecipeCell.h"

@interface LZAddRecipeVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UITableView *tableView;
///配方名称
@property(nonatomic,strong)TextInputCell *nameCell;
///单位
@property(nonatomic,strong)TextInputCell *unitCell;
@end

@implementation LZAddRecipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupHeaderViewDetail];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"修改配方材料"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    //初始化tableview头部视图
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 108.5)];
    _headerView.backgroundColor = LZHBackgroundColor;
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 10, APPWidth, 49)];
    self.nameCell.titleLabel.text = @"配方名称";
    self.nameCell.contentTF.placeholder = @"请输入配方名称";
    self.nameCell.backgroundColor = [UIColor whiteColor];
    self.nameCell.contentTF.enabled = NO;
    [_headerView addSubview:self.nameCell];
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.nameCell.bottom +0.5, APPWidth, 49)];
    self.unitCell.titleLabel.text = @"单位";
    self.unitCell.contentTF.placeholder = @"请输入单位";
    self.unitCell.backgroundColor = [UIColor whiteColor];
    self.unitCell.contentTF.enabled = NO;
    [_headerView addSubview:self.unitCell];
    
    //初始化tableview尾部视图
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    _footerView.backgroundColor = [UIColor whiteColor];
    UIButton *addBtn = [[UIButton alloc]init];
    [addBtn setBackgroundImage:IMAGE(@"addRecipe") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_footerView);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = _footerView;
    _tableView.backgroundColor = LZHBackgroundColor;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(self.view);
    }];
}

#pragma mark ---- 网络请求 ----
- (void)setupHeaderViewDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"id":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"formula/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        LZRecipeModel *model = [LZRecipeModel LLMJParse:baseModel.data];
        self.nameCell.contentTF.text = model.productName;
        self.unitCell.contentTF.text = model.unitName;
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 307;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LZRecipeCellId";
    LZRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[LZRecipeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row <3) {
    //        [LLHudTools showWithMessage:@"默认支付方式不可编辑~"];
    //        return;
    //    }
//    AlterBankViewController *vc = [[AlterBankViewController alloc]init];
//    vc.isFormBankAdd = false;
//    vc.id = self.banks[indexPath.row].id;
//    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---- 点击事件 ----
//导航栏右上角确认按钮事件
- (void)selectornavRightBtnClick{
    
}

//新增配方按钮事件
- (void)addBtnClick{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
