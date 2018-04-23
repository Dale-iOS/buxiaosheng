//
//  ProducersViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/23.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  生产商（付款单）

#import "ProducersViewController.h"
#import "LZHTableView.h"
#import "ArrearsNameTextInputCell.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"

@interface ProducersViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///供货商
@property (nonatomic, strong) ArrearsNameTextInputCell *titleCell;
///付款金额
@property (nonatomic, strong) TextInputCell *priceCell;
///联系人信息
@property (nonatomic, strong) TextInputCell *contactCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation ProducersViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    //供货商
    self.titleCell = [[ArrearsNameTextInputCell alloc]init];
    self.titleCell.frame = CGRectMake(0, 0, APPWidth, 75);
    self.titleCell.titleLabel.text = @"供货商";
    self.titleCell.beforeLabel.text = @"前欠款:￥2500";
    self.titleCell.contentTF.text = @"阿青布行";
    
    //付款金额
    self.priceCell = [[TextInputCell alloc]init];
    self.priceCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.priceCell.titleLabel.text = @"付款金额";
    self.priceCell.contentTF.placeholder = @"请输入金额";
    
    //联系人信息
    self.contactCell = [[TextInputCell alloc]init];
    self.contactCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.contactCell.titleLabel.text = @"联系人信息";
    self.contactCell.contentTF.text = @"阿青布行";
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.priceCell,self.contactCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setupUI
{
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight -64-44-44 , APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.saveBtn];
}

#pragma mark ------ 点击事件 ------
- (void)saveBtnOnClickAction
{
    NSLog(@"点击了保存按钮");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
