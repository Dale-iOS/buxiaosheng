//
//  LZShipmentBigGoodsView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  大货（开单）

#import "LZShipmentBigGoodsView.h"
#import "BigGoodsAndBoardModel.h"
#import "LZGoodsDetailCell.h"
#import "LZGoodValueCell.h"
#import "BigGoodsFootView.h"
#import "LZBigGoodsHeadView.h"
#import "UIButton+EdgeInsets.h"
#import "LZPickerView.h"
#import "LZChangeNumVC.h"
#import "LZSaveOrderModel.h"

@interface LZShipmentBigGoodsView ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property(strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *consumptionArr;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) BigGoodsAndBoardModel *bigGoodsAndBoardModel;
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选中的付款方式id
@property (nonatomic, strong) LZSaveOrderModel *tureModel;//真单提交数据
@property (nonatomic, strong) LZSaveOrderModel *falseModel;//假单提交数据
@end


@implementation LZShipmentBigGoodsView
{
    int allPrice;
    int all_number ;
    int all_total ;
    int arrearValue;
    
}
static NSString * const LZGoodValueCellID = @"LZGoodValueCell";
static NSString * const LZGoodsDetailCellID = @"LZGoodsDetailCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setModel:(LZOrderTrackingModel *)model
{
    _model = model;
    [self requestListNetWork];
    [self setupPayList];
}

