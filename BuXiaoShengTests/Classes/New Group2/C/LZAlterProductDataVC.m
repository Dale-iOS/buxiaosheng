//
//  LZAlterProductDataVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改产品资料页面

#import "LZAlterProductDataVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "UIButton+EdgeInsets.h"
#import "AddColorViewController.h"
#import "BRPickerView.h"
#import "LZChooseLabelVC.h"
#import "LZProductDetailModel.h"
#import "ToolsCollectionVC.h"

@interface LZAlterProductDataVC ()<LZHTableViewDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    NSMutableArray *_array;
//    NSString *_groupId;//分组id
//    NSString *_unitId;//单位id
    NSMutableArray *_selectedPhotos;
    NSMutableArray * _selectedAssets;
     BOOL _isSelectOriginalPhoto;
}
@property(nonatomic,copy)NSString *unitId;//单位id;
@property(nonatomic,copy)NSString *groupId;//分组id
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
@property(nonatomic,strong)LZProductDetailModel *detailModel;
@property(nonatomic,strong)NSMutableArray *colorsNameMuArray;//颜色名字
@property (nonatomic, strong) LZProductDetailModel *model;
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
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
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
@property(nonatomic,strong)NSArray *colorArray;//最后网络请求的颜色数据
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///备注2
@property (nonatomic, strong) TextInputTextView *remarkTextView2;
@property(nonatomic,strong)NSMutableArray *photosArrayUrl;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
@end

