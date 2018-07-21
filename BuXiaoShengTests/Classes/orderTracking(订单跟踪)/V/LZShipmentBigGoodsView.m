//
//  LZShipmentBigGoodsView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/18.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  大货（开单）

#import "LZShipmentBigGoodsView.h"
#import "LZGoodValueCell.h"
#import "BigGoodsAndBoardModel.h"
#import "BigGoodsAndBoardModel.h"
#import "LZGoodsDetailCell.h"
#import "BigGoodsFootView.h"
#import "LZBigGoodsHeadView.h"
#import "UIButton+EdgeInsets.h"
#import "LZPickerView.h"
#import "LZChangeNumVC.h"

@interface LZShipmentBigGoodsView ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property(strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *consumptionArr;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) BigGoodsAndBoardModel *bigGoodsAndBoardModel;
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选中的付款方式id
@end

@implementation LZShipmentBigGoodsView
static NSString * const LZGoodValueCellID = @"LZGoodValueCell";
static NSString * const LZGoodsDetailCellID = @"LZGoodsDetailCell";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
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

#pragma mark - 网络请求
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
        
        _bigGoodsAndBoardModel = dataList.firstObject;
        
        _bigGoodsAndBoardModel.batchNumberList = [BatchNumberList mj_objectArrayWithKeyValuesArray: _bigGoodsAndBoardModel.batchNumberList];
        NSArray *batchNumberListTempArray = [BatchNumberList mj_objectArrayWithKeyValuesArray: _bigGoodsAndBoardModel.batchNumberList];
        //        NSMutableArray *goodsDetail = [NSMutableArray ]
        
        //标签数量~结算数量
        BatchNumberList *BatchNumberListModel = [[BatchNumberList alloc]init];
        if (batchNumberListTempArray.count >0) {
            BatchNumberListModel = [BatchNumberList LLMJParse:[batchNumberListTempArray firstObject]];
        }
        
        
        //出库条数合计~出库数量
        ItemList *ItemListModel = [[ItemList alloc]init];;
        if (BatchNumberListModel.itemList.count >0) {
            ItemListModel = [ItemList LLMJParse:[BatchNumberListModel.itemList firstObject]];
        }
        
