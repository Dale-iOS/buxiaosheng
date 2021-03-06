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
#import "BRPickerView.h"
#import "LZChooseLabelVC.h"
#import "ToolsCollectionVC.h"
#import "LLColorRegistModel.h"
@interface AddProductViewController ()<LZHTableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    NSArray *_array;
    NSString *_groupId;//分组id
    NSString *_unitId;//单位id
    
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
   
}
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,copy)NSString *groupId;//分组id
@property (nonatomic,copy)NSString *unitId;//单位id
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///品名
@property (nonatomic, strong) TextInputCell *titleCell;
///分组
@property (nonatomic, strong) TextInputCell *groupCell;
///入库方式
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
///成分
@property (nonatomic, strong) TextInputCell *constituentCell;
///幅宽
@property (nonatomic, strong) TextInputCell *breadthCell;
///克重
@property (nonatomic, strong) TextInputCell *weightCell;

///添加颜色
@property (nonatomic, strong) TextInputCell *addColorCell;
@property(nonatomic,strong)NSMutableArray <LLColorRegistModel*> *colorArray;//最后网络请求的颜色数据
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///备注2
@property (nonatomic, strong) TextInputTextView *remarkTextView2;
///上传图片的标题
@property(nonatomic,strong) UILabel *textLbl;
///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;
@property(nonatomic,strong)NSString *typeStr;

@property(nonatomic ,copy)NSString * imgURLs;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
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
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) title:@"确认"];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    [self setupSectionTwo];
    [self setupSectionThree];
    [self setupSectionFour];
    [self setupSectionFive];
    [self setupSectionSix];
    [self setSectionSeven];
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
    self.groupCell.contentTF.enabled = NO;
    UITapGestureRecognizer *groupCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(groupCellTapClick)];
    [self.groupCell addGestureRecognizer:groupCellTap];
    
    
    self.defaultJoinCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.defaultJoinCell.rightArrowImageVIew.hidden = NO;
    self.defaultJoinCell.contentTF.enabled = NO;
    self.defaultJoinCell.titleLabel.text = @"入库方式";
    self.defaultJoinCell.contentTF.placeholder = @"请选择入库方式";
    UITapGestureRecognizer *defaultJoinCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(defaultJoinCellTapClick)];
    [self.defaultJoinCell addGestureRecognizer:defaultJoinCellTap];
    
    
    self.unitCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.unitCell.rightArrowImageVIew.hidden = NO;
    self.unitCell.titleLabel.text = @"单位";
    self.unitCell.contentTF.enabled = NO;
    self.unitCell.contentTF.placeholder = @"请选择单位";
    UITapGestureRecognizer *unitCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(unitCellTapClick)];
    [self.unitCell addGestureRecognizer:unitCellTap];
    
    self.quantizationCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.quantizationCell.titleLabel.text = @"量化";
    self.quantizationCell.contentTF.placeholder = @"请输入量化值";
    self.quantizationCell.contentTF.sd_layout
    .topEqualToView(self.quantizationCell)
    .leftSpaceToView(self.quantizationCell.titleLabel, 50)
    .heightRatioToView(self.quantizationCell, 1)
    .widthIs(LZHScale_WIDTH(180));
    
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
    item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell];
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
    self.bigPriceCell.contentTF.placeholder = @"请输入大货价";
    self.bigPriceCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.dispersePriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.dispersePriceCell.titleLabel.text = @"销售散剪价";
    self.dispersePriceCell.contentTF.placeholder = @"请输入销售散剪价";
    self.dispersePriceCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.constituentCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.constituentCell.titleLabel.text = @"成分";
    self.constituentCell.contentTF.placeholder = @"请输入成分";
    
    self.breadthCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.breadthCell.titleLabel.text = @"幅宽";
    self.breadthCell.contentTF.placeholder = @"请输入幅宽";
    
    self.weightCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.weightCell.titleLabel.text = @"克重";
    self.weightCell.contentTF.placeholder = @"请输入克重";
    self.weightCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.nicknameCell,self.bigPriceCell,self.dispersePriceCell,self.constituentCell,self.breadthCell,self.weightCell];
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
    self.stateCell.contentTF.enabled = NO;
    UITapGestureRecognizer *stateCellTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stateCellTapClick)];
    [self.stateCell addGestureRecognizer:stateCellTap];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.stateCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupSectionFive{
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupSectionSix{
    //    备注textView2
    self.remarkTextView2 = [[TextInputTextView alloc]init];
    self.remarkTextView2.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView2.titleLabel.text = @"备注2";
    self.remarkTextView2.textView.placeholder = @"请输入备注内容";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView2];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionSeven{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
	UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, APPWidth -15*2, 28)];
	textLbl.textColor = CD_Text33;
	textLbl.font = FONT(14);
	textLbl.text = @"图片";
	CGFloat tHight = 104;//这个高度动态设置,根据每个屏幕的大小去设置
	[self.collectionVC setupMainCollectionViewWithFrame:CGRectMake(0, 0, APPWidth, tHight)];
	LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
	item.sectionRows = @[textLbl,self.collectionVC.mainCollectionView];
	item.canSelected = NO;
	item.sectionView = headerView;
	[self.datasource addObject:item];
}

