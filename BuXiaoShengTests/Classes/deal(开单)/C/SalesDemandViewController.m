//
//  SalesDemandViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售需求页面

#import "SalesDemandViewController.h"
#import "SalesDemandCell.h"
#import "SalesDemandListView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "salesDemandModel.h"
#import "LZPickerView.h"
#import "LZSearchVC.h"
#import "UITextField+PopOver.h"
#import "salesDemandModel.h"
#import "LZDrawerChooseView.h"
#import "LZSearchBar.h"
#import "LZPickerView.h"
#import "LZSaleOrderListVC.h"

@interface SalesDemandViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,SalesDemandCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray <productListModel *>* dataMuArray;
///销售需求列表View
@property (nonatomic, strong) SalesDemandListView *demandListView;

///客户名字
@property (nonatomic, strong) TextInputCell *nameCell;
///客户电话
@property (nonatomic, strong) TextInputCell *phoneCell;
///预收定金
@property (nonatomic, strong) TextInputCell *depositCell;

///调整金额
@property (nonatomic, strong) TextInputCell *adjustmentCell;
///实收金额
@property (nonatomic, strong) TextInputCell *actualCell;
///本单应收
@property (nonatomic, strong) TextInputCell *arrearsCell;
///收款方式
@property (nonatomic, strong) TextInputCell *paymentMethodCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///仓库注意事项
@property (nonatomic, strong) TextInputTextView *warehouseTextView;

@property (nonatomic,strong) UITableView  * seletedTableView;

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

///下一步按钮
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic,strong) NSMutableArray <productListModel*>  * listModels;

@property (nonatomic,strong) productListModel  * fristAddModel;

@property (nonatomic,assign) BOOL  markSeletedTableView;

@property (nonatomic,strong) NSIndexPath  * tableViewIndexPath;

//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选择中的付款方式id

@end

@implementation SalesDemandViewController
@synthesize nameCell,phoneCell,depositCell,adjustmentCell,actualCell,arrearsCell,paymentMethodCell,remarkTextView,warehouseTextView,lineView1,lineView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupProductData];
    [self setupPayList];
}


- (void)setupUI
{
    self.navigationItem.title = @"销售需求";
    self.view.backgroundColor = [UIColor whiteColor ];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"search")];
    [self setupHeaderView];
    [self setupFooterView];
    
    //初始化tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,LLNavViewHeight, APPWidth, APPHeight -44-LLNavViewHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView registerClass:[SalesDemandCell class] forCellReuseIdentifier:@"SalesDemandCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];

    //下一步按钮
    self.nextBtn = [UIButton new];
    self.nextBtn.frame = CGRectMake(0, APPHeight - 44, APPWidth, 44);
    self.nextBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
//    self.nextBtn.titleLabel.text = @"下一步";
    self.nextBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [self.view addSubview:self.nextBtn];
    
}