//        NSLog(@"%@",ItemListModel.total);
        
        int batchNumber = 0;
        NSString  *batchNumberStr; /// 总条数
        int allPrice = 0;
        NSString  *allPriceStr;  /// 总价格
        
        for (BatchNumberList *bathcModel in _bigGoodsAndBoardModel.batchNumberList) {
            bathcModel.price = _bigGoodsAndBoardModel.price;
            bathcModel.itemList =  [ItemList mj_objectArrayWithKeyValuesArray: bathcModel.itemList];
            bathcModel.productColorName = _bigGoodsAndBoardModel.productColorName;
            bathcModel.productName = _bigGoodsAndBoardModel.productName;
            batchNumber+= bathcModel.total.integerValue;
            allPrice+= bathcModel.price.integerValue * bathcModel.total.integerValue;
            [weakSelf.consumptionArr addObject:bathcModel];
        }
        batchNumberStr = [NSString stringWithFormat:@"%d",batchNumber];
        
        //单价 x 结算数量
        NSInteger allPriceInteger = [_bigGoodsAndBoardModel.price integerValue] * [BatchNumberListModel.number integerValue];
        //本单应收金额
        allPriceStr = [NSString stringWithFormat:@"%zd",allPriceInteger];
        
        NSArray *titlesArr = @[@"出库条数合计",@"出库数量",@"标签数量",@"结算数量",@"本单应收金额"];
        NSArray *detailArr = @[ItemListModel.total,ItemListModel.value,BatchNumberListModel.number,BatchNumberListModel.number,allPriceStr];
        for (int i =0 ; i<titlesArr.count; i++) {
            ItemList *item = [ItemList new];
            item.key =titlesArr[i];
            item.value =detailArr[i];
            item.isEditor = NO;
            
            if ([titlesArr[i] isEqualToString:@"本单应收金额"]) {
                item.isContentColorRed = YES;
            }
            
            [weakSelf.consumptionArr addObject:item];
        }//// 具体 颜色，是否点击，的等等操作 可以用 以下判断方法显示
        [weakSelf.dataSource addObject:weakSelf.consumptionArr ];
        
        [weakSelf requestCustomerInfo];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

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
        _bigGoodsAndBoardModel.customerMobile = response[@"data"][@"customerMobile"];
        _bigGoodsAndBoardModel.customerName = response[@"data"][@"customerName"];
        _bigGoodsAndBoardModel.deposit = response[@"data"][@"deposit"];
        
        
        //单价 x 结算数量
        NSInteger allPriceInteger = [_bigGoodsAndBoardModel.price integerValue] * [_bigGoodsAndBoardModel.total integerValue];
        //本单应收金额
        NSString *allPriceStr = [NSString stringWithFormat:@"%zd",allPriceInteger];
        
        
        NSArray *titles1Arr = @[@"客户名字",@"客户电话",@"实收金额",@"预收定金",@"调整金额",@"本单欠款",@"收款方式",@"备注"];
        

        NSArray *detail1Arr = @[_bigGoodsAndBoardModel.customerName,_bigGoodsAndBoardModel.customerMobile,@"",[NSString stringWithFormat:@"%@",_bigGoodsAndBoardModel.deposit],@"",allPriceStr,@"",@"",@""];
        
        
        
        NSArray *placeholderArr = @[@"请输入客户名字",@"请输入客户电话",@"请输入实收金额",@"请输入预收定金",@"请输入调整金额",@"请输入本单欠款",@"请选择收款方式",@"请输入备注"];
        
        for (int i =0 ; i<titles1Arr.count; i++) {
            ItemList *item = [ItemList new];
            item.key =titles1Arr[i];
            item.value =detail1Arr[i];
            item.placeholder = placeholderArr[i];
            item.isSelect = NO;
            item.isEditor = NO;
            
            // 具体 颜色，是否点击，的等等操作 可以用 以下判断方法显示
            if ([titles1Arr[i] isEqualToString:@"收款方式"]) {
                item.isSelect = YES;
            }
            
            if ([titles1Arr[i] isEqualToString:@"预收定金"] || [titles1Arr[i] isEqualToString:@"本单欠款"]) {
                item.isContentColorRed = YES;
            }
            
            [weakSelf.infoArr addObject:item];
        }
        [weakSelf.dataSource addObject:weakSelf.infoArr ];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupPayList{
    
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
    
    [self addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LZGoodValueCell" bundle:nil] forCellReuseIdentifier:LZGoodValueCellID];
    [self.tableView registerClass:[LZGoodsDetailCell class] forCellReuseIdentifier:LZGoodsDetailCellID];
    
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.height.mas_offset(45);
        make.bottom.equalTo(self).offset(-LLNavViewHeight-24);
    }];
}

/// 添加
- (void)addMoreAction
{
    [_dataSource insertObject:[_consumptionArr mutableCopy]  atIndex:1];
    
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


///提交操作
- (void)didClickSubmitAction
{
    if (_didClickCompltBlock) {
        _didClickCompltBlock(_bigGoodsAndBoardModel);
    }
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

- (NSMutableArray *)consumptionArr
{
    if (_consumptionArr == nil) {
        _consumptionArr = [[NSMutableArray alloc] init];
    }
    return _consumptionArr;
}

- (NSMutableArray *)infoArr
{
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
    if ([self.dataSource[indexPath.section][indexPath.row] isKindOfClass:[BatchNumberList class]]) {
        LZGoodValueCell *cell = [tableView dequeueReusableCellWithIdentifier:LZGoodValueCellID forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.section][indexPath.row];
        cell.didClickCompltBlock = ^{
            /// 选择价数量
            /// _bigGoodsAndBoardModel.total = @"你选择后的数据"
            /// [self.tableView reloadData];
        };
        return cell;
    }else{
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
        _bigGoodsAndBoardModel.customerName =  textField.text; //举例子 通过这样的赋值 填充 _bigGoodsAndBoardModel
    }
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
