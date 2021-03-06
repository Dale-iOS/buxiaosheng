//
//  BackOrderViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  退单页面

#import "BackOrderViewController.h"
#import "IQKeyboardManager.h"
#import "LZBackOrderCell.h"
#import "LZBackOrderGroup.h"
#import "LZBackOrderItem.h"
#import "LZSelectItemViewController.h"
#import "LZAddItemViewController.h"
#import "LZPickerView.h"
#import "LZSearchVC.h"
#import "LZChooseProductsVC.h"
#import "LZChangeNumVC.h"
#import "LZBackOrderListsVC.h"
#import "ZWCustomPopView.h"
#import "BackOrderViewController+Request.h"
#import "NSObject+YYModel.h"
#import "LZBackOrderSaveModel.h"
#import "LZBackOrderInfoModel.h"
#import "UITextField+PopOver.h"

@interface BackOrderViewController ()<UITableViewDataSource, UITableViewDelegate, LZBackOrderCellDelegate, ZWCustomPopViewDelegate,UITextFieldDelegate>
{
    NSString *_productId;//产品id
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *totalNumLb;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLb;
@property (weak, nonatomic) ZWCustomPopView *popView;
@property (nonatomic, strong) NSMutableArray<LZBackOrderGroup *> *dataSource;
@property (nonatomic, strong) LZBackOrderGroup *sectionGroup;
@property (nonatomic, strong) NSMutableArray *saveMuAry;
@property (nonatomic, strong) LZBackOrderInfoModel *infoModel;

@property (nonatomic,strong) NSIndexPath *currentOperateIndexPath;
@property (nonatomic,strong) NSMutableArray *yardStrings;

@end

@implementation BackOrderViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [Utility navTitleView:@"退单"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toListClisk) image:IMAGE(@"new_lists")];
    //拖动tableView回收键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeYards:) name:kChangeYardNotification object:nil];
    //网络请求
    [self setupCustomerList];
    [self setupWarehouseLists];
    [self setupPayList];
    [self setupApproverList];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.bottomConstraint.constant = self.view.safeAreaInsets.bottom;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = YES;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - Private Methods

//计算底部总数量 总条数
- (void)calculateTotal {
    //总数量
    double totalCount = 0;
    //总条数
    double totalNumber = 0;
    //应付金额 预收金额
    double totalPrice = 0;
    for (int i = 1; i < self.dataSource.count - 1; i++) {
        LZBackOrderGroup *group = self.dataSource[i];
        if ([group.storageType isEqualToString:@"1"]) {
            //细码
            for (NSString *itemStr in group.itemStrings) {
                totalCount += itemStr.doubleValue;
            }
            totalNumber += group.itemStrings.count;
        } else {
            //总码
            totalCount += group.items[3].detailTitle.doubleValue;
            totalNumber += group.items[4].detailTitle.doubleValue;
        }
        NSInteger itemCount = group.items.count;
        
        LZBackOrderItem *item = group.items[itemCount - 2];
        totalPrice += item.detailTitle.doubleValue;
    }
    //应付金额
    LZBackOrderGroup *lastGroup = self.dataSource.lastObject;
    [lastGroup.items[1] setDetailTitle:[BXSTools notRounding:totalPrice afterPoint:1]];
    if ([BXSTools isEmptyString:[lastGroup.items[2] detailTitle]]) {
        //预收付款
        [lastGroup.items[3] setDetailTitle:[BXSTools notRounding:totalPrice afterPoint:1]];
    } else {
        NSInteger realPay = lastGroup.items[2].detailTitle.integerValue;
        [lastGroup.items[3] setDetailTitle:[BXSTools notRounding:(totalPrice - realPay) afterPoint:1]];
    }
    
    _totalNumLb.text = [NSString stringWithFormat:@"总数量: %@", [BXSTools notRounding:totalCount afterPoint:1]];
    _totalCountLb.text = [NSString stringWithFormat:@"总条数: %@", [BXSTools notRounding:totalNumber afterPoint:1]];
}

