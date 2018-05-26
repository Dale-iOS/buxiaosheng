//
//  DyeRecipeView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  染色配方表

#import "DyeRecipeView.h"
#import "LZSearchBar.h"
#import "LZRecipeModel.h"

@interface DyeRecipeView()<UITableViewDelegate,UITableViewDataSource,LZSearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LZSearchBar * searchBar;
@property (nonatomic, strong) NSArray <LZRecipeModel *> *recipes;
@end

@implementation DyeRecipeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, 40, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.placeholderColor = [UIColor colorWithHexString:@"#cccccc"];
    self.searchBar.textFieldBackgroundColor = [UIColor colorWithHexString:@"#e6e6ed"];
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self addSubview:self.searchBar];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.searchBar.bottom, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self addSubview:_tableView];
}

#pragma mark ----- 网络请求 -----
//配方列表
- (void)setupData
{

    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"pageNo":@"1",
                            @"pageSize":@"15",
//                            @"searchName":self.searchBar.text,
                            @"type":@"0"
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

#pragma mark ----- tableviewdelegate -----
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
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
                            @"type":@"0"
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

@end
