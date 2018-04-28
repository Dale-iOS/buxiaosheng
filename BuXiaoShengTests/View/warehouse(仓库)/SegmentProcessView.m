//
//  SegmentProcessView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/28.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  染色(分段选择器)

#import "SegmentProcessView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"

@interface SegmentProcessView ()<LZHTableViewDelegate>


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
///参考配方表备注
@property (nonatomic, strong) TextInputTextView *formulaRemarkTextView;
///保存按钮
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation SegmentProcessView
@synthesize mainTabelView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self settingUI];
    }
    return self;
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -64-80)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)settingUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self settingSectionOne];
    [self settingSectionTwo];
    [self settingSectionThree];
    //    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
    //保存按钮
    self.saveBtn = [UIButton new];
    self.saveBtn.frame = CGRectMake(0, APPHeight - 44-64-40, APPWidth, 44);
    self.saveBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    //    self.nextBtn.titleLabel.text = @"下一步";
    self.saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.saveBtn];
}

- (void)settingSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //生产商
    self.producersCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.producersCell.rightArrowImageVIew.hidden = NO;
    self.producersCell.titleLabel.text = @"生厂商";
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

- (void)settingSectionTwo
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //生产任务明细底图
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    
    //生产任务明细
    UILabel *dynamicLbel = [[UILabel alloc]init];
    dynamicLbel.textColor = CD_Text99;
    dynamicLbel.font = FONT(12);
    dynamicLbel.text = @"生产任务明细";
    [oneView addSubview:dynamicLbel];
    dynamicLbel.sd_layout
    .leftSpaceToView(oneView, 15)
    .widthIs(150)
    .centerYEqualToView(oneView)
    .heightIs(13);
    
    //    计划产成品
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.rightArrowImageVIew.hidden = NO;
    self.titleCell.titleLabel.text = @"计划产成品";
    self.titleCell.contentTF.placeholder = @"蛋炒饭";
    
    //颜色
    self.colorCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.colorCell.titleLabel.text = @"颜色";
    self.colorCell.contentTF.placeholder = @"无";
    
    //单位
    self.UnitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.UnitCell.titleLabel.text = @"单位";
    self.UnitCell.contentTF.placeholder = @"公斤";
    
    //    条数
    self.lineNumCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.lineNumCell.titleLabel.text = @"条数";
    self.lineNumCell.contentTF.placeholder = @"请输入数量条数";
    
    //    数量
    self.numCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.numCell.titleLabel.text = @"数量";
    self.numCell.contentTF.placeholder = @"请输入数量";
    
    //要求交期
    self.myTimeLimitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.myTimeLimitCell.rightArrowImageVIew.hidden = NO;
    self.myTimeLimitCell.titleLabel.text = @"要求交期";
    self.myTimeLimitCell.contentTF.placeholder = @"请输入要求交期";
    
    //厂家回复日期
    self.campanyTimeLimitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.campanyTimeLimitCell.rightArrowImageVIew.hidden = NO;
    self.campanyTimeLimitCell.titleLabel.text = @"厂家回复日期";
    self.campanyTimeLimitCell.contentTF.placeholder = @"请输入厂家回复日期";
    
    //备注
    self.remarkTextView = [[TextInputTextView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 79)];
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //    item.sectionRows = @[whiteView,self.sourceCell,self.orderNumCell,self.nameCell,self.unitCell];
    item.sectionRows = @[oneView,self.titleCell,self.colorCell,self.UnitCell,self.lineNumCell,self.numCell,self.myTimeLimitCell,self.campanyTimeLimitCell,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)settingSectionThree
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //计划用料明细
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 34)];
    
    //生产任务明细
    UILabel *dynamicLbel = [[UILabel alloc]init];
    dynamicLbel.textColor = CD_Text99;
    dynamicLbel.font = FONT(12);
    dynamicLbel.text = @"计划用料明细";
    [oneView addSubview:dynamicLbel];
    dynamicLbel.sd_layout
    .leftSpaceToView(oneView, 15)
    .widthIs(150)
    .centerYEqualToView(oneView)
    .heightIs(13);
    
    
    //参考配方表
    self.formulaCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.formulaCell.rightArrowImageVIew.hidden = NO;
    self.formulaCell.titleLabel.text = @"参考配方表";
    self.formulaCell.contentTF.placeholder = @"请输入参考配方表";
    
    //备注
    self.formulaRemarkTextView = [[TextInputTextView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 79)];
    self.formulaRemarkTextView.titleLabel.text = @"备注";
    self.formulaRemarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    //    item.sectionRows = @[whiteView,self.sourceCell,self.orderNumCell,self.nameCell,self.unitCell];
    item.sectionRows = @[oneView,self.formulaCell,self.formulaRemarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

#pragma mark -------- 点击事件 ----------
- (void)saveBtnOnClickAction
{
    NSLog(@"点击了 保存 按钮");
}

@end
