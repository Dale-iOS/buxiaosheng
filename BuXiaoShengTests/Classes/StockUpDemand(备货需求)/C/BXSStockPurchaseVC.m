
//
//  BXSStockMachiningVC.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  备货需求页面(采购)

#import "BXSStockPurchaseVC.h"

#import "UITextView+Placeholder.h"
#import "LZChoosseWorkerVC.h"
#import "LZSearchVC.h"
#import "LZPurchaseModel.h"
#import "BXSStockProductCell.h"
#import "ConCell.h"
#import "BXSMachiningBottomView.h"
#import "UITextField+PopOver.h"
#import "LZCompanyModel.h"

@interface BXSStockPurchaseVC ()<UITableViewDelegate,UITableViewDataSource,ConItemDelegate,UITextFieldDelegate,BXSStockProductCellDelegate>
/// 产品模型
@property (strong,nonatomic)NSMutableArray <LZPurchaseModel*>*purchaseModelArray ;
/// 底部view
@property (weak,nonatomic)BXSMachiningBottomView *bottomView;
/// 底部备注
@property (weak,nonatomic)UITextView *txV;
// 加工商模型
@property (strong,nonatomic)NSMutableArray <LZCompanyModel *>*processorsModelArray;
@property (strong,nonatomic)NSMutableArray *processorsModelNameArray;
@property (strong,nonatomic)NSMutableArray *processorsModelIdArray;
@property (nonatomic, strong) NSString *factoryId;//厂商id
//产品数组
@property (nonatomic, strong) NSMutableArray <productListModel *> *products;
@property (nonatomic, strong) NSMutableArray *productsListNameArray;//展示图产品列表名称数组
@property (nonatomic, strong) NSMutableArray *productsListIdArray;//展示图产品列表ID数组
@end

@implementation BXSStockPurchaseVC
/// 懒加载
- (NSMutableArray *)purchaseModelArray {
    if (!_purchaseModelArray) {
        _purchaseModelArray = [NSMutableArray array];
    }
    return _purchaseModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self requestData];
    
    [self setupHeader];
    [self setupFooter];
    [self setupBottom];
    [self loadDataWithType:0];
}

- (void)setup {
    
    
    self.mainTable.sd_resetLayout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    self.mainTable.tableFooterView = [UIView new];
    
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.backgroundColor = [UIColor whiteColor];
    //cell
    [self.mainTable registerClass:[ConCell class] forCellReuseIdentifier:[ConCell cellID]];
    self.mainTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.mainTable registerClass:[BXSStockProductCell class] forCellReuseIdentifier:[BXSStockProductCell cellID]];
    
}

/// 头部设置
- (void)setupHeader {
    
    CGFloat topHeight = 35;
    CGFloat titleH = 40;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, topHeight + titleH)];
    self.mainTable.tableHeaderView = header;
    
    LineView *line = [LineView lineViewOfHeight:5];
    [header addSubview:line];
    
    UILabel *addLabel = [UILabel labelWithColor:CD_Text33 font:FONT(14)];
    addLabel.text = @"添加采购品名";
    [header addSubview:addLabel];
    addLabel.frame = CGRectMake(15, line.bottom, 200, topHeight - 5);
    
    UIView *topView = [UIView new];
    topView.backgroundColor = RGB(249, 249, 249);
    topView.frame = CGRectMake(0, addLabel.bottom, APPWidth, titleH);
    [header addSubview:topView];
    
    
    NSArray *titles = @[@"品名",@"颜色",@"需求量"];
    CGFloat TW = APPWidth/titles.count;
    for (int i=0;i<titles.count;i++) {
        NSString *t = titles[i];
        UILabel *label = [UILabel labelWithColor:CD_Text33 font:FONT(14)];
        [topView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = t;
        label.frame = CGRectMake(i*TW, 0, TW, topView.height);
    }
    
    
}
- (void)setupFooter {
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    [footer addSubview:[LineView lineViewOfHeight:10]];
    UILabel *bzL = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 50, 20)];
    bzL.text = @"备注";
    bzL.font = FONT(15);
    [footer addSubview:bzL];
    
    //textView
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(bzL.right+50, 20, SCREEN_WIDTH - (bzL.right+60), 40)];
    [footer addSubview:tv];
    tv.font = FONT(14);
    tv.placeholder = @"请输入备注内容";
    self.txV = tv;
    self.mainTable.tableFooterView = footer;
}

