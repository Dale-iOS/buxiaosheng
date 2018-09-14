//
//  LZPurchaseReceiptDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购收货审批 采购收货详情

#import "LZPurchaseReceiptDetailVC.h"
#import "LZPurchaseReceiptDetailInfoModel.h"
#import "LZPurchaseReceiptDetailCellModel.h"

#import "BXSMachiningBottomView.h"
#import "BXSAllCodeCell.h"
#import "LZFineCodeVC.h"
#import "ConCell.h"
#import "ApproverModel.h"
#import "BXSPurchaChangeWarehousingView.h"
#import "BaseTableVC+BXSTakePhoto.h"
#import "LZPurchaseReceiptSaveAlterModel.h"
#import "ToolsCollectionVC.h"

#define  SELECTAPPROVER @"选择审批人"
@interface LZPurchaseReceiptDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_buyOrderItemIds;
//    NSInteger _ximaTotal;
//    NSInteger _ximaValue;
//    NSString *_zongmaTotal;
//    NSString *_zongmaValue;
}
@property (strong,nonatomic)BXSMachiningBottomView *bottomView;
@property (strong,nonatomic)NSMutableArray *allCodeArray;
/// 底部数据
@property (strong,nonatomic)NSMutableArray *bDataArray;
@property (strong,nonatomic) LLBaseModel * baseModel;
@property (strong,nonatomic)ApproverModel  *selectApprover;
@property (strong,nonatomic)NSArray *bankArr;
@property (strong,nonatomic)NSArray *houseArr;
@property (strong,nonatomic)NSArray *unitArr;
@property (copy,nonatomic)UIImage  *selectImage;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
@property (nonatomic,copy)NSString * urlImageStr;

@property (nonatomic, strong) LZPurchaseReceiptDetailInfoModel *infoModel;
@property (nonatomic, strong) NSMutableArray <LZPurchaseReceiptDetailCellModel*> *cellInfo;
@end

@implementation LZPurchaseReceiptDetailVC
/// 懒加载
- (NSMutableArray *)bDataArray {
    if (!_bDataArray) {
        _bDataArray = [NSMutableArray array];
    }
    return _bDataArray;
}
/// 懒加载
- (NSMutableArray *)allCodeArray {
    if (!_allCodeArray) {
        _allCodeArray = [NSMutableArray array];
    }
    return _allCodeArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupBottom];
    [self loadBottomData];
    [self setupSelectData];
//    [self setupData];
    
    
    self.navigationItem.titleView = [Utility navTitleView:@"采购收货详情"];
    [self getProductInfo];
    [self getProductDetail];
    
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
- (void)keyboardChange:(NSNotification *)noti {
    if ([noti.name isEqualToString: UIKeyboardDidHideNotification]) {
        // 底部计算
        [self getBottomData];
        [self setPerItem];
        [self.mainTable reloadData];
    }
}