//计算分区的相关数据
- (void)caculateSectionDataWithGroup:(LZBackOrderGroup *)group indexPath:(NSIndexPath *)indexPath shouldChange:(BOOL)shouldChange {
    if (group.items.count > 11) {
        //数量
        double totalCount = 0.0;
        //条数
        NSString *totalNumberStr = @"0";
        if ([group.storageType isEqualToString:@"1"]) {
            //细码
            if (group.itemStrings.count > 0) {
                if (indexPath.row == 3) {
                    LZBackOrderItem *item = group.items[3];
                    item.textTitle = [NSString stringWithFormat:@"细码 (总条数: %ld )", group.itemStrings.count];
                }
                //细码的个数
                for (NSString *string in group.itemStrings) {
                    totalCount += string.doubleValue;
                }
                totalNumberStr = [BXSTools notRounding:totalCount afterPoint:1];
            }
        } else {
            //总码
            totalCount = group.items[3].detailTitle.doubleValue;
            LZBackOrderItem *item = group.items[3];
            if (![BXSTools isEmptyString:item.detailTitle]) {
                totalNumberStr = item.detailTitle;
            }
            
        }
        //单价
        __block LZBackOrderItem *priceItem = nil;
        __block NSInteger priceItenIndex;
        [group.items enumerateObjectsUsingBlock:^(LZBackOrderItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isCanInput && obj.isMandatoryOption) {
                priceItem = obj;
                priceItenIndex = idx;
                *stop = YES;
            }
        }];
        double price = [priceItem.detailTitle doubleValue];
    
        //入库数量
        group.items[priceItenIndex + 1].detailTitle = totalNumberStr;
        //标签数量
        group.items[priceItenIndex + 2].detailTitle = totalNumberStr;
        if (shouldChange) {
            //结算数量
            group.items[priceItenIndex + 3].detailTitle = totalNumberStr;
            //本单退款金额
            group.items[priceItenIndex + 4].detailTitle = [BXSTools notRounding:price * totalCount afterPoint:1];
        } else {
            //结算数量
            double settleCount =  group.items[priceItenIndex + 3].detailTitle.doubleValue;
            //本单退款金额
            group.items[priceItenIndex + 4].detailTitle = [BXSTools notRounding:price * settleCount afterPoint:1];
        }
        
    }
    [self calculateTotal];
    [self.tableView reloadData];
}

//添加为细码样式
- (void)addFineYardsStyleWithGroup:(LZBackOrderGroup *)group {
    [self createFineYardsItemWithGroup:group];
    NSInteger section = [self.dataSource indexOfObject:group];
    if (group.isFold) {
        NSInteger rowCount = [self tableView:self.tableView numberOfRowsInSection:section];
        [group.items exchangeObjectAtIndex:(group.items.count - 1) withObjectAtIndex:(rowCount - 1)];
        [group.items exchangeObjectAtIndex:3 withObjectAtIndex:rowCount];
    }
    [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:section newDataCount:group.items.count];
}

//添加为总码样式
- (void)addTotalSizeItemWithGroup:(LZBackOrderGroup *)group {
    [self createTotalSizeItemWithGroup:group];
    NSInteger section = [self.dataSource indexOfObject:group];
    if (group.isFold) {
        NSInteger rowCount = [self tableView:self.tableView numberOfRowsInSection:section];
        [group.items exchangeObjectAtIndex:(rowCount - 1) withObjectAtIndex:(rowCount + 1)];
    }
    [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:section newDataCount:group.items.count];
}

#pragma mark - Actions
- (void)changeYards:(NSNotification *)sender {
    self.yardStrings = [NSMutableArray array];
    NSInteger type = [sender.object integerValue];
    LZBackOrderGroup *group = self.dataSource[self.currentOperateIndexPath.section];
    for (NSString *yardString in group.itemStrings) {
        double yard = yardString.doubleValue;
        if (AdditionBtnClick == type) {
            yard += 1;
        } else if (SubtractionBtnClick == type) {
            yard -= 1;
            if (yard < 0) {
                yard = 0.0;
            }
        } else if (MultiplicationBtnClick == type) {
            yard *= 0.99;
        } else if (DivisionBtnClick == type) {
            yard /= 0.99;
        }
        [self.yardStrings addObject:[BXSTools notRounding:yard afterPoint:1]];
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LZBackOrderGroup *group = self.dataSource[section];
    if (group.fold) return 4;
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    LZBackOrderCell *cell = [LZBackOrderCell cellWithTableView:tableView cellType:item.cellType];
    cell.group = group;
    cell.item = item;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView sd_clearSubviewsAutoLayoutFrameCaches];
    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(223, 224, 231);
    return view;
}

