//
//  VisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录页面

#import "VisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitRecordVC.h"
#import "LZPickerView.h"

@interface VisitRecordViewController ()<LZHTableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///拜访对象
@property (nonatomic, strong) TextInputCell *objectCell;
///拜访方式
@property (nonatomic, strong) TextInputCell *wayCell;
///主要事宜
@property (nonatomic, strong) TextInputCell *mainCell;
///拜访结果
@property (nonatomic, strong) TextInputTextView *resultView;

///备注
@property (nonatomic, strong) TextInputTextView *remarkView;

///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;

@end

@implementation VisitRecordViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenClick) image:IMAGE(@"list")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight -44-64)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //拜访记录
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = YES;
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.placeholder = @"请输入拜访对象";
    
    //拜访记录
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = YES;
    _wayCell.rightArrowImageVIew.hidden = NO;
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"请选择拜访方式";
    _wayCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWayClick)];
    [_wayCell addGestureRecognizer:tap];
    
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
//    self.resultView.userInteractionEnabled = YES;
    _resultView.textView.delegate = self;
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.textView.placeholder = @"请输入拜访结果";

    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_objectCell,_wayCell,_mainCell,_resultView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];

}

- (void)setSectionTwo
{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _remarkView = [[TextInputTextView alloc]init];
    _remarkView.frame = CGRectMake(0, 0, APPWidth, 80);
    _remarkView.textView.delegate = self;
    
    _remarkView.titleLabel.text = @"备注";
    _remarkView.textView.placeholder = @"请输入告知仓库事项";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_remarkView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupUI
{
    _typeAry = [NSArray arrayWithObjects:@"当面拜访",@"电话拜访",@"聊天软件拜访",@"其他方式拜访",nil];
    
    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self.view addSubview:self.mainTabelView];
    
    [self setSectionOne];
    [self setSectionTwo];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    self.commitBtn = [UIButton new];
    self.commitBtn.frame = CGRectMake(0, APPHeight -44, APPWidth, 44);
    self.commitBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.commitBtn];
}


#pragma mark ------ 点击事件 --------
- (void)commitBtnOnClickAction
{
    NSLog(@"commitBtnOnClickAction");
}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapWayClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_typeAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//        weakSelf.principalCell.contentTF.text = compoentString;
//        NSInteger row = [titileString integerValue];
//        weakSelf.priceipalId = weakSelf.principalIdAry[row];
        self.wayCell.contentTF.text = compoentString;
    };
    
    [self.view addSubview:pickerView];
}

//跳转到拜访记录列表
- (void)screenClick{
    LZVisitRecordVC *vc = [[LZVisitRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