#pragma mark ----- 点击事件 ------
//量化按钮事件 左键
- (void)leftBtnClick
{
//    NSLog(@"leftBtnClick");
    
    _isSelLeftBtn = YES;
    
    [self.leftBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
}

//量化按钮事件 右键
- (void)rightBtnClick
{
//    NSLog(@"rightBtnClick");
    
    _isSelrightBtn = YES;
    
    [self.rightBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
}

//分组cell点击事件
- (void)groupCellTapClick{
    [self.view endEditing:YES];
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchGroup;
    
    WEAKSELF
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];

    [vc setLabelsDetailBlock:^(NSString *labelString, NSString *labelId) {
        weakSelf.groupCell.contentTF.text = labelString;
       weakSelf.groupId = labelId;
    }];
}

//入库方式cell点击事件
- (void)defaultJoinCellTapClick{
    [self.view endEditing:YES];
    WEAKSELF;
    [BRStringPickerView showStringPickerWithTitle:@"请选择入库方式" dataSource:@[@"细码", @"总码"] defaultSelValue:nil resultBlock:^(id selectValue) {

        weakSelf.defaultJoinCell.contentTF.text = selectValue;
    }];
}

//单位cell点击事件
- (void)unitCellTapClick{
    [self.view endEditing:YES];
    LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
    vc.ToSearchWhat = ToSearchUnit;
    WEAKSELF;
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    
    [vc setLabelsDetailBlock:^(NSString *labelString, NSString *labelId) {
        weakSelf.unitCell.contentTF.text = labelString;
        weakSelf.unitId = labelId;
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
        headerView.backgroundColor = LZHBackgroundColor;
        
        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
        
        if ([labelString isEqualToString:@"公斤"]) {
            item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell,self.quantizationCell];
        }else{
            item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell];
        }
        
        item.canSelected = NO;
        item.sectionView = headerView;
        [self.datasource replaceObjectAtIndex:0 withObject:item];
        [self.mainTabelView reloadData];
    }];
}

//状态cell点击事件
- (void)stateCellTapClick{
    [self.view endEditing:YES];
    WEAKSELF;
    UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该产品启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * enabled = [UIAlertAction actionWithTitle:@"启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.stateCell.contentTF.text = @"启用";
    }];
    UIAlertAction * disEnabled = [UIAlertAction actionWithTitle:@"未启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.stateCell.contentTF.text = @"未启用";
    }];
    UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alterVc addAction:enabled];
    [alterVc addAction:disEnabled];
    [alterVc addAction:cacanle];
    [self.navigationController presentViewController:alterVc animated:true completion:nil];
}

