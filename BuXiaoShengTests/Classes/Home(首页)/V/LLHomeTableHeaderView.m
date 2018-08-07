//
//  LLHomeTableHeaderView.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLHomeTableHeaderView.h"
#import "LZHTableView.h"
#import "FinancialCollectionViewCell.h"
#import "SaleViewController.h"
#import "SGPagingView.h"
#import "NowDayViewController.h"
#import "NowMonthViewController.h"
#import "NowQuarterViewController.h"
#import "NowYearViewController.h"
//#import "AAChartKit.h"
#import "SetHomeViewController.h"
#import "LZHomeModel.h"
#import "FinancialCollectionViewCell.h"
#import "SaleViewController.h"
#import "FinancialViewController.h"
#import "WarehouseHomeViewController.h"
#import "LLTurnoverChatView.h"
@interface LLHomeTableHeaderView()<SGPageTitleViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LZHTableViewDelegate>
@property (nonatomic, strong) UICollectionView *collectView;
//@property (strong, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///折线图

@property (nonatomic, strong) SGPageContentView *pageContentView;
@property(nonatomic ,strong)LLTurnoverChatView * chartView;
@end
@implementation LLHomeTableHeaderView

-(void)setButtons:(NSArray<LZHomeModel *> *)buttons {
    _buttons = buttons;
    if (buttons.count < 4) {
        [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(110);
        }];

    }else {
        [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(220);
        }];
    }
    [self layoutIfNeeded];
    [self.collectView reloadData];
}
-(void)setChartModels:(NSArray<LLTurnoverListModel *> *)chartModels {
    _chartModels = chartModels;
     self.chartView.chartData = chartModels;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
   
}


-(void)setupUI {
    [self setSectionOne];
    [self setSectionTwo];
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = LZHBackgroundColor;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 100);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    flow.sectionInset = UIEdgeInsetsMake(0, APPWidth *0.05, 0,APPWidth *0.05);//上左下右
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
    [self addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(headerView.mas_bottom).offset(15);
        make.height.mas_equalTo(110);
    }];
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];

}

- (void)setSectionTwo
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = LZHBackgroundColor;
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.collectView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    self.chartView = [[LLTurnoverChatView alloc]init];
    ////设置图表视图的内容高度(默认 contentHeight 和 AAChartView 的高度相同)
    //self.aaChartView.contentHeight = self.view.frame.size.height-250;
    [self addSubview:self.chartView];
    [ self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(headerView.mas_bottom);
        make.height.mas_equalTo(260);
    }];
    
    UIView *sectionThreeLineView = [[UIView alloc]init];
    sectionThreeLineView.backgroundColor = LZHBackgroundColor;
    [self addSubview:sectionThreeLineView];
    
    [sectionThreeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.chartView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
    NSArray *titleArr = @[@"本日", @"本月", @"季度", @"全年"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    UIView * titleContentView = [UIView new];
    [self addSubview:titleContentView];
    [titleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(sectionThreeLineView.mas_bottom);
        make.height.mas_equalTo(45);
    }];
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, APPWidth, 45) delegate:self titleNames:titleArr configure:configure];
    [titleContentView addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;

    
    UIView *sectionFourLineView = [[UIView alloc]init];
    sectionFourLineView.backgroundColor = LZHBackgroundColor;
    [self addSubview:sectionFourLineView];
    [sectionFourLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo( titleContentView.mas_bottom);
        make.height.mas_equalTo(10);
    }];
    
}

#pragma  mark -------- SGPageTitleViewDelegate --------
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    self.pageTitleblock(selectedIndex);
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

#pragma mark -------- collectionView --------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController * homeVc = [BXSTools viewWithViewController:self];
    LZHomeModel *model = [LZHomeModel LLMJParse:self.buttons[indexPath.row]];
    
    if ([model.paramsIos isEqualToString:@"sales"]) {
        
        SaleViewController *vc = [[SaleViewController alloc]init];
        vc.buttonId = model.id;
        [homeVc.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"finance"])
    {
        FinancialViewController *vc = [[FinancialViewController alloc]init];
        vc.buttonId = model.id;
        [homeVc.navigationController pushViewController:vc animated:YES];
        
    }
    if ([model.paramsIos isEqualToString:@"warehouse"])
    {
        WarehouseHomeViewController *vc = [[WarehouseHomeViewController alloc]init];
        vc.buttonId = model.id;
        [homeVc.navigationController pushViewController:vc animated:YES];
    }
    
    
}


//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.buttons.count;
}


@end
