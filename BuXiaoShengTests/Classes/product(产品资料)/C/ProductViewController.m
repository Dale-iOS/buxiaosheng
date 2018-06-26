//
//  ProductViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  产品资料页面

#import "ProductViewController.h"
#import "AddProductViewController.h"
#import "LZAlterProductDataVC.h"
#import "LZSearchBar.h"
#import "LLFactoryModel.h"
#import "LZChooseLabelVC.h"

@interface ProductViewController ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSArray <LLFactoryModel *> *products;

@end

@implementation ProductViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self setupData];
//}

- (void)setupUI
{

    self.navigationItem.titleView = [Utility navTitleView:@"产品资料"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationScreenClick) image:IMAGE(@"screen3")];
    
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入产品名称";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, APPWidth, APPHeight-self.searchBar.height-LLNavViewHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //底部按钮底图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPHeight -49, APPWidth, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //添加部门
    UIView *addView = [[UIView alloc]init];
    addView.userInteractionEnabled = YES;
    addView.frame = CGRectMake(0, 0, APPWidth, 49);
    addView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *addViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addViewAction)];
    [addView addGestureRecognizer:addViewTap];
    [bottomView addSubview:addView];
    
    UILabel *addDepLbl = [[UILabel alloc]init];
    addDepLbl.text = @"添加";
    addDepLbl.textColor = [UIColor colorWithHexString:@"#3d9bfa"];
    addDepLbl.font = FONT(14);
    addDepLbl.textAlignment = NSTextAlignmentCenter;
    [addView addSubview:addDepLbl];
    
    UIImageView *addDepIV = [[UIImageView alloc]init];
    addDepIV.backgroundColor = [UIColor clearColor];
    addDepIV.image = IMAGE(@"add2");
    [addView addSubview:addDepIV];
    
    addDepLbl.sd_layout
    .leftSpaceToView(addView, APPWidth/2 -20)
    .centerYEqualToView(addView)
    .widthIs(30)
    .heightIs(14);
    
    addDepIV.sd_layout
    .widthIs(17)
    .heightIs(17)
    .centerYEqualToView(addView)
    .leftSpaceToView(addDepLbl, 5);
}

#pragma mark ------- 网络请求 ------
- (void)setupData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"groupId":@"",
                             @"pageNo":@"1",
                             @"pageSize":@"15",
                             @"searchName":self.searchBar.text
                             };
    [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.products = [LLFactoryModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.products.count;
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
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.products[indexPath.row].name;
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFactoryModel *model = self.products[indexPath.row];
    LZAlterProductDataVC *vc = [[LZAlterProductDataVC alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ----- 点击事件 --------
//搜索
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self setupData];
}


- (void)navigationScreenClick
{
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchGroup;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
    [vc setLabelsDetailBlock:^(NSString *labelString, NSString *labelId) {
        
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"groupId":labelId,
                                 @"pageNo":@"1",
                                 @"pageSize":@"15",
                                 @"searchName":self.searchBar.text
                                 };
        [BXSHttp requestGETWithAppURL:@"product/list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            self.products = [LLFactoryModel LLMJParse:baseModel.data];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }];
}

- (void)addViewAction
{
    AddProductViewController *vc = [[AddProductViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