- (void)addColorCellTapAction
{
    
    AddColorViewController *vc = [[AddColorViewController alloc]init];
    vc.dataModels = [self.colorArray mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
   WEAKSELF
    [vc setColorsArrayBlock:^( NSMutableArray <LLColorRegistModel*> *muColosArray) {

        //临时添加数据
//        NSMutableArray *tempMuArray = [weakSelf.array mutableCopy];
//        [tempMuArray addObjectsFromArray:muColosArray];
//        weakSelf.array = [tempMuArray copy];
//        weakSelf.colorArray = [muParamArray copy];
        [weakSelf.colorArray addObjectsFromArray:muColosArray];
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
        
        for (int i = 0; i <weakSelf.colorArray.count ; i++) {
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
            
            label.layer.borderColor = CD_Text33.CGColor;
//            label.layer.borderWidth = 1;
            label.tag =  i;
            label.text = weakSelf.colorArray[i].rightStr;
            label.textAlignment = NSTextAlignmentCenter;
            addGestureRecognizer(label, colorLableClick:)
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
/// MARK: ---- 修改lable的值
-(void)colorLableClick:(UIGestureRecognizer*)lable {
    UILabel * tempLable = (UILabel *)lable.view;
    AddColorViewController * colorVc = [AddColorViewController new];
    colorVc.dataModels = [NSMutableArray arrayWithObject:self.colorArray[tempLable.tag]] ;
    colorVc.ColorsArrayBlock = ^(NSMutableArray<LLColorRegistModel *> *muColosArray) {
        tempLable.text = muColosArray.firstObject.rightStr;
        [self.colorArray replaceObjectAtIndex:tempLable.tag withObject:muColosArray.firstObject];
    };
    colorVc.type = 1;
    [self.navigationController pushViewController:colorVc animated:true];
    
}

//右上角确认按钮事件
- (void)selectornavRightBtnClick
{
//    接口名称 添加产品
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入品名");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.groupCell.contentTF.text]) {
        BXS_Alert(@"请输入分组");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.defaultJoinCell.contentTF.text]) {
        BXS_Alert(@"请选择入库方式");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.unitCell.contentTF.text]) {
        BXS_Alert(@"请选择单位");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
        BXS_Alert(@"请选择状态");
        return;
    }
    //颜色是否已经最少选择了一个
    if (_colorArray.count <=0) {
        BXS_Alert(@"请至少填写一种颜色");
        return;
    }
    
	WEAKSELF
	[self.collectionVC uploadDatePhotosWithUrlStr:^(NSString *urlStr) {
		weakSelf.imgURLs = urlStr;
		[weakSelf requestComment];
	}];

}
- (void)requestComment{
	//量化所选的单位
	NSInteger quantizationCellType = -1;
	if ([self.unitCell.contentTF.text isEqualToString:@"公斤"]) {
		if (_isSelLeftBtn) {
			quantizationCellType = 1;
		}else if (_isSelrightBtn){
			quantizationCellType = 2;
		}
	}else{
		quantizationCellType = 0;
	}

	//状态所选的单位
	NSInteger status = -1;
	if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
		status = 0;
	}else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
		status = 1;
	}

	//入库类型所选的单位
	NSInteger storageType = -1;
	if ([self.defaultJoinCell.contentTF.text isEqualToString:@"总码"]) {
		storageType = 0;
	}else if ([self.defaultJoinCell.contentTF.text isEqualToString:@"细码"]){
		storageType = 1;
	}

	//颜色数组转换成字符串
    NSMutableArray <NSDictionary*>* colorItems = [NSMutableArray array];
    [self.colorArray enumerateObjectsUsingBlock:^(LLColorRegistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dict = @{@"name":obj.rightStr};
        [colorItems addObject:dict];
    }];
    NSString *colors = [colorItems mj_JSONString];

	NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
							 @"alias":self.nicknameCell.contentTF.text,
							 @"breadth":self.breadthCell.contentTF.text,
							 //                             @"colorItems":@"[{name:'红色'},{name:'紫色'},{name:'白色'}]",
							 @"colorItems":colors,
							 @"component":self.constituentCell.contentTF.text,
							 @"groupId":_groupId,
							 @"imgs":self.imgURLs==nil ? @"":self.imgURLs,
							 @"largePrice":[self.bigPriceCell.contentTF.text isEqualToString:@""] ? @"0" : self.bigPriceCell.contentTF.text,
							 @"name":self.titleCell.contentTF.text,
							 @"rateType":@(quantizationCellType),
							 @"rateValue":self.quantizationCell.contentTF.text,
							 @"remark":self.remarkTextView.textView.text,
							 @"remarkTwo":self.remarkTextView2.textView.text,
							 @"shearPrice":[self.dispersePriceCell.contentTF.text isEqualToString:@""] ? @"0" : self.dispersePriceCell.contentTF.text,
							 @"status":@(status),
							 @"storageType":@(storageType),
							 @"unitId":_unitId,
							 @"weight":self.weightCell.contentTF.text
							 };
	[BXSHttp requestGETWithAppURL:@"product/add.do" param:param success:^(id response) {
		LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
		if ([baseModel.code integerValue] != 200) {
			[LLHudTools showWithMessage:baseModel.msg];
			return ;
		}
		[LLHudTools showWithMessage:@"提交成功"];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self.navigationController popViewControllerAnimated:true];
		});

	} failure:^(NSError *error) {
		BXS_Alert(LLLoadErrorMessage);
	}];
}
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
- (ToolsCollectionVC *)collectionVC{
	if (!_collectionVC) {
		_collectionVC = [[ToolsCollectionVC alloc]init];
		self.collectionVC.maxCountTF = @"5";//最多选择5张
		_collectionVC.columnNumberTF = @"4";
		_collectionVC.view.frame = CGRectMake(0, 0, 0, 0);
		[self addChildViewController:_collectionVC];
		[self.view addSubview:_collectionVC.view];
		[_collectionVC didMoveToParentViewController:self];
		_collectionVC.cTarget = self;
	}
	return _collectionVC;
}

-(NSMutableArray<LLColorRegistModel *> *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
