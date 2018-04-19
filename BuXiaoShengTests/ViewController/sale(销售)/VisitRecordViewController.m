//
//  VisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录

#import "VisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"

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


@end

@implementation VisitRecordViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight -44-64)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = YES;
    
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = YES;
    _wayCell.rightArrowImageVIew.hidden = NO;
    
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
//    self.resultView.userInteractionEnabled = YES;
    _resultView.textView.delegate = self;
    
    //假数据
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.text = @"李总";
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"当面拜访";
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.text = @"秋冬开发情况";
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.textView.placeholder = @"请输入告知仓库事项";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