#pragma mark - request
//接口名称 已出库的产品信息
- (void)requestListNetWork
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[BXSUser currentUser].companyId forKey:@"companyId"];
    [param setObject:_model.id?_model.id:@"" forKey:@"orderId"];
    [BXSHttp requestPOSTWithAppURL:@"sale/outproduct_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        
        NSArray *dataList = [BigGoodsAndBoardModel mj_objectArrayWithKeyValuesArray:response[@"data"]];
        weakSelf.dataList = dataList;
        /// 这个可以不用解析 外面的一层 是一样的数据
        for (BigGoodsAndBoardModel *boardModel in dataList) {
            boardModel.batchNumberList = [BatchNumberList mj_objectArrayWithKeyValuesArray: boardModel.batchNumberList];
                        for (BatchNumberList *batchNumberList in  boardModel.batchNumberList) {
                            batchNumberList.itemList = [ItemList mj_objectArrayWithKeyValuesArray: batchNumberList.itemList];
                        }
        }
        
        
        NSString  *all_numberStr; /// 总条数
        NSString  *allPriceStr;  /// 总价格
        NSMutableArray *listArr = [NSMutableArray new];
        for (BigGoodsAndBoardModel *goodsAndBoardModel in dataList) {
            all_number+= goodsAndBoardModel.number.integerValue;
            all_total += goodsAndBoardModel.total.integerValue;
            allPrice+= goodsAndBoardModel.price.integerValue * goodsAndBoardModel.total.integerValue;
            [listArr addObject:goodsAndBoardModel];
        }
        
        //        计算金额
        all_numberStr = [NSString stringWithFormat:@"%d",all_number];
        
        //单价 x 结算数量
        NSInteger allPriceInteger = allPrice;
        //本单应收金额
        allPriceStr = [NSString stringWithFormat:@"%zd",allPriceInteger];
        
        NSArray *titlesArr = @[@"出库条数合计",@"出库数量",@"标签数量",@"结算数量",@"本单应收金额"];
        NSArray *detailArr = @[[NSString stringWithFormat:@"%d",all_total],all_numberStr,all_numberStr,all_numberStr,allPriceStr];
        
        for (int i =0 ; i<titlesArr.count; i++) {
            ItemList *item = [ItemList new];
            item.key =titlesArr[i];
            item.value =detailArr[i];
            item.isSelect = NO; /// 这地方自己调整
            item.isEditor = NO;
            
            if ([titlesArr[i] isEqualToString:@"标签数量"]) {
                item.isSelect = YES;
            }
            if ([titlesArr[i] isEqualToString:@"本单应收金额"]) {
                item.isContentColorRed = YES;
            }
            
            [listArr addObject:item];
            
            weakSelf.consumptionArr = [listArr copy];
            
        }//// 具体 颜色，是否点击，的等等操作 可以用 以下判断方法显示
        [weakSelf.dataSource addObject:weakSelf.consumptionArr ];
        
        [weakSelf requestCustomerInfo];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 已出库的客户信息
#pragma mark - request
- (void)requestCustomerInfo
{
    WEAKSELF;
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:[BXSUser currentUser].companyId forKey:@"companyId"];
    [param setObject:_model.id?_model.id:@"" forKey:@"orderId"];
    [BXSHttp requestPOSTWithAppURL:@"sale/out_info.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        //客户电话
        self.bigGoodsAndBoardModel.customerMobile = response[@"data"][@"customerMobile"];
        //客户名字
        self.bigGoodsAndBoardModel.customerName = response[@"data"][@"customerName"];
        //预收定金
        self.bigGoodsAndBoardModel.deposit = response[@"data"][@"deposit"];
        //本单欠款
        arrearValue = allPrice - self.bigGoodsAndBoardModel.deposit.intValue;
        
        NSArray *titles1Arr = @[@"客户名字",@"客户电话",@"实收金额",@"预收定金",@"调整金额",@"本单欠款",@"收款方式",@"备注"];
        NSArray *detail1Arr = @[self.bigGoodsAndBoardModel.customerName,self.bigGoodsAndBoardModel.customerMobile,@"",[NSString stringWithFormat:@"%@",self.bigGoodsAndBoardModel.deposit],@"",[NSString stringWithFormat:@"%d",arrearValue],@"",@"",@""];
        NSArray *placeholderArr = @[@"请输入客户名字",@"请输入客户电话",@"请输入实收金额",@"请输入预收定金",@"请输入调整金额",@"请输入本单欠款",@"请选择收款方式",@"请输入备注"];
        
        //        cell的操作
        for (int i =0 ; i<titles1Arr.count; i++) {
            ItemList *item = [ItemList new];
            item.key =titles1Arr[i];
            item.value =detail1Arr[i];
            item.placeholder = placeholderArr[i];
            item.isSelect = NO;
            //            item.isEditor = NO;
            // 具体 颜色，是否点击，的等等操作 可以用 以下判断方法显示
            if ([titles1Arr[i] isEqualToString:@"实收金额"] || [titles1Arr[i] isEqualToString:@"调整金额"] || [titles1Arr[i] isEqualToString:@"备注"]) {
                item.isEditor = YES;
            }
            
            if ([titles1Arr[i] isEqualToString:@"收款方式"]) {
                item.isSelect = YES;
            }
            
            if ([titles1Arr[i] isEqualToString:@"预收定金"] || [titles1Arr[i] isEqualToString:@"本单欠款"]) {
                item.isContentColorRed = YES;
            }
            
            [weakSelf.infoArr addObject:item];
        }
        //        加入单据数据
        [weakSelf.dataSource addObject:weakSelf.infoArr ];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupPayList{
    //    付款方式
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        _payNameAry = [NSMutableArray array];
        _payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [_payIdAry addObject:tempAry[i][@"id"]];
            [_payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark - private
- (void)setup
{
    //注册
    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LZGoodValueCell" bundle:nil] forCellReuseIdentifier:LZGoodValueCellID];
    [self.tableView registerClass:[LZGoodsDetailCell class] forCellReuseIdentifier:LZGoodsDetailCellID];
    //    提交按钮
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_offset(45);
        make.bottom.equalTo(self).offset(-LLNavViewHeight-24);
    }];
}

/// 新增一条
- (void)addMoreAction
{
    NSMutableArray *list  = [[NSMutableArray alloc] initWithArray:_consumptionArr copyItems:YES]; /// 这个操作是为了 避免真假单同时改变
    [_dataSource insertObject:list  atIndex:1];
    [self.tableView reloadData];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

// 展示或者收起 最下方CELL
- (void)didClicShowMoreCellAction:(UIButton*)sender
{
    _showBtn.selected =! _showBtn.selected;
    [_tableView reloadData];
}


///提交按钮点击事件
- (void)didClickSubmitAction
{
    if (_dataSource.count == 2) {
        //没假单,只有真单
        
        NSMutableArray *productListMuAry = [NSMutableArray array];
        NSMutableArray *itemListMuAry = [NSMutableArray array];
        for (int i = 0; i < _dataList.count; i++) {
            
            BigGoodsAndBoardModel *bigGoodsAndBoardModel = _dataList[i];
            LZSaveOrderProductList *LZSaveOrderProductListModel = [LZSaveOrderProductList new];
            LZSaveOrderProductListModel.productId = bigGoodsAndBoardModel.productId;
            LZSaveOrderProductListModel.productColorId = bigGoodsAndBoardModel.productColorId;
            LZSaveOrderProductListModel.total = bigGoodsAndBoardModel.total;
            LZSaveOrderProductListModel.number = bigGoodsAndBoardModel.number;
            LZSaveOrderProductListModel.price = bigGoodsAndBoardModel.price;
            
            for (int j = 0; j < bigGoodsAndBoardModel.batchNumberList.count; j++) {
                BatchNumberList *batchNumberListModel = bigGoodsAndBoardModel.batchNumberList[j];
                
                for (int k = 0; k <batchNumberListModel.itemList.count; k++) {
                    ItemList *itemListModel = batchNumberListModel.itemList[k];
                    LZSaveOrderItemList *LZSaveOrderItemListModel = [LZSaveOrderItemList new];
                    LZSaveOrderItemListModel.value = itemListModel.value;
                    LZSaveOrderItemListModel.total = itemListModel.total;
                    [itemListMuAry addObject:LZSaveOrderItemListModel];
                }
            }
            
            LZSaveOrderProductListModel.itemList = [itemListMuAry copy];
            [productListMuAry addObject:LZSaveOrderProductListModel];
        }
        self.tureModel.productList = [productListMuAry copy];
        
        NSMutableArray *detailValueMuAry = [NSMutableArray array];
        for (NSInteger i = _dataList.count ; i <_consumptionArr.count; i++) {
            ItemList *model = _consumptionArr[i];
            [detailValueMuAry addObject:model.value];
        }
        if (detailValueMuAry.count == 5) {
//            出库条数合计
            self.tureModel.total = detailValueMuAry[0];
//            出库数量
            self.tureModel.outNumber = detailValueMuAry[1];
//            标签数量
            self.tureModel.labelNumber = detailValueMuAry[2];
//            结算数量
            self.tureModel.settleNumber = detailValueMuAry[3];
//            本单应收金额
            self.tureModel.receivablePrice = detailValueMuAry[4];
        }
        
        NSMutableArray *tureValueMuAry = [NSMutableArray array];
        for (int i = 0; i <_infoArr.count; i++) {
            ItemList *model = _infoArr[i];
            [tureValueMuAry addObject:model.value];
        }
        if (tureValueMuAry.count == 8) {
            //实收金额
            self.tureModel.netreceiptsPrice = tureValueMuAry[2];
            //预收定金
            self.tureModel.depositPrice = tureValueMuAry[3];
            //调整金额
            self.tureModel.trimPrice = tureValueMuAry[4];
            //本单欠款
            self.tureModel.arrearsPrice = tureValueMuAry[5];
            //预收定金
            self.tureModel.depositPrice = tureValueMuAry[3];
            //备注内容
            self.tureModel.remark = tureValueMuAry[7];
            //属于真假单
            self.tureModel.type = @"0";
        }
//        self.tureModel.singleType = self.singleType;
        
    }else if (_dataSource.count == 3){
        //有假单
    }
    
    if (_didClickCompltBlock) {
        _didClickCompltBlock(self.tureModel);
    }
}

/// 刷新欠款 数据
- (void)refreshArrearsValue
{
    
    arrearValue = allPrice - self.bigGoodsAndBoardModel.deposit.intValue; /// 欠款
    for (ItemList *item in _infoArr ) {
        if ([item isKindOfClass:[ItemList class]]) {
            if ([item.key isEqualToString:@"实收金额"]) {
                arrearValue =  arrearValue- item.value.intValue;
            }
            if ([item.key isEqualToString:@"调整金额"]) {
                arrearValue =  arrearValue - item.value.intValue;
            }
            if ([item.key isEqualToString:@"本单欠款"]) {
                item.value = [NSString stringWithFormat:@"%d",arrearValue];
            }
        }
    }
    [self.tableView reloadData];
    
}

#pragma mark - set & get
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH,self.height - 150 );
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        //        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.tableFooterView = [UIView new];//默认设置为空
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSArray *)consumptionArr
{//费用
    if (_consumptionArr == nil) {
        _consumptionArr = [[NSArray alloc] init];
    }
    return _consumptionArr;
}

- (NSMutableArray *)infoArr
{//信息
    if (_infoArr == nil) {
        _infoArr = [[NSMutableArray alloc] init];
    }
    return _infoArr;
}

- (UIButton *)showBtn
{
    if (_showBtn == nil) {
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _showBtn.backgroundColor = [UIColor whiteColor];
        [_showBtn setTitle:@"收起" forState:UIControlStateNormal];
        [_showBtn setTitle:@"展开" forState:UIControlStateSelected];
        [_showBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
        [_showBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
        [_showBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateNormal];
        [_showBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateSelected];
        _showBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_showBtn addTarget:self action:@selector(didClicShowMoreCellAction:) forControlEvents:UIControlEventTouchUpInside];
        //        _showBtn.frame = CGRectMake((SCREEN_WIDTH -92)/2, 15, 92, 30);
        _showBtn.frame = CGRectMake(0, 0.5, APPWidth, 50);
        [_showBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:10];
    }
    return _showBtn;
}

- (UIButton *)submitBtn
{
    if (_submitBtn == nil) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = LZAppBlueColor;
        [_submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(didClickSubmitAction) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.frame = CGRectMake(0, APPHeight -50, SCREEN_WIDTH, 50);
        
    }
    return _submitBtn;
}

- (BigGoodsAndBoardModel *)bigGoodsAndBoardModel
{
    if (_bigGoodsAndBoardModel == nil) {
        _bigGoodsAndBoardModel = [BigGoodsAndBoardModel new];
    }
    return _bigGoodsAndBoardModel;
}

- (LZSaveOrderModel *)tureModel{
    if (_tureModel == nil) {
        _tureModel = [LZSaveOrderModel new];
    }
    return _tureModel;
}

- (LZSaveOrderModel *)falseModel{
    if (_falseModel == nil) {
        _falseModel = [LZSaveOrderModel new];
    }
    return _falseModel;
}

#pragma mark - delegate
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == self.dataSource.count-1) {
        return _showBtn.selected?3:[self.dataSource[section] count];
    }
    return [self.dataSource[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    if ([self.dataSource[indexPath.section][indexPath.row] isKindOfClass:[BigGoodsAndBoardModel class]]) {
        //单据详细板块
        LZGoodValueCell *cell = [tableView dequeueReusableCellWithIdentifier:LZGoodValueCellID forIndexPath:indexPath];
        BigGoodsAndBoardModel *model = self.dataSource[indexPath.section][indexPath.row];
        cell.indexPath = indexPath;
        cell.model = model;
        cell.didClickCompltBlock = ^(NSInteger index,BigGoodsAndBoardModel *boardModel ,NSIndexPath *indexP){
            if (index == 0) {
                
            }else
            {
                for (ItemList *item in _dataSource[indexP.section] ) {
                    if ([item isKindOfClass:[ItemList class]]) {
                        if ([item.key isEqualToString:@"本单应收金额"]) {
                            allPrice = 0;
                            for (BigGoodsAndBoardModel *goodsAndBoardModel in _dataSource[indexP.section] ) {
                                if ([goodsAndBoardModel isKindOfClass:[BigGoodsAndBoardModel class]] ) {
                                    allPrice+= goodsAndBoardModel.price.integerValue * goodsAndBoardModel.total.integerValue;
                                }
                            }
                            item.value = [NSString stringWithFormat:@"%d",allPrice];
                            
                            [weakSelf.tableView reloadData];
                            break;
                        }
                    }
                }
                if (indexP.section == 0) {
                    [self refreshArrearsValue];
                }
                
                
            }
            /// 选择价数量
            /// _bigGoodsAndBoardModel.total = @"你选择后的数据"
            ///
        };
        return cell;
    }else{
        //        客户金额板块
        LZGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:LZGoodsDetailCellID ];
        if (cell == nil) {
            cell = [[LZGoodsDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LZGoodsDetailCellID];
        }
        cell.contentTF.delegate = self;
        cell.contentTF.tag = 100+indexPath.row;
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
    
    return nil;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==  _dataSource.count-1 ) {
        return 10;
    }
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==  _dataSource.count-1) {
        /// 返回白
        UIView *headView = [UIView new];
        headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        headView.backgroundColor = LZHBackgroundColor;
        return headView;
    }
    LZBigGoodsHeadView *headView = [[NSBundle mainBundle] loadNibNamed:@"LZBigGoodsHeadView" owner:self options:nil].lastObject;
    /// 返回标题栏
    headView.backgroundColor = LZHBackgroundColor;
    return headView;
    
    
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WEAKSELF;
    if (section == 0 && _dataSource.count <3) {
        BigGoodsFootView *footView = [[BigGoodsFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        footView.didClickCompltBlock = ^{
            [weakSelf addMoreAction];
        };
        return footView;
    }
    else if(section == _dataSource.count-1){
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        self.backgroundColor = [UIColor whiteColor];
        [footView addSubview:self.showBtn];
        return footView;
        
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 && _dataSource.count <3) {
        return 60;
    }
    else if(section ==_dataSource.count-1){
        return  45;
    }
    return 0;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==  _dataSource.count-2 ) {
        ItemList *model = _consumptionArr[indexPath.row];
        if ([model.key isEqualToString:@"标签数量"]) {
            
            LZChangeNumVC *vc = [[LZChangeNumVC alloc]init];
            vc.originalValue = [model.value integerValue];
            [vc setNumValueBlock:^(NSString *ValueStr) {
                model.value = ValueStr;
                [tableView reloadData];
            }];
            CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
            [[self viewController].navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        }
        
    }
    
    if (indexPath.section ==  _dataSource.count-1 ) {
        ItemList *model1 = _infoArr[indexPath.row];
        
        if ([model1.key isEqualToString:@"收款方式"]) {
            if (_payNameAry.count <1) {
                [LLHudTools showWithMessage:@"暂无收款方式，请在“设置 - 现金银行”中添加"];
                return;
            }
            
            LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_payNameAry titleDataArray:nil];
            pickerView.toolsView.frame = CGRectMake(0, APPHeight - 244 -150, APPWidth, 44);
            pickerView.picerView.frame = CGRectMake(0, APPHeight - 220 -135, APPWidth, 200);
            pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
                model1.value = compoentString;
                NSInteger row = [titileString integerValue];
                _payIdStr = _payIdAry[row];
                self.tureModel.bankId = _payIdStr;
                self.falseModel.bankId = _payIdStr;
                [tableView reloadData];
            };
            [self addSubview:pickerView];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    ItemList *model = _infoArr[textField.tag - 100];
    model.value = textField.text;
    if ([model.key isEqualToString:@"客户姓名"]) {
        //        _bigGoodsAndBoardModel.customerName =  textField.text; //举例子 通过这样的赋值 填充 _bigGoodsAndBoardModel
    }
    
    if ([model.key isEqualToString:@"实收金额"]) {
        self.tureModel.netreceiptsPrice = textField.text;
    }
    if ([model.key isEqualToString:@"调整金额"]) {
        //        _bigGoodsAndBoardModel.@"调整金额" = textField.text
    }
    [self refreshArrearsValue];
    
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