#pragma mark ---- 网络请求 ----
//接口名称 采购单详情
- (void)getProductInfo{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyOrderId":self.bugId
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/buy_detail.do" param:param success:^(id response) {
        
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
        weakSelf.infoModel = [LZPurchaseReceiptDetailInfoModel LLMJParse:baseModel.data];

		//导入网络的图片
		if (weakSelf.infoModel.imgs != nil) {
			self.collectionVC.downloadImageUrlList =weakSelf.infoModel.imgs;
		}
        // 供应名称 联系人 电话 地址
        ConItem *item1 = self.bDataArray[1][2];
        item1.contenText = [baseModel.data valueForKey:@"factoryName"];
        ConItem *item2 = self.bDataArray[1][3];
        item2.contenText = [baseModel.data valueForKey:@"contactName"];
        ConItem *item3 = self.bDataArray[1][4];
        item3.contenText = [baseModel.data valueForKey:@"mobile"];
        ConItem *item4 = self.bDataArray[1][5];
        item4.contenText = [baseModel.data valueForKey:@"address"];
        
        //仓库-供应商单号
        ConItem *item10 = self.bDataArray[1][0];
        item10.contenText = weakSelf.infoModel.houseName;
        item10.id = weakSelf.infoModel.houseId;
        
        ConItem *item11 = self.bDataArray[1][1];
        item11.contenText = weakSelf.infoModel.factoryNo;
        item11.id = [baseModel.data valueForKey:@"houseId"];
        
        
        // 应付 - 实付 - 笨蛋欠款 - 付款方式 - 备注
        ConItem *item01 = self.bDataArray[0][0];
        item01.contenText = weakSelf.infoModel.copewithPrice;
        
        ConItem *item02 = self.bDataArray[0][1];
        item02.contenText = weakSelf.infoModel.realpayPrice;;
        
        ConItem *item03 = self.bDataArray[0][2];
        item03.contenText = weakSelf.infoModel.arrearsPrice;
        
        ConItem *item04 = self.bDataArray[0][3];
        item04.contenText = weakSelf.infoModel.bankName;
        item04.id = weakSelf.infoModel.bankId;
        
        ConItem *item05 = self.bDataArray[0][4];
        item05.contenText = weakSelf.infoModel.remark;
        
        [self.mainTable reloadData];
        
        
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

//口名称 采购单产品详情
- (void)getProductDetail{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyOrderId":self.bugId
                             };
    [BXSHttp requestGETWithAppURL:@"documentary/buy_product_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        weakSelf.cellInfo = [LZPurchaseReceiptDetailCellModel LLMJParse:baseModel.data];
        
        
        self.baseModel = baseModel;
        self.allCodeArray = [BXSAllCodeModel LLMJParse:baseModel.data];
//        if (weakSelf.isFindCode && self.allCodeArray.count >0) {
//            [self.allCodeArray setValue:@"YES" forKey:@"isFindCode"];
//        }
        LZPurchaseReceiptDetailCellModel *tempModel = weakSelf.cellInfo.firstObject;
        if (tempModel.storageType.integerValue == 0) {
            self.isFindCode = NO;
            [self.allCodeArray setValue:@"NO" forKey:@"isFindCode"];
        }else{
            self.isFindCode = YES;
            [self.allCodeArray setValue:@"YES" forKey:@"isFindCode"];
        }
        [self initAllCodeData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购收货"];
    
    //_mainTable
    [self.mainTable removeFromSuperview];
    self.mainTable = nil;
    self.mainTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:UITableViewStyleGrouped];
    
    
    self.mainTable.separatorInset = UIEdgeInsetsZero;
    self.mainTable.separatorColor = LZHBackgroundColor;
    self.mainTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //    self.mainTable.tableFooterView = [LineView lineViewOfHeight:20];
    self.mainTable.tableHeaderView = [LineView lineViewOfHeight:1];
    self.mainTable.estimatedRowHeight = 0;
    self.mainTable.estimatedSectionHeaderHeight = 0;
    self.mainTable.estimatedSectionFooterHeight = 0;
    [self.view addSubview:self.mainTable];
    [self setTableFooter];
    
    self.mainTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    //cell
    [self.mainTable registerClass:[ConCell class] forCellReuseIdentifier:[ConCell cellID]];
    [self.mainTable registerClass:[BXSAllCodeCell class] forCellReuseIdentifier:@"k_findID"];
    [self.mainTable registerClass:[BXSAllCodeCell class] forCellReuseIdentifier:[BXSAllCodeCell cellID]];
    
    [self.mainTable registerClass:[ConMarkCell class] forCellReuseIdentifier:[ConMarkCell cellID]];
    
    
}


- (void)setupBottom {
    
    //bottomView
    BXSMachiningBottomView *bottomView = [BXSMachiningBottomView bottomView];
    
    [self.view addSubview:bottomView];
    bottomView.sd_layout
    .topSpaceToView(self.mainTable, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    [bottomView setupCount:@"总数量：0" bottomCount:@"总条数：0"];
    
    //click
    WEAKSELF;
    bottomView.clickBottomTrue = ^{
        [weakSelf clickBottom];
    };
    self.bottomView = bottomView;
}
///相册选择 --多处用到写成分类避免冗余
- (void)setTableFooter {

	UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 140)];

	UIView *bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, APPWidth, 100)];
	[footer addSubview:bacView];
	bacView.backgroundColor = [UIColor whiteColor];

	UILabel *photoLable = [UILabel labelWithColor:CD_Text33 font:FONT(15)];
	photoLable.frame = CGRectMake(15, 10, 120, 15);
	photoLable.text = @"图片";
	[bacView addSubview:photoLable];

	CGFloat addWH = 60.f;

	//Collection
	CGRect tFrame =CGRectMake(0, photoLable.bottom + (bacView.height - photoLable.bottom - addWH)/2, APPWidth, ((APPWidth-6*10)/5 + 30));//这个高度根据屏幕去算的暂时写死
	_collectionVC = [[ToolsCollectionVC alloc]init];
	self.collectionVC.maxCountTF = @"5";//最多选择5张
	_collectionVC.columnNumberTF = @"4";
	_collectionVC.view.frame = tFrame;
	_collectionVC.view.backgroundColor = [UIColor whiteColor];
	[self addChildViewController:_collectionVC];
	[bacView addSubview:_collectionVC.view];
	[_collectionVC didMoveToParentViewController:self];
	[self.collectionVC setupMainCollectionViewWithFrame:CGRectMake(0, 0,APPWidth, ((APPWidth-6*10)/5 + 30))];
	[self.collectionVC.view addSubview:self.collectionVC.mainCollectionView];

	bacView.height = self.collectionVC.view.bottom;
	footer.height = bacView.bottom + 20;
	self.mainTable.tableFooterView = footer;