@implementation LZAlterProductDataVC
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
     _selectedPhotos = [NSMutableArray array];
    [self setupUI];
    [self setupData];
    [self setupColorList];
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
    self.navigationItem.titleView = [Utility navTitleView:@"修改产品资料"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(selectornavRightBtnClick) title:@"确认"];
    
    _photosArrayUrl = [NSMutableArray array];
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
    
    self.dispersePriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.dispersePriceCell.titleLabel.text = @"销售散剪价";
    self.dispersePriceCell.contentTF.placeholder = @"请输入销售散剪价";
    
    self.constituentCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.constituentCell.titleLabel.text = @"成分";
    self.constituentCell.contentTF.placeholder = @"请输入成分";
    
    self.breadthCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.breadthCell.titleLabel.text = @"幅宽";
    self.breadthCell.contentTF.placeholder = @"请输入幅宽";
    
    self.weightCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.weightCell.titleLabel.text = @"克重";
    self.weightCell.contentTF.placeholder = @"请输入克重";
    
    
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
    
    _array = [NSMutableArray array];
    
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
#pragma mark ---- 网络请求 ----
//接口名称 产品详情
- (void)setupData{
    NSDictionary * param = @{@"id":self.id};
	WEAKSELF
    [BXSHttp requestGETWithAppURL:@"product/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
       weakSelf.model = [LZProductDetailModel LLMJParse:baseModel.data];
    
        //赋值
        self.titleCell.contentTF.text = weakSelf.model.name;
        self.groupCell.contentTF.text = weakSelf.model.groupName;
        weakSelf.groupId = weakSelf.model.groupId;
        if ([weakSelf.model.storageType integerValue] == 0) {
            self.defaultJoinCell.contentTF.text = @"总码";
        }else if ([weakSelf.model.storageType integerValue] == 1){
            self.defaultJoinCell.contentTF.text = @"细码";
        }
        self.nicknameCell.contentTF.text = weakSelf.model.alias;
        self.bigPriceCell.contentTF.text = weakSelf.model.largePrice;
        self.dispersePriceCell.contentTF.text = weakSelf.model.shearPrice;
        self.quantizationCell.contentTF.text = weakSelf.model.rateValue;
        
        //当是公斤的时候，量化cell选择的是米还是码
        if ([weakSelf.model.unitName isEqualToString:@"公斤"] && [weakSelf.model.rateType integerValue]==1) {
            //米
            weakSelf.isSelLeftBtn = YES;
            [self.leftBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
            weakSelf.isSelrightBtn = NO;
            [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
        }else if ([weakSelf.model.unitName isEqualToString:@"公斤"] && [weakSelf.model.rateType integerValue]==2){
            //码
           weakSelf.isSelLeftBtn = NO;
            [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
           weakSelf.isSelrightBtn = YES;
            [self.rightBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
        }
        
        //单位是公斤的话，会多出一条量化cell
        if ([weakSelf.model.unitName isEqualToString:@"公斤"]) {
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
            headerView.backgroundColor = LZHBackgroundColor;
            
            LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
            item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell,self.quantizationCell];
            item.canSelected = NO;
            item.sectionView = headerView;
            [self.datasource replaceObjectAtIndex:0 withObject:item];
            [self.mainTabelView reloadData];
        }else{
            UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
            headerView.backgroundColor = LZHBackgroundColor;
            
            LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
            item.sectionRows = @[self.titleCell,self.groupCell,self.defaultJoinCell,self.unitCell];
            item.canSelected = NO;
            item.sectionView = headerView;
            [self.datasource replaceObjectAtIndex:0 withObject:item];
            [self.mainTabelView reloadData];
        }
        
        
        self.unitCell.contentTF.text = weakSelf.model.unitName;
		weakSelf.unitId = weakSelf.model.unitName;
        self.constituentCell.contentTF.text = weakSelf.model.component;
        self.breadthCell.contentTF.text = weakSelf.model.breadth;
        self.weightCell.contentTF.text = weakSelf.model.weight;
        if ([weakSelf.model.status integerValue] == 0) {
            self.stateCell.contentTF.text = @"启用";
        }else if ([weakSelf.model.status integerValue] == 1){
            self.stateCell.contentTF.text = @"未启用";
        }
        self.remarkTextView.textView.text = weakSelf.model.remark;
        self.remarkTextView2.textView.text = weakSelf.model.remarkTwo;
		//设置图片信息
		self.collectionVC.downloadImageUrlList =weakSelf.model.imgs;
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupColorList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"productId":self.id
                             };
    [BXSHttp requestGETWithAppURL:@"product_color/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSArray *tempArray = baseModel.data;
		NSMutableArray *muArray = [NSMutableArray array];
		NSMutableArray *muArray1 = [NSMutableArray array];
        for (int i = 0; i < tempArray.count; i++) {
			NSMutableDictionary * param = [NSMutableDictionary dictionary];
            param[@"id"] = tempArray[i][@"id"];
            param[@"name"] = tempArray[i][@"name"];
            param[@"productId"] = tempArray[i][@"productId"];
			[muArray addObject:param];
			[muArray1 addObject:tempArray[i][@"name"]];
        }
		//设置样式
		[self updateClolorUI:muArray withMuColosArray:muArray1];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

#pragma mark ----- 点击事件 ------
//量化按钮事件 左键
- (void)leftBtnClick
{

    _isSelLeftBtn = YES;
    
    [self.leftBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
}
//量化按钮事件 右键
- (void)rightBtnClick
{

    _isSelrightBtn = YES;
    
    [self.rightBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
    [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
}

//分组cell点击事件
- (void)groupCellTapClick{
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
    WEAKSELF;
    [BRStringPickerView showStringPickerWithTitle:@"请选择入库方式" dataSource:@[@"细码", @"总码"] defaultSelValue:nil resultBlock:^(id selectValue) {
        
        weakSelf.defaultJoinCell.contentTF.text = selectValue;
    }];
}

//单位cell点击事件
- (void)unitCellTapClick{
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
    [self.navigationController pushViewController:vc animated:YES];
    [vc setColorsArrayBlock:^(NSMutableArray *muParamArray, NSMutableArray *muColosArray) {
		[self updateClolorUI:muParamArray withMuColosArray:muColosArray];
    }];
}
/**
点击确定,刷新数据
 @param muParamArray (_colorArray)	 @[(name:x),(name:y),(name:z)]
 @param muColosArray (_array) 		 @[(x),(y),(z)]
 */
- (void)updateClolorUI:(NSMutableArray *)muParamArray withMuColosArray:(NSMutableArray *)muColosArray{

	//临时添加数据
	NSMutableArray *tempMuArray = [_array mutableCopy];
	[tempMuArray addObjectsFromArray:muColosArray];
	_array = [tempMuArray copy];
	_colorArray = [muParamArray copy];

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

		label.layer.borderColor = CD_Text33.CGColor;
		//            label.layer.borderWidth = 1;

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
		weakSelf.model.imgs =urlStr;
		NSLog(@"_model.imgs:%@",weakSelf.model.imgs);
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
	}else if ([self.stateCell.contentTF.text isEqualToString:@"细码"]){
		storageType = 1;
	}

	//颜色数组转换成字符串
	NSString *colors = [_colorArray mj_JSONString];


	NSDictionary * param = @{@"companyId":nil_string([BXSUser currentUser].companyId),
							 @"alias":self.nicknameCell.contentTF.text,
							 @"breadth":self.breadthCell.contentTF.text,
							 @"colorItems":colors,
							 @"component":self.constituentCell.contentTF.text,
							 @"groupId":_groupId,
							 @"id":self.id,
							 @"imgs": _model.imgs == nil ? @"" : _model.imgs,
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
	[BXSHttp requestGETWithAppURL:@"product/update.do" param:param success:^(id response) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
static NSString * nil_string(NSString *str) {
	str = [NSString stringWithFormat:@"%@",str];
	if (str == nil
		|| str == NULL
		|| [str isEqualToString:@""]
		|| [str isEqualToString:@"null"]
		|| [str isEqualToString:@"(null)"]
		|| [str isEqualToString:@"NULL"]
		|| [str isEqualToString:@"(NULL)"]
		|| [str isKindOfClass:[NSNull class]]
		|| [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
		return @"";
	}
	return str;
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
@end
