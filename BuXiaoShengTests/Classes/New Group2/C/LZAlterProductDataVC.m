//
//  LZAlterProductDataVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改产品资料页面
#define Max_Photos 5
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
#import "GKPhotoBrowser.h"
#import "TZTestCell.h"
#import "LZSetImagePickerController.h"


@interface LZAlterProductDataVC ()<LZHTableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
{
    NSMutableArray *_array;
    NSString *_groupId;//分组id
    NSString *_unitId;//单位id
    NSMutableArray *_selectedPhotos;
    NSMutableArray * _selectedAssets;
     BOOL _isSelectOriginalPhoto;
}
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

@property (nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *photosArrayUrl;
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
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 104)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
//    self.visitIMV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 80, 80)];
//    self.visitIMV.userInteractionEnabled = YES;
//    UITapGestureRecognizer *visitIMVTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(visitIMVTapOnClick)];
//    [self.visitIMV addGestureRecognizer:visitIMVTap];
    [bottomView addSubview:self.collectionView];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[textLbl,bottomView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

//展示图片
- (void)visitIMVTapOnClick{
    
    NSMutableArray *photos = [NSMutableArray new];
    [_photosArrayUrl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo = [GKPhoto new];
        photo.url = [NSURL URLWithString:obj];
        
        [photos addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    //    browser.loadStyle = GKPhotoBrowserLoadStyleDeterminate;
    [browser showFromVC:self];
}

#pragma mark ---- 网络请求 ----
//接口名称 产品详情
- (void)setupData{
    NSDictionary * param = @{@"id":self.id};
    [BXSHttp requestGETWithAppURL:@"product/detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZProductDetailModel LLMJParse:baseModel.data];
    
        //赋值
        self.titleCell.contentTF.text = _model.name;
        self.groupCell.contentTF.text = _model.groupName;
        _groupId = _model.groupId;
        if ([_model.storageType integerValue] == 0) {
            self.defaultJoinCell.contentTF.text = @"总码";
        }else if ([_model.storageType integerValue] == 1){
            self.defaultJoinCell.contentTF.text = @"细码";
        }
        self.nicknameCell.contentTF.text = _model.alias;
        self.bigPriceCell.contentTF.text = _model.largePrice;
        self.dispersePriceCell.contentTF.text = _model.shearPrice;
        self.quantizationCell.contentTF.text = _model.rateValue;
        
        //当是公斤的时候，量化cell选择的是米还是码
        if ([_model.unitName isEqualToString:@"公斤"] && [_model.rateType integerValue]==1) {
            //米
            _isSelLeftBtn = YES;
            [self.leftBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
            _isSelrightBtn = NO;
            [self.rightBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
    
        }else if ([_model.unitName isEqualToString:@"公斤"] && [_model.rateType integerValue]==2){
            //码
            _isSelLeftBtn = NO;
            [self.leftBtn setImage:IMAGE(@"noSelect1") forState:UIControlStateNormal];
            _isSelrightBtn = YES;
            [self.rightBtn setImage:IMAGE(@"yesSelect1") forState:UIControlStateNormal];
        }
        
        //单位是公斤的话，会多出一条量化cell
        if ([_model.unitName isEqualToString:@"公斤"]) {
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
        
        
        self.unitCell.contentTF.text = _model.unitName;
		_unitId = _model.unitName;
        self.constituentCell.contentTF.text = _model.component;
        self.breadthCell.contentTF.text = _model.breadth;
        self.weightCell.contentTF.text = _model.weight;
        if ([_model.status integerValue] == 0) {
            self.stateCell.contentTF.text = @"启用";
        }else if ([_model.status integerValue] == 1){
            self.stateCell.contentTF.text = @"未启用";
        }
        self.remarkTextView.textView.text = _model.remark;
        self.remarkTextView2.textView.text = _model.remarkTwo;
        NSArray * imgs = [_model.imgs componentsSeparatedByString:@","];
        NSMutableArray * tempImg = [NSMutableArray array];
        [imgs enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isEqualToString:@""]) {
                [tempImg addObject:obj];
            }
        }];
        [tempImg enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:obj] options:(SDWebImageDownloaderLowPriority) progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (image) {
                      [_selectedPhotos addObject:image];
                }
                if (_selectedPhotos.count == tempImg.count) {
                     [self.collectionView reloadData];
                }
            }];
        }];
//        if (!_model.imgs.count) {
//
//        }
//        [self.visitIMV sd_setImageWithURL:[NSURL URLWithString:model.imgs]];
        //[Utility showPicWithUrl:_model.imgs imageView:self.visitIMV placeholder:IMAGE(@"noImage")];
       // [_photosArrayUrl addObject:_model.imgs];
        
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
        _groupId = labelId;
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
//        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        //cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//图片删除按钮
- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        //[_selectedAssets removeObjectAtIndex:sender.tag];
        //[self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + 10) animated:NO];
        [self.collectionView reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [self->_collectionView reloadData];
    //[_selectedAssets removeObjectAtIndex:sender.tag];
//    [_collectionView performBatchUpdates:^{
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
//        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    } completion:^(BOOL finished) {
//        //[_collectionView setContentOffset:CGPointMake(0, _collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
//
//    }];
    [self uploadPhotos:_selectedPhotos];
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
        NSMutableArray * array = [NSMutableArray array];
        GKPhoto * phto = [GKPhoto new];
        phto.image = _selectedPhotos[indexPath.item];
        [array addObject:phto];
        GKPhotoBrowser *  photoBrowser = [GKPhotoBrowser photoBrowserWithPhotos:array currentIndex:0];
        [photoBrowser showFromVC:self];
//        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:nil selectedPhotos:_selectedPhotos index:indexPath.item];
//        imagePickerVc.maxImagesCount = Max_Photos;
//        imagePickerVc.allowPickingGif = NO;
//        imagePickerVc.allowPickingOriginalPhoto = YES;
//        imagePickerVc.allowPickingMultipleVideo = NO;
//        imagePickerVc.showSelectedIndex = YES;
//        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
////        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
////            self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
////            //self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
////            self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
////            [self->_collectionView reloadData];
////           CGFloat  _margin = 4;
////            CGFloat _itemWH = (APPWidth - 2 * _margin - 4) / 4 - _margin -20;
////            self->_collectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (4 + _itemWH));
////        }];
//        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
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
//    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
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
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    [_selectedPhotos addObjectsFromArray:photos];
   // _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    //[_collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
    [_collectionView reloadData];
    // 1.打印图片名字
    //[self printAssetsName:assets];
    // 2.图片位置信息
    for (PHAsset *phAsset in assets) {
        NSLog(@"location:%@",phAsset.location);
    }
    [self uploadPhotos:_selectedPhotos];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];///原图
    //获取修剪后的图片
    UIImage *imageUp = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_selectedPhotos addObject:imageUp];
    [self.collectionView reloadData];
