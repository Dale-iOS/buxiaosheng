//
//  FinancialHomeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "FinancialHomeViewController.h"
#import "LZHHomeMenuCell.h"
#import "GetPlistArray.h"

@interface FinancialHomeViewController ()<UITableViewDelegate,UITableViewDataSource,LZHHomeMenuCellDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *menuArray;
@end

@implementation FinancialHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //注意一定要给数组初始化，养成习惯少走弯路。
    self.menuArray =  [GetPlistArray arrayWithString:@"menuData.plist"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 4) {
        return 4;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 180;
    }
    else
    {
        return 70;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        LZHHomeMenuCell *cell = [LZHHomeMenuCell cellWithTableView:tableView menuArray:self.menuArray];
        cell.delegate = self;
        return cell;
    }else
    {
        static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        return cell;
    }
    
}

#pragma mark - JFHomeMenuCellDelegate
-(void)homeMenuCellClick:(long )sender{
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