#pragma mark - LZBackOrderCellDelegate
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell btnClickType:(BtnClickType)type forIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    switch (type) {
        case BtnClickTypeFold:
        {
            group.fold = !group.isFold;
            [group.items exchangeObjectAtIndex:3 withObjectAtIndex:(group.items.count - 1)];
            [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:indexPath.section newDataCount:group.items.count];
        }
            break;
        case BtnClickTypeAddYard:
        {
            [self.dataSource enumerateObjectsUsingBlock:^(LZBackOrderGroup * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.hiddenAddYard = YES;
            }];
            [self.dataSource insertObject:[self createSectionGroupItem] atIndex:(indexPath.section + 1)];
            [self.tableView reloadData];
        }
            break;
        case BtnClickTypeAddItem:
        {
            LZAddItemViewController *vc = [[LZAddItemViewController alloc] init];
            vc.selectItems = ^(NSArray *items) {
                for (NSString *string in items) {
                    [group.itemStrings addObject:string];
                }
                [self caculateSectionDataWithGroup:group indexPath:indexPath shouldChange:YES];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)backOrderCell:(LZBackOrderCell *)backOrderCell selectItemForIndexPath:(NSIndexPath *)indexPath {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZBackOrderItem *item = group.items[indexPath.row];
    WEAKSELF;
    if ((LZSelectItemVCSelectType)item.clickType == ClickTypeProduct) {
        
        //选择产品
        LZChooseProductsVC * vc = [LZChooseProductsVC new];
        [vc setSelectVCBlock:^(LZProductDetailModel *seletedModel) {
            item.detailTitle = seletedModel.name;
            _productId = seletedModel.id;
            //            seletedModel.unitName 产品单位
            //            seletedModel.unitId 产品id
            //            seletedModel.storageType 为0是总码 为1是细码
            LZBackOrderItem *threeItem = group.items[2];
            item.selectId = seletedModel.id;
            threeItem.detailTitle = seletedModel.unitName;
            
            if ([BXSTools isEmptyString:threeItem.detailTitle] || ![group.storageType isEqualToString:seletedModel.storageType]) {
                group.storageType = seletedModel.storageType;
                [group.itemStrings removeAllObjects];
                if ([seletedModel.storageType isEqualToString:@"1"]) {
                    [weakSelf addFineYardsStyleWithGroup:group];
                } else {
                    [weakSelf addTotalSizeItemWithGroup:group];
                }
            } else {
                [self.tableView reloadDataWithInsertingDataAtTheBeginingOfSection:indexPath.section newDataCount:group.items.count];
            }
        }];
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeColor){
        
        //选择颜色
        if ([BXSTools isEmptyString:_productId]) {
            [LLHudTools showWithMessage:@"请选择品名"];
            return;
        }
        LZSearchVC * colorVC = [LZSearchVC new];
        colorVC.productId = _productId;
        colorVC.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
            item.detailTitle = seletedModel.name;
            item.selectId = seletedModel.id;
            [weakSelf.tableView reloadData];
        };
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:colorVC animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeWarehouse){
        
        //选择仓库
        if (_warehouseNameAry.count <1) {
            [LLHudTools showWithMessage:@"暂无仓库，请在“设置 - 仓库”中添加"];
            return;
        }
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_warehouseNameAry titleDataArray:nil];
        
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            item.detailTitle = compoentString;
            NSInteger row = [titileString integerValue];
            item.selectId = weakSelf.warehouseIdAry[row];
            [weakSelf.tableView reloadData];
        };
        [self.view addSubview:pickerView];
        
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypePayMentWay){
        
        //选择支付方式
        if (_payNameAry.count <1) {
            [LLHudTools showWithMessage:@"暂无收款方式，请在“设置 - 现金银行”中添加"];
            return;
        }
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_payNameAry titleDataArray:nil];
        
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            item.detailTitle = compoentString;
            NSInteger row = [titileString integerValue];
            item.selectId = weakSelf.payIdAry[row];
            [weakSelf.tableView reloadData];
        };
        [self.view addSubview:pickerView];
    }else if ((LZSelectItemVCSelectType)item.clickType == ClickTypeChangeNum){
        if ([group.storageType isEqualToString:@"0"] || group.itemStrings.count == 0) return;
        self.currentOperateIndexPath = indexPath;
        
        NSInteger index = [group.items indexOfObject:item];
        LZBackOrderItem *tagNumItem = [group.items objectAtIndex:index - 1];
        NSString *tmpString = tagNumItem.detailTitle;
        
        //标签数量
        LZChangeNumVC *vc = [LZChangeNumVC new];
        vc.type = LZChangeNumVCTypeBackOrder;
        vc.originalValue = [item.detailTitle doubleValue];
        vc.lineValue = group.itemStrings.count;
        [vc setNumValueBlock:^(NSString *ValueStr) {
            //修改细码
            [group.itemStrings setArray:weakSelf.yardStrings];
            //计算分区细码
            [weakSelf caculateSectionDataWithGroup:group indexPath:indexPath shouldChange:YES];
            tagNumItem.detailTitle = tmpString;
            //刷新
            [weakSelf.tableView reloadData];
        }];
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
    }
    
}