//    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
//
//    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//    tzImagePickerVc.sortAscendingByModificationDate = YES;
//    [tzImagePickerVc showProgressHUD];
//    if ([type isEqualToString:@"public.image"]) {
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        //保存图片，获取到asset
//        [[TZImageManager manager] savePhotoWithImage:image location:nil completion:^(NSError *error){
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
//    }
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // 设置类型, 表示仅仅从相册中获取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    // 设置照片是否允许用户编辑
    imagePicker.allowsEditing = true;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_selectedPhotos.count columnNumber:0 delegate:self pushPhotoPickerVc:YES];
//#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
//    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
//    //imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
//    [LZSetImagePickerController setImagePickerVc:imagePickerVc];
//    // 设置竖屏下的裁剪尺寸
//    NSInteger left = 30;
//    NSInteger widthHeight = APPWidth - 2 * left;
//    NSInteger top = (APPHeight - widthHeight) / 2;
//    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
//    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
//
//    // 设置是否显示图片序号
//    imagePickerVc.showSelectedIndex = NO;
//#pragma mark - 到这里为止
//    // 你可以通过block或者代理，来得到用户选择的照片.
//    //    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//    //
//    //    }];
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    //[_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
    
    _selectedPhotos = [NSMutableArray arrayWithArray:@[image]];
    [self uploadPhotos:_selectedPhotos];
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}
//接口名称 图片上传
- (void)uploadPhotos:(NSArray *)selectArray{
    if (selectArray.count > 5) {
        [LLHudTools showWithMessage:@"您最多能选择五个图片上传"];
        return;
    }
    [LLHudTools showLoadingMessage:@"图片上传中~"];
    NSDictionary * param = @{@"file":@"0"};
    NSMutableString *imgsURL = [NSMutableString string];
    NSMutableArray * imgsArray = [NSMutableArray array];
    [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [BXSHttp requestPOSTPhotosWithArray:@[obj] param:param AppURL:@"file/imageUpload.do" Key:@"file" success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [imgsArray addObject:baseModel.data[@"path"]];
            if (imgsArray.count == selectArray.count) {
                [imgsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [imgsURL appendFormat:@"%@", [NSString stringWithFormat:@"%@,",obj]];
                    
                }];
                _model.imgs = imgsURL;
            }
            // NSDictionary *tempDic = baseModel.data;
            //_imageStr = tempDic[@"path"];
            [LLHudTools dismiss];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
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
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat _margin = 4;
       CGFloat _itemWH = (APPWidth- 2 * _margin - 4) / 4 - _margin -25;
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        //禁止滚动, 直接滚动到底部
        _collectionView.scrollEnabled = NO;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 100) collectionViewLayout:layout];
        //    CGFloat rgb = 244 / 255.0;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(1, 10, 1, 10);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_collectionView];
        [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    }
    return _collectionView;
}
@end
