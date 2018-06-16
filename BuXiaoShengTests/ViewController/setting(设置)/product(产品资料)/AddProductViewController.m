//
//  AddProductViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加产品资料页面

#import "AddProductViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "UIButton+EdgeInsets.h"
#import "AddColorViewController.h"

@interface AddProductViewController ()<LZHTableViewDelegate>
{
    NSArray *_array;
}
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
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,assign) BOOL isSelLeftBtn;
@property (nonatomic,assign) BOOL isSelrightBtn;

///别名
@property (nonatomic, strong) TextInputCell *nicknameCell;
///销售大货价格
@property (nonatomic, strong) TextInputCell *bigPriceCell;
///销售散剪价
@property (nonatomic, strong) TextInputCell *dispersePriceCell;


///添加颜色
@property (nonatomic, strong) TextInputCell *addColorCell;
///备注
//@property (nonatomic, strong) TextInputTextView *remarkTextView;

///状态
@property (nonatomic, strong) TextInputCell *stateCell;

@end

@implementation AddProductViewController
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
        tableView.delegate = self;
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
    unitView.backgroundColor = [UIColor clearColor];
    [self.quantizationCell addSubview:unitView];
    unitView.sd_layout
    .rightSpaceToView(self.quantizationCell, 15)
    .widthIs(95)
    .heightIs(49)
    .topSpaceToView(self.quantizationCell, 0);
    
    self.leftBtn = [UIButton new];
    self.leftBtn.titleLabel.font = FONT(15);
    [self.leftBtn setTitleColor:CD_Text99 forState:UIControlStateNormal];
    [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    [self.leftBtn setTitle:@"米" forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:4];
    [unitView addSubview:self.leftBtn];
    self.leftBtn.sd_layout
    .leftSpaceToView(unitView, 0)
    .centerYEqualToView(unitView)
    .widthIs(50)
    .heightIs(17);
    
    self.rightBtn = [UIButton new];
    self.rightBtn.titleLabel.font = FONT(15);
    [self.rightBtn setTitleColor:CD_Text99 forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"码" forState:UIControlStateNormal];
    [self.rightBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageLeft imageTitlespace:4];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [unitView addSubview:self.rightBtn];
    self.rightBtn.sd_layout
    .rightSpaceToView(unitView, 0)
    .centerYEqualToView(unitView)
    .widthIs(40)
    .heightIs(17);
    
    _isSelLeftBtn = NO;
    _isSelrightBtn = NO;
    
    
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
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.nicknameCell,self.bigPriceCell,self.dispersePriceCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionThree
{
    
    //添加颜色
    UIView *addColorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    addColorView.backgroundColor = [UIColor whiteColor];
    addColorView.userInteractionEnabled = YES;
     UITapGestureRecognizer *addColorCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addColorCellTapAction)];
    [addColorView addGestureRecognizer:addColorCellTap];
    UILabel *label = [[UILabel alloc]init];
    label.text = @"添加颜色";
    label.font = FONT(14);
    label.textColor = CD_Text33;
    [addColorView addSubview:label];
    label.sd_layout
    .leftSpaceToView(addColorView, 15)
    .centerYEqualToView(addColorView)
    .widthIs(60)
    .heightIs(15);
    UIImageView *addIM = [[UIImageView alloc]init];
    addIM.image = IMAGE(@"add1");
    [addColorView addSubview:addIM];
    addIM.sd_layout
    .widthIs(22)
    .heightIs(22)
    .centerYEqualToView(addColorView)
    .rightSpaceToView(addColorView, 15);
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = LZHBackgroundColor;
    [addColorView addSubview:lineView];
    lineView.sd_layout
    .widthIs(APPWidth)
    .heightIs(1)
    .leftSpaceToView(addColorView, 0)
    .bottomSpaceToView(addColorView, 0);
    
    
    //返回的颜色
    UIView *colorsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.001)];

    _array = [NSArray array];
    
    int col = 4;
    
    int margin = 10;
    
    for (int i = 0; i <_array.count ; i++) {
        int page = i/col;
        int index = i%col;
        
        UILabel *label = [[UILabel alloc]init];
        
        
        if (APPWidth > IPHONE6PLUS_WIDTH) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750),(APPWidth *90 / 750)*5/14)];
        }else{
            
            label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750),(APPWidth *140 / 750)*5/14)];
        }
        
        //四个字太长，需要把框设长点
        if (i==7 && IPHONE5) {
            label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750 +10),(APPWidth *140 / 750)*5/14)];
        }
        
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 1;
        
        label.text = _array[i];
        label.textAlignment = NSTextAlignmentCenter;
        
        colorsView.frame = CGRectMake(0, 0, APPWidth, (APPWidth *90 / 750)*5/14 +40*page + 20);
        [colorsView addSubview:label];
    }

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[addColorView,colorsView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setupSectionFour
{
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择状态";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

#pragma mark ----- 点击事件 ------
- (void)leftBtnClick
{
    NSLog(@"leftBtnClick");
    
    _isSelLeftBtn = YES;
    
    
    [self.leftBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
}

- (void)rightBtnClick
{
    NSLog(@"rightBtnClick");
    
    _isSelrightBtn = YES;
    
    
    [self.rightBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
}

- (void)addColorCellTapAction
{
    
    AddColorViewController *vc = [[AddColorViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
   
    [vc setColorsArrayBlock:^(NSMutableArray *muParamArray, NSMutableArray *muColosArray) {

        //临时添加数据
        NSMutableArray *tempMuArray = [_array mutableCopy];
        [tempMuArray addObjectsFromArray:muColosArray];
        _array = [tempMuArray copy];
        
        //添加颜色
        UIView *addColorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
        addColorView.backgroundColor = [UIColor whiteColor];
        addColorView.userInteractionEnabled = YES;
        UITapGestureRecognizer *addColorCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addColorCellTapAction)];
        [addColorView addGestureRecognizer:addColorCellTap];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"添加颜色";
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [addColorView addSubview:label];
        label.sd_layout
        .leftSpaceToView(addColorView, 15)
        .centerYEqualToView(addColorView)
        .widthIs(60)
        .heightIs(15);
        UIImageView *addIM = [[UIImageView alloc]init];
        addIM.image = IMAGE(@"add1");
        [addColorView addSubview:addIM];
        addIM.sd_layout
        .widthIs(22)
        .heightIs(22)
        .centerYEqualToView(addColorView)
        .rightSpaceToView(addColorView, 15);
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = LZHBackgroundColor;
        [addColorView addSubview:lineView];
        lineView.sd_layout
        .widthIs(APPWidth)
        .heightIs(1)
        .leftSpaceToView(addColorView, 0)
        .bottomSpaceToView(addColorView, 0);
        
        //返回的颜色
        UIView *colorsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 200)];
        
        int col = 4;
        
        int margin = 10;
        
        for (int i = 0; i <_array.count ; i++) {
            int page = i/col;
            int index = i%col;
            
            UILabel *label = [[UILabel alloc]init];

            if (APPWidth > IPHONE6PLUS_WIDTH) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750),(APPWidth *90 / 750)*5/14)];
            }else{
                
                label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750),(APPWidth *140 / 750)*5/14)];
            }
            
            if (i==7 && IPHONE5) {
                label = [[UILabel alloc]initWithFrame:CGRectMake(margin + index*(APPWidth - (col + 1)*margin)/col + margin*index,40*page + 5,(APPWidth *140 / 750 +10),(APPWidth *140 / 750)*5/14)];
            }
            
            label.layer.borderColor = [UIColor blackColor].CGColor;
            label.layer.borderWidth = 1;
            
            label.text = _array[i];
            label.textAlignment = NSTextAlignmentCenter;
            
            colorsView.frame = CGRectMake(0, 0, APPWidth, (APPWidth *90 / 750)*5/14 +40*page + 20);
            [colorsView addSubview:label];
        }
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
        headerView.backgroundColor = LZHBackgroundColor;
        
        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
        item.sectionRows = @[addColorView,colorsView];
        item.canSelected = NO;
        item.sectionView = headerView;
        
        
        [self.datasource replaceObjectAtIndex:2 withObject:item];
        [self.mainTabelView reloadData];

    }];

}

- (void)selectornavRightBtnClick
{
    NSLog(@"selectornavRightBtnClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