- (void)setupHeaderView
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPHeight, 40)];
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    
    //品名  颜色  条数  数量  单价
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = FONT(14);
    nameLabel.text = @"品名";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = CD_Text33;
    [_headerView addSubview:nameLabel];
    
    UILabel *colorLabel = [[UILabel alloc]init];
    colorLabel.font = FONT(14);
    colorLabel.text = @"颜色";
    colorLabel.textAlignment = NSTextAlignmentCenter;
    colorLabel.textColor = CD_Text33;
    [_headerView addSubview:colorLabel];
    
    UILabel *lineNumLabel = [[UILabel alloc]init];
    lineNumLabel.font = FONT(14);
    lineNumLabel.text = @"条数";
    lineNumLabel.textAlignment = NSTextAlignmentCenter;
    lineNumLabel.textColor = CD_Text33;
    [_headerView addSubview:lineNumLabel];
    
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.font = FONT(14);
    numLabel.text = @"数量";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = CD_Text33;
    [_headerView addSubview:numLabel];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.font = FONT(14);
    priceLabel.text = @"单价";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.textColor = CD_Text33;
    [_headerView addSubview:priceLabel];
    
    nameLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(_headerView, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(240));
    
    colorLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(nameLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    lineNumLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(colorLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    numLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(lineNumLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    priceLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(numLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
}

- (void)setupFooterView
{
    self.footerView = [[UIView alloc]init];
    self.footerView.userInteractionEnabled = YES;
    self.footerView.frame = CGRectMake(0, 0, APPWidth, 519);
//    self.footerView.backgroundColor = [UIColor redColor];
    
    //新增一条底图view
    UIView *addView = [[UIView alloc]init];
    addView.backgroundColor = [UIColor whiteColor];
    [self.footerView addSubview:addView];
    addView.sd_layout
    .leftSpaceToView(self.footerView, 0)
    .topSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(65);
    
    //新增按钮
    UIButton *addBtn = [UIButton new];
    addBtn.backgroundColor = [UIColor whiteColor];
    [addBtn setBackgroundImage:IMAGE(@"addbtn") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [addView addSubview:addBtn];
    addBtn.sd_layout
    .centerYEqualToView(addView)
    .centerXEqualToView(addView)
    .widthIs(92)
    .heightIs(31);
    
    //第一条灰色line
    self.lineView1.sd_layout
    .topSpaceToView(addView, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(10);
    
    //客户名字
    self.nameCell.sd_layout
    .topSpaceToView(self.lineView1, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    //客户电话
    self.phoneCell.sd_layout
    .topSpaceToView(self.nameCell, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    //本单应收
    self.arrearsCell.sd_layout
    .topSpaceToView(self.phoneCell, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    //预收定金
    self.depositCell.sd_layout
    .topSpaceToView(self.arrearsCell, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
   
    //收款方式
    self.paymentMethodCell.sd_layout
    .topSpaceToView(self.depositCell, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(49);
    
    //备注
    self.remarkTextView.sd_layout
    .topSpaceToView(self.paymentMethodCell, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(79);
    
    //灰色line2
    self.lineView2.sd_layout
    .topSpaceToView(self.remarkTextView, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(10);
    
    //仓库事项
    self.warehouseTextView.sd_layout
    .topSpaceToView(self.lineView2, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(79);
}

#pragma mark ----- 网络请求 ------
//功能用到产品列表
- (void)setupProductData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.dataMuArray = [productListModel LLMJParse:baseModel.data];
       
    } failure:^(NSError *error) {
        
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

//功能用到颜色列表
//- (void)setupProductColorData
//{
//    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
//                             @"productId":_ProductColorId
//                             };
//    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
//        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            return ;
//        }
//        _productColors = [productListModel LLMJParse:baseModel.data];
//        _productsColorsListMTArray = [NSMutableArray array];
//        _dataColorsArray = [NSArray arrayWithArray:baseModel.data];
//        if (_productColors) {
//            for (int i = 0; i <_productColors.count; i++) {
//                productListModel *model = [productListModel LLMJParse:_productColors[i]];
//                [_productsColorsListMTArray addObject:model.name];
//                [_colorTableView reloadData];
//            }
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.seletedTableView) {
        return self.markSeletedTableView ? self.dataMuArray.count : 0;
    }
     return self.listModels.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.seletedTableView) {
        return 44;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.seletedTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"seletedTableView"];
        cell.textLabel.text = self.dataMuArray[indexPath.row].name;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        return cell;
    }
     SalesDemandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesDemandCell"];
    cell.indexPath  = indexPath;
    cell.delegate = self;
    cell.model = self.listModels[indexPath.row];
    return cell;
  
    
    
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (tableView == self.seletedTableView) {
        [self.seletedTableView removeFromSuperview];
        self.markSeletedTableView = false;
        self.seletedTableView.delegate = nil;
        self.seletedTableView.dataSource = nil;
        self.seletedTableView = nil;
        [self.listModels replaceObjectAtIndex:_tableViewIndexPath.row withObject:self.dataMuArray[indexPath.row]];
        [self.tableView reloadData];
        return;
    }
}

//是否可以编辑tableView的cell
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//编辑cell是触发此方法
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.seletedTableView) {
        [self.seletedTableView removeFromSuperview];
        self.seletedTableView.dataSource = nil;
        self.seletedTableView.delegate = nil;
        self.seletedTableView = nil;
    }
    //要先把数据源的对应的数据删除掉
    [self.listModels removeObjectAtIndex:indexPath.row];
    
    //删除cell
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didClickTitleTextField:(SalesDemandCell *)titleCell{
    
    self.markSeletedTableView = ! self.markSeletedTableView;
    if (self.markSeletedTableView) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableViewIndexPath = titleCell.indexPath;
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:titleCell.indexPath];
            CGRect cellFrame = [ self.tableView convertRect:rectInTableView toView:self.view];
            self.seletedTableView.frame = CGRectMake(0, cellFrame.origin.y+44, LZHScale_WIDTH(240), self.dataMuArray.count *44);
            [self.view addSubview:_seletedTableView];
        }];
    }else {
        [self.seletedTableView removeFromSuperview];
        self.seletedTableView.delegate = nil;
        self.seletedTableView.dataSource = nil;
        self.seletedTableView = nil;
    }
    
}

- (void) didClickColorTextField:(SalesDemandCell *)colorCell{
    if (!colorCell.model.name) {
        [LLHudTools showWithMessage:@"请选择品名"];
        return;
    }
    LZSearchVC * rightSeletedVc = [LZSearchVC new];
    WEAKSELF;
    rightSeletedVc.SearchVCBlock = ^(LLSalesColorListModel *seletedModel) {
        LLSalesColorListModel * model = [LLSalesColorListModel new];
        model.id = seletedModel.id;
        model.productId = seletedModel.productId;
        model.name = seletedModel.name;
        colorCell.model.colorModel = model;
        [weakSelf.tableView reloadData];
    };
    rightSeletedVc.productId = colorCell.model.id;
//    rightSeletedVc.block = ^(NSArray<LLOutboundRightModel *> *seleteds, LZOutboundItemListModel *lastModel) {
//        outboundVc.sectionModel = lastModel;
//        outboundVc.rightSeleteds = [NSMutableArray arrayWithArray:seleteds];
//    };
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
    [self.navigationController cw_showDrawerViewController:rightSeletedVc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
}

-(void)didClickNumberTextField:(SalesDemandCell *)colorCell {
    
    [self.listModels replaceObjectAtIndex:colorCell.indexPath.row withObject:colorCell.model];
    [self.tableView reloadData];
    __block NSInteger  totalPrice = 0;
    [self.listModels enumerateObjectsUsingBlock:^(productListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice+= ([obj.number integerValue] * [obj.shearPrice integerValue]);
    }];
   self.arrearsCell.contentTF.text = [@(totalPrice) stringValue];
}


#pragma mark -------- 点击事件 ----------
- (void)nextBtnOnClickAction
{
    
}

- (void)navigationSetupClick
{
    LZSaleOrderListVC *vc = [[LZSaleOrderListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -------- 新增一条数据 ----------
-(void)addBtnOnClickAction
{
    if (!self.fristAddModel) {
         self.fristAddModel = [productListModel new];
    }else {
        if (self.listModels.count) {
             self.fristAddModel = [productListModel new];
             self.fristAddModel.alias = self.listModels.lastObject.alias;
             self.fristAddModel.id = self.listModels.lastObject.id;
             self.fristAddModel.name = self.listModels.lastObject.name;
             self.fristAddModel.shearPrice = self.listModels.lastObject.shearPrice;
             self.fristAddModel.status = self.listModels.lastObject.status;
             self.fristAddModel.unitName = self.listModels.lastObject.unitName;
             self.fristAddModel.productId = self.listModels.lastObject.productId;
             self.fristAddModel.number = self.listModels.lastObject.number;
             self.fristAddModel.colorModel = self.listModels.lastObject.colorModel;
        }else {
             self.fristAddModel = [productListModel new];
        }
    }
    [self.listModels addObject:self.fristAddModel];
    [self.tableView reloadData];
    
    //arrearsCell
    __block NSInteger  totalPrice = 0;
    [self.listModels enumerateObjectsUsingBlock:^(productListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice+= ([obj.number integerValue] * [obj.shearPrice integerValue]);
    }];
    self.arrearsCell.contentTF.text = [@(totalPrice) stringValue];
}

//收款方式点击事件
- (void)paymentMethodCellClick
{

    if (_payNameAry.count <1) {
        [LLHudTools showWithMessage:@"暂无收款方式，请在“设置 - 现金银行”中添加"];
        return;
    }
    
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_payNameAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        self.paymentMethodCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
        _payIdStr = _payIdAry[row];
    };
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)didClickMakeSureBtnWithName:(NSString *)chooseStr WithId:(NSString *)chooseId WithProductId:(NSString *)chooseProductId
//{
//
//    [self dismiss];
//}
//
//- (void)searchBar:(LZSearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//
//    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
//                             @"productId":_ProductColorId,
//                             @"searchName":_searchBar.text.length == 0 ? @"" :self.searchBar.text
//                             };
//    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
//        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
//        if ([baseModel.code integerValue] != 200) {
//            return ;
//        }
//        _productColors = [productListModel LLMJParse:baseModel.data];
//        _productsColorsListMTArray = [NSMutableArray array];
//        _dataColorsArray = [NSArray arrayWithArray:baseModel.data];
//        if (_productColors) {
//            for (int i = 0; i <_productColors.count; i++) {
//                productListModel *model = [productListModel LLMJParse:_productColors[i]];
//                [_productsColorsListMTArray addObject:model.name];
//                [_colorTableView reloadData];
//            }
//        }
//    } failure:^(NSError *error) {
//
//    }];
//}


#pragma mark ----- lazy loading ----
- (UIView *)lineView1
{
    if (!lineView1) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self.footerView addSubview:(lineView1 = view)];
    }
    return lineView1;
}

- (TextInputCell *)nameCell
{
    if (!nameCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"客户名字";
        cell.contentTF.placeholder = @"请输入客户名字";
        cell.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(nameCell = cell)];
    }
    return nameCell;
}

- (TextInputCell *)phoneCell
{
    if (!phoneCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"客户电话";
        cell.contentTF.placeholder = @"请输入客户电话";
        cell.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(phoneCell = cell)];
    }
    return phoneCell;
}

- (TextInputCell *)arrearsCell
{
    if (!arrearsCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"本单应收";
        cell.contentTF.placeholder = @"请输入本单赢收";
        cell.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(arrearsCell = cell)];
    }
    return arrearsCell;
}

- (TextInputCell *)depositCell
{
    if (!depositCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"预收定金";
        cell.contentTF.placeholder = @"请输入预收定金";
        cell.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(depositCell = cell)];
    }
    return depositCell;
}

- (TextInputCell *)paymentMethodCell
{
    if (!paymentMethodCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"收款方式";
        cell.contentTF.placeholder = @"请选择收款方式";
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentTF.enabled = NO;
        cell.rightArrowImageVIew.hidden = NO;
        cell.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(paymentMethodCellClick)];
        [cell addGestureRecognizer:tap];
        [self.footerView addSubview:(paymentMethodCell = cell)];
    }
    return paymentMethodCell;
}

