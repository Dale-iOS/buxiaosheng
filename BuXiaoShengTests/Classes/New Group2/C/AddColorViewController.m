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
#import "LLColorRegistModel.h"
@interface AddColorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, strong) LZAddColorsModel *colorsmodel;
@property(nonatomic ,strong)UIView * headerView;
@property(nonatomic ,strong)UITextField * numColorFied;

@end

@implementation AddColorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)setupUI
{
    self.navigationItem.titleView =  [Utility navTitleView:self.type == 1 ?  @"修改颜色": @"添加颜色"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) title:@"确认"];
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStyleGrouped];
    [self.myTableView registerClass:[AddColorCell class] forCellReuseIdentifier:@"AddColorCellID"];
    self.myTableView .backgroundColor = LZHBackgroundColor;
    self.myTableView.sectionHeaderHeight = 10;
    self.myTableView.sectionFooterHeight = 0;
    self.myTableView .delegate = self;
    self.myTableView .dataSource = self;
    [self.view addSubview:self.myTableView];
    if (self.type != 1) {
         self.myTableView.tableHeaderView = self.headerView;
    }
   

}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModels.count;
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
    cell.model = self.dataModels[indexPath.row];
    cell.titleLbl.text = self.dataModels[indexPath.row].leftStr;
     cell.contentTF.placeholder = self.dataModels[indexPath.row].rightPlaceholder;
    if (self.dataModels[indexPath.row].rightStr) {
        cell.contentTF.text = self.dataModels[indexPath.row].rightStr;
    }
   
    return cell;
}

//确认按钮
- (void)selectornavRightBtnClick
{
    if (!self.dataModels.count) {
        return;
    }
    
    //强制键盘收起
    [self.view endEditing:YES];
    NSMutableArray * colorArr = [NSMutableArray array];
    [self.dataModels enumerateObjectsUsingBlock:^(LLColorRegistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.rightStr) {
            [colorArr addObject:obj];
        }
    }];
    if (!colorArr.count) {
        [LLHudTools showWithMessage:@"请至少填写一个颜色"];
        return;
    }
    if (self.ColorsArrayBlock) {
        self.ColorsArrayBlock(colorArr);
    }
    [self.navigationController popViewControllerAnimated:true];
//    if (muArray.count > 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else{
//        BXS_Alert(@"请至少填写一个颜色");
//    }
    
}
-(void)addColorBtnClick {
    
    if (![self.numColorFied.text integerValue]) {
        [LLHudTools showWithMessage:@"请输入要添加颜色的数量"];
        return;
    }
    static NSInteger lastNumCount = 0;
    for (NSInteger i = lastNumCount; i<[self.numColorFied.text integerValue] + lastNumCount ; i++) {
        LLColorRegistModel * model = [LLColorRegistModel new];
        model.leftStr = [NSString stringWithFormat:@"颜色%ld",i+1];
        model.rightPlaceholder = [NSString stringWithFormat:@"#%ld",i+1];
        [self.dataModels addObject:model];
    }
    [self.myTableView reloadData];
    lastNumCount = [self.numColorFied.text integerValue];
}

/// MARK: ---- 懒加载


-(UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 45)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UILabel *leftLable = [UILabel new];
        leftLable.textColor = [UIColor darkGrayColor];
        leftLable.font = [UIFont systemFontOfSize:15];
        leftLable.text = @"批量颜色";
        [_headerView addSubview:leftLable];
        [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_headerView).offset(15);
            make.centerY.equalTo(self->_headerView);
        }];
        
        UIButton * addColorBtn = [UIButton new];
        [addColorBtn addTarget:self action:@selector(addColorBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [addColorBtn setTitle:@"添 加" forState:UIControlStateNormal];
        addColorBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [addColorBtn setTitleColor:LZAppBlueColor forState:UIControlStateNormal];
        [_headerView addSubview:addColorBtn];
        [addColorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self->_headerView).offset(-15);
            make.centerY.equalTo(self->_headerView);
            make.width.mas_equalTo(45);
        }];
        self.numColorFied = [UITextField new];
        [_headerView addSubview:self.numColorFied];
        self.numColorFied.placeholder = @"请输入要添加颜色的数量";
        self.numColorFied.font = [UIFont systemFontOfSize:14];
        self.numColorFied.keyboardType = UIKeyboardTypeNumberPad;
        self.numColorFied.textAlignment = NSTextAlignmentCenter;
        [self.numColorFied mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftLable.mas_right).offset(5);
            make.centerY.equalTo(leftLable);
            make.width.mas_equalTo(APPWidth - 30 - 45 - 5 -80);
            make.height.mas_equalTo(35);
        }];
    }
    return _headerView;
}

-(NSMutableArray<LLColorRegistModel *> *)dataModels {
    if (!_dataModels) {
        _dataModels = [NSMutableArray array];
    }
    return _dataModels;
}


@end
