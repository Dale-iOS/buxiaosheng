//
//  LZChooseRecipeVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZChooseRecipeVC.h"
#import "LZRecipeModel.h"
#import "LZSearchBar.h"
#import "AddRecipeViewController.h"

@interface LZChooseRecipeVC ()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSArray <LZRecipeModel *> *recipes;
@property (nonatomic, assign) NSInteger typeNum;
@property (nonatomic, strong) LZSearchBar * searchBar;
@end

@implementation LZChooseRecipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setChooseType:(ChooseType)chooseType
{
    _chooseType = chooseType;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"选择配方表名称"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(addNavRightBtnClick) title:@"确认"];
    
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.placeholderColor = [UIColor colorWithHexString:@"#cccccc"];
    self.searchBar.textFieldBackgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
    
    UILabel *chooseLbl = [[UILabel alloc]init];
    chooseLbl.frame = CGRectMake(0, self.searchBar.bottom, APPWidth, 34);
    chooseLbl.text = @"    选择品名";
    chooseLbl.font = FONT(13);
    chooseLbl.textColor = CD_Text99;
    chooseLbl.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chooseLbl];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, chooseLbl.bottom, APPWidth, APPHeight -self.searchBar.height -chooseLbl.height) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

//配方列表
- (void)setupData
{
    switch (_chooseType) {
        case ChooseTypeFromDye:
            //来自染色
            _typeNum = 0;
            break;
        case ChooseTypeFromWeaVe:
            //来自织布
            _typeNum = 1;
            break;
            
        default:
            break;
    }
    
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"type":@(_typeNum)
                            };
    [BXSHttp requestGETWithAppURL:@"formula/list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!= 200) {
            return ;
        }
        self.recipes = [LZRecipeModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recipes.count;
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
    static NSString *cellID = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    LZRecipeModel *model = self.recipes[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.productName];
    
    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
    LZRecipeModel *model = self.recipes[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.productName];
    AddRecipeViewController *vc = [[AddRecipeViewController alloc]init];
    vc.id = model.id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ---- searchBarDelegate -----
- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchBar.text.length < 1) {
        return;
    }
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
                            @"searchName":self.searchBar.text,
                            @"type":@(_typeNum)
                            };
    [BXSHttp requestGETWithAppURL:@"formula/list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!= 200) {
            return ;
        }
        self.recipes = [LZRecipeModel LLMJParse:baseModel.data];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}


- (void)addNavRightBtnClick
{
    AddRecipeViewController *vc = [[AddRecipeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