- (TextInputTextView *)remarkTextView
{
    if (!remarkTextView) {
        
        TextInputTextView *textView = [[TextInputTextView alloc]init];
        textView.titleLabel.text = @"备注";
        textView.textView.placeholder = @"请输入备注内容";
        textView.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(remarkTextView = textView)];
    }
    return remarkTextView;
}

- (UIView *)lineView2
{
    if (!lineView2) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self.footerView addSubview:(lineView2 = view)];
    }
    return lineView2;
}

- (TextInputTextView *)warehouseTextView
{
    if (!warehouseTextView) {
        TextInputTextView *textView = [[TextInputTextView alloc]init];
        textView.titleLabel.text = @"仓库注意事项";
        textView.textView.placeholder = @"请输入告知仓库事项";
        textView.backgroundColor = [UIColor whiteColor];
        [self.footerView addSubview:(warehouseTextView = textView)];
    }
    return warehouseTextView;
}

-(NSMutableArray<productListModel *> *)listModels {
    if (!_listModels) {
        
        _listModels = [NSMutableArray array];
    }
    return _listModels;
}

-(UITableView *)seletedTableView {
    if (!_seletedTableView) {
        _seletedTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _seletedTableView.delegate = self;
        _seletedTableView.dataSource = self;
        _seletedTableView.tableFooterView = [UIView new];
        
        [_seletedTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"seletedTableView"];
    }
    return _seletedTableView;
}


@end