//    [self setTableFooterTakePhoto];
}
- (void)loadBottomData  {
    
    ConItem *item = [[ConItem alloc]initWithTitle:@"应付总款" kpText:@"应付总款" conType:ConTypeC];
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"实付金额" kpText:@"输入实付金额" conType:ConTypeB];
    ConItem *item2 = [[ConItem alloc]initWithTitle:@"本单欠款" kpText:@"本单欠款" conType:ConTypeC];
    item2.textColor = [UIColor redColor];
    ConItem *item3 = [[ConItem alloc]initWithTitle:@"付款方式" kpText:@"选择付款方式" conType:ConTypeA];
    ConItem *item4 = [[ConItem alloc]initWithTitle:@"备注" kpText:@"请输入备注内容" conType:ConTypeB];
    [self.bDataArray addObject:@[item,item1,item2,item3,item4]];
    
    
    
    ConItem *item5 = [[ConItem alloc]initWithTitle:@"*入仓库" kpText:@"请选择仓库" conType:ConTypeA];
    ConItem *item6 = [[ConItem alloc]initWithTitle:@"供应商单号" kpText:@"请输入供应商单号" conType:ConTypeB];
    ConItem *item7 = [[ConItem alloc]initWithTitle:@"供应商名称" kpText:@"供应商名称" conType:ConTypeC];
    
    ConItem *item8 = [[ConItem alloc]initWithTitle:@"联系人" kpText:@"联系人" conType:ConTypeC];
    ConItem *item9 = [[ConItem alloc]initWithTitle:@"电话" kpText:@"电话" conType:ConTypeC];
    ConItem *item10 = [[ConItem alloc]initWithTitle:@"地址" kpText:@"地址" conType:ConTypeC];
    
    [self.bDataArray addObject:@[item5,item6,item7,item8,item9,item10]];
    [self.mainTable reloadData];
    
}

- (void)initAllCodeData {
    
    [self.allCodeArray removeAllObjects];
    /// 产品信息信息在这里刷新UI
    for (LZPurchaseReceiptDetailCellModel *cellModel in _cellInfo) {
        
        BXSAllCodeModel *model = [BXSAllCodeModel new];
        [self.allCodeArray addObject:model];
        model.productName = cellModel.productName;
        model.productColorId = cellModel.productColorId;
        model.productColorName = cellModel.productColorName;
        model.number = cellModel.number;
        model.houseUnitName = cellModel.houseUnitName;
        _buyOrderItemIds = cellModel.buyOrderItemId;
        if (cellModel.storageType.integerValue == 1) {
            //细码
            model.isFindCode = YES;
            for (LZPurchaseReceiptDetailCellItemList *item in cellModel.itemList) {
                LZFindCodeModel *findModel = [LZFindCodeModel initModelTitle:@"细码" code:item.value];
                findModel.id = item.valId;
                [model.findCodeArray addObject:findModel];
            }
            
        }else{
            //总码
            model.isFindCode = NO;
        }
        
        
        
        ConItem *item = [[ConItem alloc]initWithTitle:@"总数量" kpText:@"输入数量" conType:ConTypeB];
        
        ConItem *item1 = [[ConItem alloc]initWithTitle:@"条数" kpText:@"输入条数" conType:ConTypeB];
        
        if (!self.isFindCode) {
           
            LZPurchaseReceiptDetailCellItemList *itemList = cellModel.itemList.firstObject;
            item.contenText = itemList.value;
            item1.contenText = itemList.total;
        }
        
        ConItem *item2 = [[ConItem alloc]initWithTitle:@"供货商名称" kpText:@"输入供货商名称" conType:ConTypeB];
        item2.contenText = cellModel.name;
        
        ConItem *item3 = [[ConItem alloc]initWithTitle:@"供货商颜色" kpText:@"输入供货商颜色" conType:ConTypeB];
        item3.contenText = cellModel.color;
        [model.dataArray addObject:@[item,item1,item2,item3]];
        
        
        ConItem *item4 = [[ConItem alloc]initWithTitle:@"结算单位" kpText:@"请选择结算单位" conType:ConTypeA];
        item4.contenText = cellModel.unitName;
        item4.id = cellModel.unitId;
        
        ConItem *item5 = [[ConItem alloc]initWithTitle:@"批号" kpText:@"请输入批号" conType:ConTypeB];
        item5.contenText = cellModel.batchNumber;
        
        ConItem *item6 = [[ConItem alloc]initWithTitle:@"货架" kpText:@"请输入货架" conType:ConTypeB];
        item6.contenText = cellModel.shelves;
        
        ConItem *item7 = [[ConItem alloc]initWithTitle:@"单价" kpText:@"0" conType:ConTypeB];
        item7.contenText = cellModel.price;
        
        ConItem *item8 = [[ConItem alloc]initWithTitle:@"采购数量" kpText:@"0" conType:ConTypeC];
        item8.contenText = cellModel.buyNum;
        
        ConItem *item9 = [[ConItem alloc]initWithTitle:@"入库数量" kpText:@"0" conType:ConTypeC];
        item9.contenText = cellModel.houseNum;
        if (_isFindCode) {
            item9.conType = ConTypeA;
        }
        ConItem *item10 = [[ConItem alloc]initWithTitle:@"结算数量" kpText:@"0" conType:ConTypeB];
        item10.contenText = cellModel.settlementNum;
        ConItem *item11 = [[ConItem alloc]initWithTitle:@"本应付金额" kpText:@"0" conType:ConTypeC];
        item11.textColor = [UIColor redColor];
        item11.contenText = @"0.0";
        item11.contenText = cellModel.receivableAmount;
        
        [model.dataArray addObject:@[item4,item5,item6,item7,item8,item9,item10,item11]];
        
    }
    [self.mainTable reloadData];
    
    [self getBottomData];
    
}
#pragma mark ---- 网络请求 ----
- (void)setupData{
    
}