/// 设置底部View
- (void)setupBottom {
    
    //bottomView
    BXSMachiningBottomView *bottomView = [BXSMachiningBottomView bottomView];
    
    self.bottomView = bottomView;
    [self.view addSubview:bottomView];
    bottomView.sd_layout
    .topSpaceToView(self.mainTable, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    
    [bottomView setupCount:@"总需求量:0" bottomCount:@"总数量:0"];
    
    //click
    WEAKSELF;
    bottomView.clickBottomTrue = ^{
        [weakSelf clickBottom];
    };
    
}

- (void)requestData {
    
    [self.dataSource addObject:[NSMutableArray arrayWithObject:@[]]];
    NSMutableArray *bArray = [NSMutableArray array];
    
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"*供货商名称" kpText:@"请输入供货商名称" conType:ConTypeB];
    item1.delegate = self;
    ConItem *item2 = [[ConItem alloc]initWithTitle:@"联系人" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item3 = [[ConItem alloc]initWithTitle:@"电话" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item4 = [[ConItem alloc]initWithTitle:@"地址" kpText:@"请先选择加工商" conType:ConTypeC];
    ConItem *item5 = [[ConItem alloc]initWithTitle:@"*指派人" kpText:@"请选择指派人" conType:ConTypeA];
    item5.titleColor = [UIColor redColor];
    
    [bArray addObjectsFromArray:@[item1,item2,item3,item4]];
    [self.dataSource addObject:bArray];
    
    [self.dataSource addObject:@[item5]];
}

#pragma mark ---- 网络请求 ----
- (void)loadDataWithType:(NSInteger )type {
    
    WEAKSELF;
//功能用到产品列表
    {
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 };
        [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
            LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                return ;
            }
//            self.dataMuArray = [productListModel LLMJParse:baseModel.data];
            
            weakSelf.products = [productListModel LLMJParse:baseModel.data];
            //拼接要展示的列表数据
            weakSelf.productsListNameArray = [NSMutableArray array];
            weakSelf.productsListIdArray = [NSMutableArray array];
            if (weakSelf.products) {
                for (int i = 0; i <weakSelf.products.count; i++) {
                    productListModel *model = [productListModel LLMJParse:weakSelf.products[i]];
                    [weakSelf.productsListNameArray addObject:model.name];
                    [weakSelf.productsListIdArray addObject:model.id];
                }
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    //    接口名称 功能用到厂商列表
    {
        ///类型（0：供货商 1：生产商 2：加工商）
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"type":@(type)
                                 };
        [BXSHttp requestGETWithAppURL:@"factory/search_list.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            
            if (type == 0) {
                //加载供货商模型
                weakSelf.processorsModelArray = [LZCompanyModel LLMJParse:baseModel.data];
                weakSelf.processorsModelNameArray = [NSMutableArray array];
                weakSelf.processorsModelIdArray = [NSMutableArray array];
                [weakSelf.processorsModelArray enumerateObjectsUsingBlock:^(LZCompanyModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [weakSelf.processorsModelNameArray addObject:obj.name];
                    [weakSelf.processorsModelIdArray addObject:obj.id];
                }];
            }
            
        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];
    }
}


#pragma mark ---- 点击事件 ----
/// 点击底部确定
- (void)clickBottom {
    
    // 产品数据 self.purchaseModelArray 其他数据-self.dataSource
    
    
}

/// 添加产品
- (void)clickAddProduct {
    
    LZPurchaseModel *model = [LZPurchaseModel new];
    [self.purchaseModelArray addObject:model];
    model.totalNumber = 0;
    [self.mainTable reloadData];
 
}

- (void)clickSelectColor:(NSIndexPath *)indexPath {
    
    
    LZPurchaseModel *model = self.purchaseModelArray[indexPath.row];
    if (model.productId == nil) {
        [LLHudTools showWithMessage:@"请输入产品名称"];
        return;
    }
 
    
    LZSearchVC * rightSeletedVc = [LZSearchVC new];
    WEAKSELF;
    rightSeletedVc.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
        
        model.productColorId = seletedModel.id;
        model.productColorName = seletedModel.name;
        [weakSelf.mainTable reloadData];
    };
    
    rightSeletedVc.productId = model.productId;
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:rightSeletedVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
}

- (void)clickColIndex:(NSIndexPath *)indexPath {
    
    WEAKSELF;
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        LZChoosseWorkerVC * VC = [LZChoosseWorkerVC new];
        VC.navTitle = @"选择指派人";
        [self.navigationController pushViewController:VC animated:YES];
        VC.chooseBlock = ^(NSString *workerId, NSString *workerName) {
            ConItem *item = weakSelf.dataSource[2][indexPath.row];
            item.id = workerId;
            item.contenText = workerName;
            [weakSelf.mainTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        return;
    }
}

//加工商名称点击事件
- (void)didClickItemInTextField:(UITextField *)tf{
    
    tf.delegate = self;
    tf.scrollView = (UIScrollView *)self.view;
    tf.positionType = ZJPositionBottomTwo;
    WEAKSELF;
    [tf popOverSource:_processorsModelNameArray index:^(NSInteger index) {
        LZCompanyModel *companyModel = weakSelf.processorsModelArray[index];
        //加工商
        ConItem *item1 = [[self.dataSource objectAtIndex:1] objectAtIndex:0];
        item1.contenText = companyModel.name;
        //联系人
        ConItem *item2 = [[self.dataSource objectAtIndex:1] objectAtIndex:1];
        item2.contenText = companyModel.contactName;
        //电话
        ConItem *item3 = [[self.dataSource objectAtIndex:1] objectAtIndex:2];
        item3.contenText = companyModel.mobile;
        //电话
        ConItem *item4 = [[self.dataSource objectAtIndex:1] objectAtIndex:3];
        item4.contenText = companyModel.address;
        //厂商id
        weakSelf.factoryId = companyModel.id;
        [weakSelf.mainTable reloadData];
        
    }];
}

#pragma mark ---- UITableViewDataSource ----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.purchaseModelArray.count;
    }else {
        NSArray *arry = self.dataSource[section];
        return arry.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self getBottomData];
    }
    WEAKSELF;
    switch (indexPath.section) {
        case 0:{
            BXSStockProductCell *cell = [tableView dequeueReusableCellWithIdentifier:[BXSStockProductCell cellID]];
            LZPurchaseModel *model = self.purchaseModelArray[indexPath.row];
            cell.model = model;
            cell.delegate = self;
//            cell.clickEditorProductNameDataBlock = ^{
//
//            };
            cell.clickSelectColorBlock = ^{
                [weakSelf clickSelectColor:indexPath];
            };
            cell.clickNeedGetBottomDataBlock = ^{
                [weakSelf getBottomData];
            };
            return cell;
        }break;
        case 1:
        case 2:{
            ConCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConCell cellID]];
            ConItem *item = self.dataSource[indexPath.section][indexPath.row];
            cell.k_titlewWidth = 120;
            cell.item = item;
            cell.clickCellBlock = ^{
                [weakSelf clickColIndex:indexPath];
            };
            
            return cell;
            
        }break;
            
        default:
            break;
    }
    return nil;
}

