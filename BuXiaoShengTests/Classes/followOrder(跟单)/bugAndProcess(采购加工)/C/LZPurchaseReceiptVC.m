//
//  LZPurchaseReceiptVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购收货页面

#import "LZPurchaseReceiptVC.h"

#import "BXSMachiningBottomView.h"
#import "BXSAllCodeCell.h"
#import "LZFineCodeVC.h"
#import "ConCell.h"
#import "ApproverModel.h"
#import "BXSPurchaChangeWarehousingView.h"
#import "BaseTableVC+BXSTakePhoto.h"
#import "LZPurchaseReceiptDataModel.h"

#define  SELECTAPPROVER @"选择人员"
@interface LZPurchaseReceiptVC ()<UITableViewDataSource,UITableViewDelegate>
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
@property (strong,nonatomic)LZPurchaseReceiptDataModel *dataModel;
/// UI

@property (strong,nonatomic)UIButton * addPhotoButton;
@end

@implementation LZPurchaseReceiptVC

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
    [self setupData];
    
    
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
    [self.mainTable registerClass:[BXSAllCodeCell class] forCellReuseIdentifier:_isFindCode?@"k_findID":[BXSAllCodeCell cellID]];
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
    [self setTableFooterTakePhoto];
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
    
    for (BXSAllCodeModel *model in self.allCodeArray ) {
        
        [model.dataArray removeAllObjects];
        
        ConItem *item = [[ConItem alloc]initWithTitle:@"总数量" kpText:@"输入数量" conType:ConTypeB];
        ConItem *item1 = [[ConItem alloc]initWithTitle:@"条数" kpText:@"输入条数" conType:ConTypeB];
        ConItem *item2 = [[ConItem alloc]initWithTitle:@"供货商名称" kpText:@"输入供货商名称" conType:ConTypeB];
        ConItem *item3 = [[ConItem alloc]initWithTitle:@"供货商颜色" kpText:@"输入供货商颜色" conType:ConTypeB];
        [model.dataArray addObject:@[item,item1,item2,item3]];
        
        
        ConItem *item4 = [[ConItem alloc]initWithTitle:@"结算单位" kpText:@"请选择结算单位" conType:ConTypeA];
        ConItem *item5 = [[ConItem alloc]initWithTitle:@"批号" kpText:@"请输入批号" conType:ConTypeB];
        ConItem *item6 = [[ConItem alloc]initWithTitle:@"货架" kpText:@"请输入货架" conType:ConTypeB];
        ConItem *item7 = [[ConItem alloc]initWithTitle:@"单价" kpText:@"0" conType:ConTypeB];
        
        ConItem *item8 = [[ConItem alloc]initWithTitle:@"采购数量" kpText:@"0" conType:ConTypeC];
        
        ConItem *item9 = [[ConItem alloc]initWithTitle:@"入库数量" kpText:@"0" conType:ConTypeC];
        if (_isFindCode) {
            item9.conType = ConTypeA;
        }
        ConItem *item10 = [[ConItem alloc]initWithTitle:@"结算数量" kpText:@"0" conType:ConTypeB];
        ConItem *item11 = [[ConItem alloc]initWithTitle:@"本应付金额" kpText:@"0" conType:ConTypeC];
        item11.textColor = [UIColor redColor];
        item11.contenText = @"0";
        [model.dataArray addObject:@[item4,item5,item6,item7,item8,item9,item10,item11]];
        
    }
    
}
#pragma mark ---- 网络请求 ----
- (void)setupData{
//    接口名称 采购加工跟踪-未处理详情
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
        _dataModel = [LZPurchaseReceiptDataModel LLMJParse:baseModel.data];
        
        
        
        self.baseModel = baseModel;
        self.allCodeArray = [BXSAllCodeModel LLMJParse:baseModel.data[@"itemList"]];
        if (_isFindCode && self.allCodeArray.count >0) {
            [self.allCodeArray setValue:@"YES" forKey:@"isFindCode"];
        }
        [self initAllCodeData];
        
        // 供应名称 联系人 电话 地址
        ConItem *item1 = self.bDataArray[1][2];
        item1.contenText = [baseModel.data valueForKey:@"factoryName"];
        ConItem *item2 = self.bDataArray[1][3];
        item2.contenText = [baseModel.data valueForKey:@"contactName"];
        ConItem *item3 = self.bDataArray[1][4];
        item3.contenText = [baseModel.data valueForKey:@"mobile"];
        ConItem *item4 = self.bDataArray[1][5];
        item4.contenText = [baseModel.data valueForKey:@"address"];
        
        [self.mainTable reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

/// post整个数据--最终的数据上传
#pragma mark ---- 提交数据 ----
- (void)addCollect {
//    接口名称 新增采购收货
    /// 数据都在 self.bDataArray 和  self.allCodeArray 中
    
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    
    WEAKSELF;
    [BXSHttp requestPOSTWithAppURL:@"documentary/add_collect.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark ---- Click ----
/// 底部确认
- (void)clickBottom {
    
    /// 选择人员
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestPOSTWithAppURL:@"approver/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
        NSArray *arr = [ApproverModel LLMJParse:baseModel.data];
        [self  selectWithArr:arr ofModel:nil title:SELECTAPPROVER];
    } failure:^(NSError *error) {
        
    }];
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
            [weakSelf addCollect];
            
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
        
        cell.clickBottomBlock = ^{
            [weakSelf.mainTable reloadData];
        };
        [cell setName:[NSString stringWithFormat:@"品名：%@",self.baseModel.data[@"productName"]]
                 unit:[NSString stringWithFormat:@"单位：%@",self.baseModel.data[@"unitName"]]];
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
        for (BXSAllCodeModel *model in self.allCodeArray) {
            ConItem *item = model.dataArray[0][0];
            allCount += item.contenText.floatValue;
            
            ConItem *item1 = model.dataArray[0][1];
            allUnit += item1.contenText.integerValue;
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
        citem.kpText = kuItem.contenText = jItem.contenText = item.contenText;
    }
    
    [self setPerItem];
    [self getBottomData];
    
}

@end