- (void)requestImage{
	WEAKSELF
	[self.collectionVC uploadDatePhotosWithUrlStr:^(NSString *urlStr) {
		weakSelf.urlImageStr = urlStr;
        [weakSelf addCollect];
//        [weakSelf checkAddCollect];
	}];
}

/// post整个数据--最终的数据上传
#pragma mark ---- 提交接口 ----
- (void)addCollect {
//    接口名称 修改采购收货
    /// 数据都在 self.bDataArray 和  self.allCodeArray 中
    NSMutableArray *saveMuAry = [NSMutableArray array];
    
    
    
    for (int i = 0; i <self.allCodeArray.count; i++) {
        LZPurchaseReceiptSaveAlterModel *aModel = [[LZPurchaseReceiptSaveAlterModel alloc]init];
        LZPurchaseReceiptDetailCellModel *dataModel = _cellInfo[i];
        BXSAllCodeModel *allModel = self.allCodeArray[i];
        NSMutableArray *itemListMuAry = [NSMutableArray array];
        
        if (self.isFindCode) {
            //细码
//            _ximaValue = 0;
//            _ximaTotal = 0;
            for (int j = 0 ; j <allModel.findCodeArray.count; j++) {
                LZFindCodeModel *codeModel = allModel.findCodeArray[j];
                LZPurchaseReceiptSaveAlterItemListModel *itemList = [[LZPurchaseReceiptSaveAlterItemListModel alloc]init];
                itemList.total = @"1";
                itemList.value = codeModel.code;
                [itemListMuAry addObject:itemList];
//                _ximaValue = _ximaValue + itemList.value.integerValue ;
            }
//            _ximaTotal = allModel.findCodeArray.count;
        }else{
            //总码
            ConItem *conItemValue = allModel.dataArray[0][0];//结算数量（总码总数量）
            ConItem *conItemTotal = allModel.dataArray[0][1];//条数（总码条数）
            LZPurchaseReceiptSaveAlterItemListModel *itemList = [[LZPurchaseReceiptSaveAlterItemListModel alloc]init];
            itemList.value = conItemValue.contenText;
            itemList.total = conItemTotal.contenText;
//            _zongmaValue = conItemValue.contenText;
//            _zongmaTotal = conItemTotal.contenText;
            [itemListMuAry addObject:itemList];
        }
        
        ConItem *conItemName = allModel.dataArray[0][2];//供货商名称
        ConItem *conItemColor = allModel.dataArray[0][3];//供货商颜色
        ConItem *conItemUnit= allModel.dataArray[1][0];//单位
        ConItem *conItemBatchNumber= allModel.dataArray[1][1];//批号
//        ConItem *conItemShelves= allModel.dataArray[1][2];//批号
        ConItem *conItemPrice= allModel.dataArray[1][3];//单价
        ConItem *conItemBuyNum = allModel.dataArray[1][4];//采购数量
        ConItem *conItemHouseNum = allModel.dataArray[1][5];//入库数量
        ConItem *conItemSettlementNum = allModel.dataArray[1][6];//结算数量
        ConItem *conItemReceivableAmount = allModel.dataArray[1][7];//本应付金额
        
        aModel.productId = dataModel.productId;
        aModel.productColorId = dataModel.productColorId;
        aModel.number = dataModel.number;
        aModel.unitName = dataModel.unitName;
        aModel.name = conItemName.contenText;
        aModel.color = conItemColor.contenText;
        aModel.unitId = conItemUnit.id;
        aModel.batchNumber = conItemBatchNumber.contenText;
        aModel.price = conItemPrice.contenText;
        aModel.buyNum = conItemBuyNum.contenText;
        aModel.houseNum = conItemHouseNum.contenText;
        aModel.settlementNum = conItemSettlementNum.contenText;
        aModel.receivableAmount = conItemReceivableAmount.contenText;
        aModel.itemList = [itemListMuAry copy];
        aModel.buyOrderItemId = dataModel.buyOrderItemId;
        
        NSString *tempStr = [aModel mj_JSONObject];
        [saveMuAry addObject:tempStr];
    }
    
    ConItem *conItemArrearsPrice = self.bDataArray[0][2];//本单欠款
    ConItem *conItemBankId = self.bDataArray[0][3];//付款方式
    ConItem *conItemFactoryNo = self.bDataArray[1][1];//供应商单号
    ConItem *conItemHouseId = self.bDataArray[1][0];//入库存
    ConItem *conItemRealpayPrice = self.bDataArray[0][1];//实付金额
    ConItem *conItemRemarke = self.bDataArray[0][4];//备注
    ConItem *conItemCopewithPrice = self.bDataArray[0][0];//应付金额
    
    if ([BXSTools stringIsNullOrEmpty:conItemHouseId.id]) {
        BXS_Alert(@"请选择入仓库");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:conItemRealpayPrice.contenText]) {
        BXS_Alert(@"请输入实付金额");
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    param[@"arrearsPrice"] = conItemArrearsPrice.contenText == nil ? @(0) : conItemArrearsPrice.contenText;
    param[@"bankId"] = conItemBankId.id;
    param[@"buyOrderId"] = self.infoModel.id;
    param[@"copewithPrice"] = conItemCopewithPrice.contenText == nil ? @(0) : conItemCopewithPrice.contenText;
    param[@"factoryNo"] = conItemFactoryNo.contenText == nil ? @"" : conItemFactoryNo.contenText;
    param[@"houseId"] = conItemHouseId.id == nil ? @"" : conItemHouseId.id;
    param[@"imgs"] = self.urlImageStr == nil ? @"" :self.urlImageStr;
    param[@"productItems"] = [saveMuAry mj_JSONString];
    param[@"realpayPrice"] = conItemRealpayPrice.contenText == nil ? @"" : conItemRealpayPrice.contenText;
    param[@"remark"] = conItemRemarke.contenText;
    
    [BXSHttp requestPOSTWithAppURL:@"documentary/update_collect.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [self checkAddCollect];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)checkAddCollect {
//接口名称 审批入库
    /// 数据都在 self.bDataArray 和  self.allCodeArray 中
    NSMutableArray *saveMuAry = [NSMutableArray array];
    
    
//    self.allCodeArray.count为本页面有多少个产品
    for (int i = 0; i <self.allCodeArray.count; i++) {

        LZPurchaseReceiptDetailCellModel *dataModel = _cellInfo[i];
        BXSAllCodeModel *allModel = self.allCodeArray[i];
        
        ConItem *conItemShelves= allModel.dataArray[1][2];//货架
        ConItem *conItemBatchNumber= allModel.dataArray[1][1];//批号
        NSDictionary * param = @{};
        
//        allModel.findCodeArray.count为当前产品的数量和条数信息，总码就为一个，细码就多个
        
            
            if (allModel.isFindCode) {
                //细码
                for (int j = 0 ; j < allModel.findCodeArray.count; j++) {
                    LZFindCodeModel *model = allModel.findCodeArray[j];
                    param = @{
                              @"productId":dataModel.productId,
                              @"productColorId":dataModel.productColorId,
                              @"batchNumber":conItemBatchNumber.contenText,
                              @"shelves":[conItemShelves.contenText isEqualToString:@""] ? @(0) : conItemShelves.contenText,
                              @"value":model.code,
                              @"total":@(1),
                              @"storageType": @(1),
                              @"buyOrderItemIds":_buyOrderItemIds,
                              };
                    [saveMuAry addObject:param];
                }
            }else{
                //总码
                ConItem *conItemValues = allModel.dataArray[0][0];//总数量
                ConItem *conItemTotal = allModel.dataArray[0][1];//条数
                param = @{
                          @"productId":dataModel.productId,
                          @"productColorId":dataModel.productColorId,
                          @"batchNumber":conItemBatchNumber.contenText,
                          @"shelves":[conItemShelves.contenText isEqualToString:@""] ? @(0) : conItemShelves.contenText,
                          @"value":conItemValues.contenText == nil ? @"" : conItemValues.contenText,
                          @"total":conItemTotal.contenText == nil ? @"" : conItemTotal.contenText,
                          @"storageType": @(0),
                          @"buyOrderItemIds":_buyOrderItemIds,
                          };
                [saveMuAry addObject:param];
            }
            
            
            
            
            
//            if (self.isFindCode) {
//                //细码
//                param = @{
//                          @"productId":dataModel.productId,
//                          @"productColorId":dataModel.productColorId,
//                          @"batchNumber":conItemBatchNumber.contenText,
//                          @"shelves":conItemShelves.contenText,
//                          @"value":@(_ximaValue),
//                          @"total":@(_ximaTotal),
//                          @"storageType": @(1),
//                          @"buyOrderItemIds":_buyOrderItemIds,
//                          };
//            }else{
//                //总码
//                param = @{
//                          @"productId":dataModel.productId,
//                          @"productColorId":dataModel.productColorId,
//                          @"batchNumber":conItemBatchNumber.contenText,
//                          @"shelves":conItemShelves.contenText,
//                          @"value":_zongmaValue == nil ? @"" : _zongmaValue,
//                          @"total":_zongmaTotal == nil ? @"" : _zongmaTotal,
//                          @"storageType": @(0),
//                          @"buyOrderItemIds":_buyOrderItemIds,
//                          };
//            }
            
//            [saveMuAry addObject:param];
        
        
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    param[@"approvalId"] = self.Id;
    param[@"purchaserId"] = @([self.infoModel.purchaserId integerValue]);
    param[@"buyOrderId"] = self.infoModel.id;
    param[@"storageType"] = self.isFindCode == NO ? @(0) : @(1);
    param[@"productItems"] = [saveMuAry mj_JSONString];
    
//    param[@"houseId"] = conItemHouseId.id;
//    param[@"imgs"] = self.urlImageStr == nil ? @"" :self.urlImageStr;
//    param[@"productItems"] = [saveMuAry mj_JSONString];
//    param[@"realpayPrice"] = conItemRealpayPrice.contenText;
//    param[@"remark"] = conItemRemarke.contenText;
    
    
    
    [BXSHttp requestPOSTWithAppURL:@"documentary/add_house.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

/// 得到仓库数据
-(void)setupSelectData {
    {
        /// 单位 http://www.buxiaosheng.com/web-api/product_unit/list.do
        NSDictionary * param = @{
                                 @"companyId":[BXSUser currentUser].companyId,
                                 };
        
        [BXSHttp requestPOSTWithAppURL:@"product_unit/list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue]!=200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            
            self.unitArr = [ConItem LLMJParse:baseModel.data];
        } failure:^(NSError *error) {
            
        }];
        
    }
    
    {
        
        /// 银行 支付类型
        NSDictionary * param = @{
                                 @"companyId":[BXSUser currentUser].companyId,
                                 };
        [BXSHttp requestPOSTWithAppURL:@"bank/list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue]!=200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            self.bankArr = [ConItem LLMJParse:baseModel.data];
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    
    {
        /// 仓库选择
        NSDictionary * param = @{
                                 @"companyId":[BXSUser currentUser].companyId,
                                 };
        [BXSHttp requestPOSTWithAppURL:@"house/list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue]!=200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            self.houseArr = [ConItem LLMJParse:baseModel.data];
        } failure:^(NSError *error) {
            
        }];
        
    }
}




#pragma mark ---- Click ----
/// 底部确认
- (void)clickBottom {
    [self requestImage];
//    /// 选择人员
//    NSDictionary * param = @{
//                             @"companyId":[BXSUser currentUser].companyId,
//                             };
//    [BXSHttp requestPOSTWithAppURL:@"approver/list.do" param:param success:^(id response) {
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue]!=200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//
//        NSArray *arr = [ApproverModel LLMJParse:baseModel.data];
//        [self  selectWithArr:arr ofModel:nil title:SELECTAPPROVER];
//    } failure:^(NSError *error) {
//
//    }];
}

/// 支付方式
- (void)clickPayType :(ConItem *)model{
    [self selectWithArr:self.bankArr ofModel:model title:@"选择支付方式"];
}
/// 仓库选择
- (void)clickSelectCangKu :(ConItem *)model{
    [self selectWithArr:self.houseArr ofModel:model title:@"选择仓库"];
    
}

/// 结算单位
- (void)clickPayUnit:(ConItem *)model {
    
    [self selectWithArr:self.unitArr ofModel:model title:@"选择结算单位"];
    
}
/// 添加细码
- (void)clickAddCode:(BXSAllCodeModel * )model{
    
    LZFineCodeVC *VC = [LZFineCodeVC new];
    [self.navigationController pushViewController:VC animated:YES];
    
    WEAKSELF;
    
    VC.addCodeBlock = ^(NSArray<LZFindCodeModel *> *array) {
        
        for (LZFindCodeModel *codeModel in array) {
            if (codeModel.code.length > 0) {
                [model.findCodeArray addObject:codeModel];
            }
        }
        
        [weakSelf CalculationFindCodeData];
        [weakSelf.mainTable reloadData];
    };
    
}
/// 修改细码
- (void)clickChangeCodeWithModel:(LZFindCodeModel *)model {
    
    LZFineCodeVC *VC = [LZFineCodeVC new];
    [VC changeCodeWithModel:model];
    [self.navigationController pushViewController:VC animated:YES];
    
    __weak typeof(model) kModel = model;
    WEAKSELF;
    VC.changeCodeBlock = ^(LZFindCodeModel *model) {
        
        kModel.title = model.title;
        kModel.code = model.code;
        [weakSelf CalculationFindCodeData];
        [weakSelf.mainTable reloadData];
    };
}
/// 细码-修改入库

- (void)clickChangeWithIndexPath:(NSIndexPath *)indexPath {
    
    BXSAllCodeModel *model = self.allCodeArray[indexPath.section];
    
    if (model.findCodeArray.count == 0) {
        [LLHudTools showWithMessage:@"请先添加细码!"];
        return;
    }
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(30, 0, APPWidth - 30, 22)];
    head.backgroundColor = [UIColor whiteColor];
    BXSPurchaChangeWarehousingView *cView = [[BXSPurchaChangeWarehousingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, APPHeight)];
    
    cView.model = model;
    
    [BYAlertHelper sharedBYAlertHelper]
    .contentModel(BYAlertContentModeRight)
    .addSubviews(@[cView])
    .showInWindow();
    
    
    WEAKSELF;
    cView.clickChangeBlock = ^{
        [weakSelf CalculationFindCodeData];
        [weakSelf.mainTable reloadData];
    };
    
}

- (void)selectWithArr:(NSArray *)souceArr ofModel:(ConItem *)model title:(NSString *)title{
    
    BYAlertHeadView *head = [BYAlertHeadView alertHeaderTitle:title];
    head.clickCancleBlock = ^{
        [BYAlertHelper hideAlert];
    };
    AlertSheet *sheet = [[AlertSheet alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0)];
    sheet.rowHeight = 44;
    
    if ([title isEqualToString:SELECTAPPROVER]) {
        sheet.dataSource = [souceArr valueForKey:@"memberName"];
    }else{
        sheet.dataSource = [souceArr valueForKey:@"name"];
    }
    [sheet reloadData];
    WEAKSELF;
    sheet.didSelectAtRow = ^(NSInteger row, NSString *ktitle) {
        [BYAlertHelper hideAlert];
        /// 人员选择
        if ([title isEqualToString:SELECTAPPROVER]) {
            weakSelf.selectApprover = souceArr[row];
            [weakSelf requestImage];
            
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ConItem *oItem = souceArr[row];
                model.contenText = oItem.name;
                model.id = oItem.id;
                
                [weakSelf.mainTable reloadData];
            });
        }
        
    };
    //show
    [BYAlertHelper sharedBYAlertHelper].addSubviews(@[head,sheet]).showInWindow();
    
}



