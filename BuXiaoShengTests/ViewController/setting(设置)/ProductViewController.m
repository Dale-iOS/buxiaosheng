//
//  ProductViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ProductViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "UIButton+EdgeInsets.h"

@interface ProductViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///品名
@property (nonatomic, strong) TextInputCell *titleCell;
///分组
@property (nonatomic, strong) TextInputCell *groupCell;
///默认入库方式
@property (nonatomic, strong) TextInputCell *defaultJoinCell;
///单位
@property (nonatomic, strong) TextInputCell *unitCell;
///量化
@property (nonatomic, strong) TextInputCell *quantizationCell;

///别名
@property (nonatomic, strong) TextInputCell *nicknameCell;
///销售大货价格
@property (nonatomic, strong) TextInputCell *bigPriceCell;
///销售散剪价
@property (nonatomic, strong) TextInputCell *dispersePriceCell;
///订单的单条数量
@property (nonatomic, strong) TextInputCell *oneOrderNumCell;

///添加颜色
@property (nonatomic, strong) TextInputCell *addColorCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;

///状态
@property (nonatomic, strong) TextInputCell *stateCell;

@end

@implementation ProductViewController
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
    self.navigationItem.titleView = [Utility navTitleView:@"添加产品资料"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    [self setupSectionTwo];
    [self setupSectionThree];
    [self setupSectionFour];
    self.mainTabelView.dataSoure = self.datasource;
    
}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"品名";
    self.titleCell.contentTF.placeholder = @"请输入品名";
    
    self.groupCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.groupCell.rightArrowImageVIew.hidden = NO;
    self.groupCell.titleLabel.text = @"分组";
    self.groupCell.contentTF.placeholder = @"请选择分组";
    
    self.defaultJoinCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.defaultJoinCell.rightArrowImageVIew.hidden = NO;
    self.defaultJoinCell.titleLabel.text = @"默认入库方式";
    self.defaultJoinCell.contentTF.placeholder = @"请选择默认入库方式";
    
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.unitCell.rightArrowImageVIew.hidden = NO;
    self.unitCell.titleLabel.text = @"单位";
    self.unitCell.contentTF.placeholder = @"请选择单位";
    
    self.quantizationCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.quantizationCell.titleLabel.text = @"量化";
    self.quantizationCell.contentTF.placeholder = @"请输入量化值";
    
    UIView *unitView = [[UIView alloc]init];
    unitView.backgroundColor = [UIColor yellowColor];
    [self.quantizationCell addSubview:unitView];
    unitView.sd_layout
    .rightSpaceToView(self.quantizationCell, 15)
    .widthIs(100)
    .heightIs(49)
    .topSpaceToView(self.quantizationCell, 0);
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.titleLabel.font = FONT(15);
    [leftBtn setTitleColor:CD_Text99 forState:UIControlStateNormal];
    [leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    [leftBtn setTitle:@"米" forState:UIControlStateNormal];
    [leftBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:10];
    [unitView addSubview:leftBtn];
    leftBtn.sd_layout
    .leftSpaceToView(unitView, 0)
    .centerYEqualToView(unitView)
    .widthIs(50)
    .heightIs(17);
    
    //    //量化
    //    UIView *quantizationView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    //    UILabel *label = [[UILabel alloc]init];
    //    label.text = @"量化";
    //    label.textColor = CD_Text33;
    //    label.font = FONT(14);
    //    [quantizationView addSubview:label];
    //    label.sd_layout
    //    .leftSpaceToView(quantizationView, 15)
    //    .widthIs(90)
    //    .heightIs(15)
    //    .centerYEqualToView(quantizationView);
    
    
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell,self.quantizationCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionTwo
{
    self.nicknameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.nicknameCell.titleLabel.text = @"别名";
    self.nicknameCell.contentTF.placeholder = @"请输入别名";
    
    self.bigPriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.bigPriceCell.titleLabel.text = @"销售大货价";
    self.bigPriceCell.contentTF.placeholder = @"可选填";
    
    self.dispersePriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.dispersePriceCell.titleLabel.text = @"销售散剪价";
    self.dispersePriceCell.contentTF.placeholder = @"可选填";
    
    self.oneOrderNumCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.oneOrderNumCell.titleLabel.text = @"订单的单条数量";
    self.oneOrderNumCell.contentTF.placeholder = @"请输入单挑数量";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.nicknameCell,self.bigPriceCell,self.dispersePriceCell,self.oneOrderNumCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionThree
{
    self.addColorCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.addColorCell.rightArrowImageVIew.hidden = NO;
    self.addColorCell.titleLabel.text = @"添加颜色";
    self.addColorCell.contentTF.placeholder = @"请选择颜色";
    
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 80);
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.addColorCell,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionFour
{
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择颜色";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)selectornavRightBtnClick
{
    NSLog(@"selectornavRightBtnClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