#pragma mark ---- UITableViewDelegate ----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            return  50;
        }break;
        case 1:
        case 2:
        case 3:{
            return 50.f;
        }break;
            
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 10.f;
    }
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [LineView lineViewOfHeight:10];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 60.f;
    }
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 60)];
        
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [footer addSubview:addBtn];
        [addBtn setImage:IMAGE(@"addbtn") forState:UIControlStateNormal];
        addBtn.frame = CGRectMake(0, 0, 120, footer.height-10);
        addBtn.center = CGPointMake(footer.centerX, footer.centerY);
        [addBtn addTarget:self action:@selector(clickAddProduct) forControlEvents:UIControlEventTouchUpInside];
        
        LineView *line = [LineView lineViewOfHeight:10];
        [footer addSubview:line];
        line.top = addBtn.bottom;
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2||indexPath.section == 0) {
        [self clickColIndex:indexPath];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.purchaseModelArray.count > indexPath.row) {
            [self.purchaseModelArray removeObjectAtIndex:indexPath.row];
            [self.mainTable reloadData];
        }
    }
}

- (void)clickEditorProductName:(UITextField *)nameTF andCell:(BXSStockProductCell *)titleCell{
    nameTF.delegate = self;
    nameTF.scrollView = (UIScrollView *)self.view;
    //选择框出来的位置
    nameTF.positionType = ZJPositionBottomTwo;
    //选择框出来的位置
    WEAKSELF;
    [nameTF popOverSource:weakSelf.productsListNameArray index:^(NSInteger index) {
        LZPurchaseModel *model = [[LZPurchaseModel alloc]init];
        model.productName = weakSelf.productsListNameArray[index];
        model.productId = weakSelf.productsListIdArray[index];
        [weakSelf.purchaseModelArray replaceObjectAtIndex:titleCell.indexPath.row withObject:model];
        [weakSelf.mainTable reloadData];
//        LZPurchaseModel
    }];
}

#pragma mark ---- private ----
/// 计算底部的数量
- (void)getBottomData {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat allT = 0.0f;
        for (LZPurchaseModel *model in self.purchaseModelArray) {
            allT += model.totalNumber.floatValue;
        }
        [self.bottomView setupCoun:[NSString stringWithFormat:@"总需求量:%.1f",allT]];
        
    });
    
}


@end