#pragma mark ---- table ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.bDataArray.count+self.allCodeArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < self.allCodeArray.count) {
        return 1;
    }else{
        NSArray *arr = self.bDataArray[section - self.allCodeArray.count];
        return arr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF;
    if (indexPath.section < self.allCodeArray.count) {
        BXSAllCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:_isFindCode?@"k_findID":[BXSAllCodeCell cellID]];
        
        BXSAllCodeModel *item = self.allCodeArray[indexPath.section];
        cell.item = item;
        
//        cell.clickBottomBlock = ^{
//            [weakSelf.mainTable reloadData];
//        };
        //  [cell setName:[NSString stringWithFormat:@"品名：%@",self.baseModel.data[@"productName"]]
        //        unit:[NSString stringWithFormat:@"单位：%@",self.baseModel.data[@"unitName"]]];
        cell.clickUnitBlock = ^(ConItem *bitem) {
            [weakSelf clickPayUnit:bitem];
        };
        
        if (_isFindCode) {
            cell.clickAddCodelBlock = ^(BXSAllCodeModel *bitem) {
                [weakSelf clickAddCode:bitem];
            };
            cell.clickChangeCodeBlock = ^(LZFindCodeModel *model) {
                [weakSelf clickChangeCodeWithModel:model];
            };
            
            cell.clickChangeRkBlock = ^{
                [weakSelf clickChangeWithIndexPath:indexPath];
            };
        }
        return cell;
        
    }else{
        
        ConItem *item = self.bDataArray[indexPath.section- self.allCodeArray.count][indexPath.row];
        if ([item.title isEqualToString:@"备注"]) {
            ConMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConMarkCell cellID]];
            cell.item = item;
            return cell;
        }
        
        ConCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConCell cellID]];
        cell.item = item;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section < self.allCodeArray.count) {
        BXSAllCodeModel *item = self.allCodeArray[indexPath.section];
        return item.baseCellHeight;
    }else{
        ConItem *item = self.bDataArray[indexPath.section- self.allCodeArray.count][indexPath.row];
        if ([item.title isEqualToString:@"备注"]) {
            return 80;
        }
        return 50.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [LineView lineViewOfHeight:10];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sec = indexPath.section - self.allCodeArray.count;
    if (sec<0) {
        return;
    }
    ConItem *item = self.bDataArray[sec][indexPath.row];
    
    if (sec == 0 && indexPath.row == 3) {
        [self clickPayType:item];
        
    }
    if (sec == 1 && indexPath.row == 0 ) {
        [self clickSelectCangKu:item];
    }
}