- (void)backOrderCell:(LZBackOrderCell *)backOrderCell reloadForIndexPath:(NSIndexPath *)indexPath shouldChange:(BOOL)shouldChange {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    [self caculateSectionDataWithGroup:group indexPath:indexPath shouldChange:shouldChange];
}

//修改细码
-(void)backOrderCell:(LZBackOrderCell *)backOrderCell modifyItemForIndexPath:(NSIndexPath *)indexPath index:(NSInteger)index {
    LZBackOrderGroup *group = self.dataSource[indexPath.section];
    LZAddItemViewController *vc = [[LZAddItemViewController alloc] init];
    vc.itemDetail = group.itemStrings[index];
    vc.modifyItem = YES;
    vc.selectItems = ^(NSArray *items) {
        [group.itemStrings replaceObjectAtIndex:index withObject:items.firstObject];
        [self caculateSectionDataWithGroup:group indexPath:indexPath shouldChange:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//点击客户名称
- (void)backOrderCell:(LZBackOrderCell *)backOrderCell popViewForIndexPath:(NSIndexPath *)indexPath textField:(UITextField *)textField {
	textField.delegate = self;
	textField.scrollView = (UIScrollView *)self.view;
	textField.positionType  = ZJPositionBottomThree;
	WEAKSELF;
	[textField popOverSource:_nameArray index:^(NSInteger index) {
		weakSelf.infoModel.customerId = weakSelf.customerIdAry[index];
		NSString *name = weakSelf.nameArray[index];
		LZBackOrderGroup *group = weakSelf.dataSource.firstObject;
		LZBackOrderItem *item = group.items.firstObject;
		item.detailTitle = name;
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
		//		[self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

		NSString *mobile = weakSelf.customerMobileAry[index];
		LZBackOrderItem *item2 = group.items.lastObject;
		item2.detailTitle = mobile;
		[weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
	}];
}
#pragma mark - Getter && Setter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[].mutableCopy;
        NSString *plistString = [[NSBundle mainBundle] pathForResource:@"BackOrder" ofType:@"plist"];
        NSArray *groupDictArray = [NSArray arrayWithContentsOfFile:plistString];
        for (NSDictionary *groupDict in groupDictArray) {
            LZBackOrderGroup *group = [LZBackOrderGroup modelWithDictionary:groupDict];
            [_dataSource addObject:group];
        }
    }
    return _dataSource;
}

//接口名称 退单
- (IBAction)saveClick:(id)sender {
    
    _saveMuAry = [NSMutableArray array];
    
    for (int i = 1; i <= _dataSource.count -2; i++) {
        LZBackOrderGroup *group = [LZBackOrderGroup new];
        LZBackOrderSaveModel *backOrderSaveModel = [LZBackOrderSaveModel new];
        NSMutableArray *itemListMuAry = [NSMutableArray array];
        group = _dataSource[i];
        NSArray *groupAry = group.items;
        NSMutableArray *detailMuAry = [NSMutableArray array];
        for (int j = 0; j <groupAry.count; j++) {
            LZBackOrderItem *item = groupAry[j];
            if (item.selectId != nil) {
                [detailMuAry addObject:item.selectId];
            }else{
                [detailMuAry addObject:item.detailTitle];
            }
        }

            backOrderSaveModel.productId = detailMuAry[0];
            backOrderSaveModel.productColorId = detailMuAry[1];
            backOrderSaveModel.batchNumber = detailMuAry[4];
            backOrderSaveModel.shelves = detailMuAry[5];
            backOrderSaveModel.price = detailMuAry[6];
            backOrderSaveModel.houseNum = detailMuAry[7];
            backOrderSaveModel.labelNum = detailMuAry[8];
            backOrderSaveModel.settlementNum = detailMuAry[9];
            backOrderSaveModel.refundAmount = detailMuAry[10];
            if (group.itemStrings.count >0) {
                for (int k = 0 ; k < group.itemStrings.count; k++) {
                    LZBackOrderSaveItemList *backOrderSaveItemList = [LZBackOrderSaveItemList new];
                    backOrderSaveItemList.value = group.itemStrings[k];
                    backOrderSaveItemList.total = @"1";
                    [itemListMuAry addObject:backOrderSaveItemList];
                }
            }else{
                LZBackOrderSaveItemList *backOrderSaveItemList = [LZBackOrderSaveItemList new];
                backOrderSaveItemList.value = detailMuAry[3];
                backOrderSaveItemList.total = detailMuAry[4];
                [itemListMuAry addObject:backOrderSaveItemList];
            }
            backOrderSaveModel.itemList = [itemListMuAry copy];
        
        [_saveMuAry addObject:backOrderSaveModel];
    }
    
    //入库存到备注之间的信息
    //把信息存到model
    LZBackOrderGroup *infoGroup = [LZBackOrderGroup new];
    infoGroup = _dataSource.lastObject;
    for (int i = 0 ; i <infoGroup.items.count ; i++) {
        LZBackOrderItem *item = infoGroup.items[i];
        if ([item.textTitle isEqualToString:@"*入仓库"]) {
            self.infoModel.houseId = item.selectId;
        }
        if ([item.textTitle isEqualToString:@"应付金额"]) {
            self.infoModel.copewithPrice = item.detailTitle;
        }
        if ([item.textTitle isEqualToString:@"实付金额"]) {
            self.infoModel.realpayPrice = item.detailTitle;
        }
        if ([item.textTitle isEqualToString:@"预收付款"]) {
            self.infoModel.deposit = item.detailTitle;
        }
        if ([item.textTitle isEqualToString:@"付款方式"]) {
            self.infoModel.bankId = item.selectId;
        }
        if ([item.textTitle isEqualToString:@"备注"]) {
            self.infoModel.remark = item.detailTitle;
        }
    }
    

    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.approverNameAry titleDataArray:nil];
    WEAKSELF;
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        NSInteger row = [titileString integerValue];
        _infoModel.approverId = weakSelf.approverIdAry[row];
        [weakSelf.tableView reloadData];
        [weakSelf requestData];
    };
    [self.view addSubview:pickerView];
    
}

