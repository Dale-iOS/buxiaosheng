//
//  AddBankViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加银行页面（取消默认和所属分店）

#import "AddBankViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "DefaultBankCell.h"

@interface AddBankViewController ()<LZHTableViewDelegate>

@property (nonatomic,assign)BOOL isdefault;
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///账户类型
@property (nonatomic, strong) TextInputCell *typeCell;
///账号
@property (nonatomic, strong) TextInputCell *accountCell;
///现金银行名称
@property (nonatomic, strong) TextInputCell *bankTitleCell;
///所属分店
@property (nonatomic, strong) TextInputCell *belongStoreCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///设为默认
@property (nonatomic, strong) DefaultBankCell *defaultCell;

@end

@implementation AddBankViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];

}


- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加银行"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
//    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
    self.typeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.typeCell.rightArrowImageVIew.hidden = NO;
    self.typeCell.titleLabel.text = @"账户类型";
    self.typeCell.contentTF.placeholder = @"请选择账户类型";
    
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
//    self.accountCell.rightArrowImageVIew.hidden = NO;
    self.accountCell.titleLabel.text = @"账号";
    self.accountCell.contentTF.placeholder = @"请填写银行卡号";
    
    self.bankTitleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
//    self.bankTitleCell.rightArrowImageVIew.hidden = NO;
    self.bankTitleCell.titleLabel.text = @"现金银行名称";
    self.bankTitleCell.contentTF.placeholder = @"请填写银行名称";
    
    self.belongStoreCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.belongStoreCell.rightArrowImageVIew.hidden = NO;
    self.belongStoreCell.titleLabel.text = @"所属分店";
    self.belongStoreCell.contentTF.placeholder = @"请选择所属分店";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择类型";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.typeCell,self.accountCell,self.bankTitleCell,self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    self.defaultCell = [[DefaultBankCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.defaultCell.selectImageView.image = IMAGE(@"noSelect");
    _isdefault = NO;
    UITapGestureRecognizer *defaultCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(defaultCellAction)];
    [self.defaultCell addGestureRecognizer:defaultCellTap];
 
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.defaultCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)saveBtnClick
{
    NSLog(@"saveBtnClick");
}

- (void)defaultCellAction
{
    NSLog(@"defaultCellAction");
    
    _isdefault = !_isdefault;
    
    if (!_isdefault) {
        self.defaultCell.selectImageView.image = IMAGE(@"noSelect");
    }else
    {
        self.defaultCell.selectImageView.image = IMAGE(@"yesSelect");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
