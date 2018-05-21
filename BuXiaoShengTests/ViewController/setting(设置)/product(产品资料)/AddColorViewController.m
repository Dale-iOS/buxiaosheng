//
//  AddColorViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加颜色页面

#import "AddColorViewController.h"
#import "AddColorCell.h"
#import "LZAddColorsModel.h"

@interface AddColorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, strong) LZAddColorsModel *colorsmodel;
@end

@implementation AddColorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加颜色"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStyleGrouped];
    self.myTableView .backgroundColor = LZHBackgroundColor;
    self.myTableView.sectionHeaderHeight = 10;
    self.myTableView.sectionFooterHeight = 0;
    self.myTableView .delegate = self;
    self.myTableView .dataSource = self;
    [self.view addSubview:self.myTableView];

}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView.sectionHeaderHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AddColorCellID";
    AddColorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[AddColorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        
        self.colorsmodel = [[LZAddColorsModel alloc]init];
        if (indexPath.row == 0) {
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color0 = result;
            }];
        }else if (indexPath.row == 1){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color1 = result;
            }];
        }else if (indexPath.row == 2){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color2 = result;
            }];
        }else if (indexPath.row == 3){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color3 = result;
            }];
        }else if (indexPath.row == 4){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color4 = result;
            }];
        }else if (indexPath.row == 5){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color5 = result;
            }];
        }else if (indexPath.row == 6){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color6 = result;
            }];
        }else if (indexPath.row == 7){
            [cell setCellTitle:[NSString stringWithFormat:@"颜色%zd",indexPath.row %4 +1] WithReturnBlock:^(NSString *result) {
                self.colorsmodel.color7 = result;
            }];
        }
        
    }

    return cell;
}

//确认按钮
- (void)selectornavRightBtnClick
{
    NSLog(@"selectornavRightBtnClick");
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