#pragma mark ---- privte ----

/// 计算底部的数量
- (void)getBottomData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat allCount = 0.0f;
        NSInteger allUnit = 0;
        
//        for (BXSAllCodeModel *model in self.allCodeArray) {
//            ConItem *item = model.dataArray[0][0];
//            allCount += item.contenText.floatValue;
//
//            ConItem *item1 = model.dataArray[0][1];
//            allUnit += item1.contenText.integerValue;
//        }
        
        if (self.isFindCode) {
            //细码
            for (int i = 0; i <self.allCodeArray.count ; i++) {
                BXSAllCodeModel *model = self.allCodeArray[i];
                for (int j = 0; j <model.findCodeArray.count; j++) {
                    LZFindCodeModel *codeModel = model.findCodeArray[j];
                    allCount += codeModel.code.floatValue;
                    allUnit += 1;
                }
            }
        }else{
            //总码
            for (int i = 0; i <self.allCodeArray.count ; i++) {
                BXSAllCodeModel *model = self.allCodeArray[i];
                ConItem *conItemValue = model.dataArray[0][0];//结算数量（总码总数量）
                ConItem *conItemTotal = model.dataArray[0][1];//条数（总码条数）
                allCount += conItemValue.contenText.floatValue;
                allUnit += conItemTotal.contenText.floatValue;
//                for (int j = 0; j <model.findCodeArray.count; j++) {
//                    LZFindCodeModel *codeModel = model.findCodeArray[j];
//                    allCount += codeModel.code.floatValue;
//                    allUnit += 1;
//                }
            }
            
        }
        
        [self.bottomView setupCount:[NSString stringWithFormat:@"总数量:%.1f",allCount]
                        bottomCount:[NSString stringWithFormat:@"总条数:%ld",allUnit]];
    });
}
/// 计算每一个总吗的价格
- (void)setPerItem {
    
    CGFloat allPrice = 0.0f;
    
    for (BXSAllCodeModel *model in self.allCodeArray) {
        
        // 单价 * 结算的个数
        ConItem *item = model.dataArray[1][3];
        ConItem *item1 = model.dataArray[1][6];
        
        // 应该价格
        ConItem *item2 = model.dataArray[1][7];
        item2.contenText = [NSString stringWithFormat:@"%.1f",item.contenText.floatValue * item1.contenText.floatValue];
        allPrice += item2.contenText.floatValue;
    }
    // 应该付钱
    ConItem *item0 = self.bDataArray[0][0];
    item0.contenText = [NSString stringWithFormat:@"%.1f",allPrice];
    
    // 实际付钱
    ConItem *item1 = self.bDataArray[0][1];
    // 欠钱
    ConItem *item2 = self.bDataArray[0][2];
    
    item2.contenText = [NSString stringWithFormat:@"-%.1f",allPrice -item1.contenText.floatValue];
    if (allPrice -item1.contenText.floatValue < 0) {
        item2.contenText = @"0.0";
    }
}
/// 计算细码
- (void)CalculationFindCodeData {
    
    for (BXSAllCodeModel *model in self.allCodeArray) {
        
        CGFloat allCode = 0.0f;
        for (LZFindCodeModel *codeModel in model.findCodeArray) {
            allCode += [codeModel.code floatValue];
        }
        ConItem *item = model.dataArray[0][0];
        item.contenText = [NSString stringWithFormat:@"%.1f",allCode];
        
        ConItem *item1 = model.dataArray[0][1];
        item1.contenText = [NSString stringWithFormat:@"%ld",model.findCodeArray.count];
        
        ConItem *citem = model.dataArray[1][4];
        ConItem *kuItem = model.dataArray[1][5];
        ConItem *jItem = model.dataArray[1][6];
        citem.contenText = kuItem.contenText = jItem.contenText = item.contenText;
    }
    
    [self setPerItem];
    [self getBottomData];
    
}



@end
