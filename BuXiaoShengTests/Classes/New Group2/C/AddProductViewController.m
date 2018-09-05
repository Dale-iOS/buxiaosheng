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

//图片:
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZAssetCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LZSetImagePickerController.h"
#define Max_Photos 5 //最大选择照片总数
#define Max_LinePhotos 4 //选择图片页面每一行最大数

@interface AddProductViewController ()<LZHTableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
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
@property(nonatomic,strong)NSArray *colorArray;//最后网络请求的颜色数据
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

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;
@property(nonatomic ,strong)NSMutableString * imgURLs;
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
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, APPHeight-LLNavViewHeight)];
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
    
    [self configCollectionView];
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
    
    _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APPWidth -15*2, 40)];
    _textLbl.textColor = CD_Text33;
    _textLbl.font = FONT(14);
    _textLbl.text = @"图片";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_textLbl,self.collectionView];
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
        _groupId = labelId;
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
        _unitId = labelId;
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
    [self.navigationController pushViewController:vc animated:YES];
   
    [vc setColorsArrayBlock:^(NSMutableArray *muParamArray, NSMutableArray *muColosArray) {

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
    }];
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
    NSString *colors = [_colorArray mj_JSONString];

    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"alias":self.nicknameCell.contentTF.text,
                             @"breadth":self.breadthCell.contentTF.text,
//                             @"colorItems":@"[{name:'红色'},{name:'紫色'},{name:'白色'}]",
                             @"colorItems":colors,
                             @"component":self.constituentCell.contentTF.text,
                             @"groupId":_groupId,
                             @"imgs":self.imgURLs? : @"",
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



#pragma mark --- 选择图片 ---
//接口名称 图片上传
- (void)uploadPhotos:(NSArray *)selectArray{
    [LLHudTools showLoadingMessage:@"图片上传中~"];
    NSDictionary * param = @{@"file":@"0"};
    self.imgURLs = [NSMutableString string];
    NSMutableArray * imgURLs = [NSMutableArray array];
    [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [BXSHttp requestPOSTPhotosWithArray:@[obj] param:param AppURL:@"file/imageUpload.do" Key:@"file" success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [imgURLs addObject:baseModel.data[@"path"]];
            if (imgURLs.count == selectArray.count) {
                [imgURLs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self.imgURLs appendFormat:@"%@", [NSString stringWithFormat:@"%@,",obj]];
                }];
            }
//            NSDictionary *tempDic = baseModel.data;
//            _imageStr = tempDic[@"path"];
            [LLHudTools dismiss];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }];
   
}

- (UIImagePickerController *)imagePickerVc{
    if (_imagePickerVc == nil) {
        _imagePickerVc = [LZSetImagePickerController initWithImagePickerVc:_imagePickerVc withUIviewCTarget:self];
    }
    return _imagePickerVc;
}

- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) collectionViewLayout:_layout];
    //    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(10, 10, 1, 10);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 4 - _margin -25;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = 1;
    _layout.minimumLineSpacing = 1;
    [self.collectionView setCollectionViewLayout:_layout];
    //禁止滚动, 直接滚动到底部
    self.collectionView.scrollEnabled = NO;
    [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + 10) animated:NO];
    [self.collectionView reloadData];
}

#pragma mark UICollectionView
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 10, 1, 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count >= Max_Photos) {
        return _selectedPhotos.count;
    }
    
    //根据cell的数量，更改collectionView的frame
   // CGFloat tempH = _itemWH +10;
    //self.collectionView.frame = CGRectMake(0, 0, APPWidth, tempH);
    [self.mainTabelView reloadData];
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"add_image"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _selectedPhotos.count) {
        [LZSetImagePickerController showAlertStyle:UIAlertControllerStyleActionSheet
                                      withTitleStr:nil withMessageStr:nil
                                  withBtn1TitleStr:@"拍照" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"去相册选择" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:@"取消" withBtn3ActionStyle:UIAlertActionStyleCancel
                                       withCTarget:self withButtonClickIndex:^(NSInteger Index) {
                                           if (Index == 1) {
                                               [self takePhoto];
                                           }else if (Index == 2){
                                               [self pushTZImagePickerController];
                                           }
                                       }];
    } else { //预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.item];
        imagePickerVc.maxImagesCount = Max_Photos;
        imagePickerVc.allowPickingGif = NO;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.allowPickingMultipleVideo = NO;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
            self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
            self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
            [self->_collectionView reloadData];
            self->_collectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (self->_margin + self->_itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:Max_Photos columnNumber:Max_LinePhotos delegate:self pushPhotoPickerVc:YES];
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    [LZSetImagePickerController setImagePickerVc:imagePickerVc];
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.tz_width - 2 * left;
    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = NO;
#pragma mark - 到这里为止
    // 你可以通过block或者代理，来得到用户选择的照片.
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//
//    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControlle
- (void)takePhoto {
    WEAKSELF;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
            [weakSelf pushImagePickerController];
            
        }else{
            //[JLHelperManager UIAlertWithStr:@"请在系统设置中开启相册授权" WithTitle:@"相册授权未开启" WithVC:self block:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [LZSetImagePickerController showAlertStyle:UIAlertControllerStyleAlert
                                              withTitleStr:@"无法使用相机"
                                            withMessageStr:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                                          withBtn1TitleStr:@"设置" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"取消" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:nil withBtn3ActionStyle:UIAlertActionStyleDefault withCTarget:weakSelf withButtonClickIndex:^(NSInteger Index) {
                                              if (Index == 1) {
                                                  // 去设置界面，开启相机访问权限
                                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                              }
                                          }];
            });
        }
    }];
    //    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
    //        // 无相机权限 做一个友好的提示
    //        [LZSetImagePickerController showAlertStyle:UIAlertControllerStyleAlert
    //                                      withTitleStr:@"无法使用相机"
    //                                    withMessageStr:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
    //                withBtn1TitleStr:@"设置" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"取消" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:nil withBtn3ActionStyle:UIAlertActionStyleDefault withCTarget:self withButtonClickIndex:^(NSInteger Index) {
    //            if (Index == 1) {
    //                // 去设置界面，开启相机访问权限
    //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    //            }
    //        }];
    //    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
    //        //防止用户首次拍照拒绝授权时相机页黑屏
    //            //[self takePhoto];
    //        // 拍照之前还需要检查相册权限
    //    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
    //        BXS_Alert(@"无法访问相册\r\n请在iPhone的""设置-隐私-相册""中允许访问相册");
    //    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
    //        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
    //           // [self takePhoto];
    //        }];
    //    } else {
    //        [self pushImagePickerController];
    //    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		//升级pod 报错--------
        //保存图片，获取到asset
//        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
//            if (error) {
//                [tzImagePickerVc hideProgressHUD];
//                NSLog(@"图片保存失败 %@",error);
//            } else {
//                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
//                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }
//                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
//                    }];
//                }];
//            }
//        }];
		//升级pod 报错--------
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    
    _selectedPhotos = [NSMutableArray arrayWithArray:@[image]];
    [self uploadPhotos:_selectedPhotos];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - TZImagePickerControllerDelegate
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
}
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    //[_collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
    [_collectionView reloadData];
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    [self uploadPhotos:_selectedPhotos];
}
#pragma mark - Click Event
//图片删除按钮
- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
        [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + 10) animated:NO];
        [self.collectionView reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView setContentOffset:CGPointMake(0, _collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
        [self->_collectionView reloadData];
    }];
    
    [self uploadPhotos:_selectedPhotos];
}
#pragma mark - Private
/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        }
        NSLog(@"图片名字:%@",fileName);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
