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
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
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

    NSMutableArray *muArray = [NSMutableArray array];
    NSMutableArray *muArray1 = [NSMutableArray array];
    for (int i = 0 ; i < 8; i++) {
        if (i == 0 && self.colorsmodel.color0.length >0) {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color0 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color0];
        }
        else if (i == 1 && self.colorsmodel.color1.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color1 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color1];
        }
        else if (i == 2 && self.colorsmodel.color2.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color2 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color2];
        }
        else if (i == 3 && self.colorsmodel.color3.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color3 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color3];
        }
        else if (i == 4 && self.colorsmodel.color4.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color4 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color4];
        }
        else if (i == 5 && self.colorsmodel.color5.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color5 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color5];
        }
        else if (i == 6 && self.colorsmodel.color6.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color6 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color6];
        }
        else if (i == 7 && self.colorsmodel.color7.length >0)
        {
            NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"name"] = self.colorsmodel.color7 ? : @"";
            [muArray addObject:param];
            [muArray1 addObject:self.colorsmodel.color7];
        }

    }
    

    if (self.ColorsArrayBlock) {
        self.ColorsArrayBlock(muArray, muArray1);
    }
    
    if (muArray.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        BXS_Alert(@"请至少填写一个颜色");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