//提交请求
- (void)requestData{
    
    NSMutableArray <NSString *> *tempSaveMuAry = [NSMutableArray array];
    for (int i = 0; i < _saveMuAry.count; i++) {
        LZBackOrderSaveModel *model = _saveMuAry[i];
        [tempSaveMuAry addObject:[model mj_JSONObject]];
    }
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"approverId":self.infoModel.approverId,
                             @"bankId":self.infoModel.bankId,
                             @"copewithPrice":self.infoModel.copewithPrice,
                             @"customerId":self.infoModel.customerId,
                             @"deposit":self.infoModel.deposit,
                             @"houseId":self.infoModel.houseId,
                             @"productItems":[tempSaveMuAry mj_JSONString],
                             @"realpayPrice":self.infoModel.realpayPrice,
                             @"remark":self.infoModel.remark
                             };
    [BXSHttp requestGETWithAppURL:@"refund/add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];

}

- (NSArray *)nameArray {
    if (_nameArray == nil) {
        _nameArray = @[];
    }
    return _nameArray;
}

- (LZBackOrderInfoModel *)infoModel{
    if (_infoModel == nil) {
        _infoModel = [LZBackOrderInfoModel new];
    }
    return _infoModel;
}

#pragma mark ---- ActionClick ----
- (void)toListClisk{
    [self.navigationController pushViewController:[LZBackOrderListsVC new] animated:YES];
}

@end
