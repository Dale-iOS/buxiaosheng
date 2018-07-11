//
//  SegmentDyeingViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  织造（分段选择器）

#import "SegmentDyeingViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"



@interface SegmentDyeingViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///生产商
@property (nonatomic, strong) TextInputCell *producersCell;
///计划出料仓
@property (nonatomic, strong) TextInputCell *warehouseCell;
///计划产成品
@property (nonatomic, strong) TextInputCell *titleCell;
///颜色
@property (nonatomic, strong) TextInputCell *colorCell;
///单位
@property (nonatomic, strong) TextInputCell *UnitCell;
///条数
@property (nonatomic, strong) TextInputCell *lineNumCell;
///数量
@property (nonatomic, strong) TextInputCell *numCell;
///要求交期
@property (nonatomic, strong) TextInputCell *myTimeLimitCell;
///厂家回复交期
@property (nonatomic, strong) TextInputCell *campanyTimeLimitCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///参考配方表
@property (nonatomic, strong) TextInputCell *formulaCell;
///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation SegmentDyeingViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUI];
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

- (void)settingUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self settingSectionOne];
    //    [self setSectionTwo];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight - 44-64-100, APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.saveBtn];
}

- (void)settingSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //生产商
    self.producersCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.producersCell.rightArrowImageVIew.hidden = NO;
    self.producersCell.titleLabel.text = @"生产商";
    self.producersCell.contentTF.text = @"佛山编织成";
    
    //计划出料仓
    self.warehouseCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.warehouseCell.rightArrowImageVIew.hidden = NO;
    self.warehouseCell.titleLabel.text = @"计划出料仓";
    self.warehouseCell.contentTF.placeholder = @"请选择出料仓";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //    item.sectionRows = @[whiteView,self.sourceCell,self.orderNumCell,self.nameCell,self.unitCell];
    item.sectionRows = @[self.producersCell,self.warehouseCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];

    
}

#pragma mark -------- 点击事件 ----------
- (void)saveBtnOnClickAction
{
    NSLog(@"点击了 提交 按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
