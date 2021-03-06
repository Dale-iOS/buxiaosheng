//
//  LZSalesDemandVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售需求页面

#import "LZSalesDemandVC.h"
#import "SalesDemandCell.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "salesDemandModel.h"
#import "LZPickerView.h"
#import "LZSearchVC.h"
#import "UITextField+PopOver.h"
#import "LZSearchBar.h"
#import "LZPickerView.h"
#import "LZSaleOrderListVC.h"
#import "UITextField+PopOver.h"
#import "LZWKWebViewVC.h"
#import "ToolsCollectionVC.h"

@interface LZSalesDemandVC ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,SalesDemandCellDelegate,UITextFieldDelegate>{
//    NSString *_orderId;//开单成功后返回的本订单的单号
//    NSString *_printerState;//打印机状态
}
@property (nonatomic,strong)NSString *orderId;//开单成功后返回的本订单的单号
@property (nonatomic,strong)NSString *printerState;//打印机状态
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray <productListModel *>* dataMuArray;
@property (nonatomic, strong) UIView *ViImage;
@property (nonatomic, strong) UILabel *labImage;
@property(nonatomic,strong)ToolsCollectionVC * collectionVC;
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
@property (nonatomic, strong) UIView *lineView3;
///下一步按钮
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic,strong) NSMutableArray <productListModel*>  * listModels;
@property (nonatomic,strong) productListModel  * fristAddModel;
@property (nonatomic,assign) BOOL  markSeletedTableView;
@property (nonatomic,strong) NSIndexPath  * tableViewIndexPath;
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *payIdStr;///选中的付款方式id
//客户数组
@property(nonatomic,strong)NSMutableArray *customerList;
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerPhoneAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property (nonatomic, copy)NSString *customerIdStr;///选中的客户id
//产品数组
@property (nonatomic, strong) NSMutableArray <productListModel *> *products;
@property (nonatomic, strong) NSMutableArray *productsListMTArray;//展示图产品列表名称数组
@property (nonatomic, strong) NSMutableArray *productsIdMTArray;//展示图产品列表ID数组
@property (nonatomic,copy)NSString * urlStr;
@end

@implementation LZSalesDemandVC

@synthesize nameCell,phoneCell,depositCell,adjustmentCell,actualCell,arrearsCell,paymentMethodCell,remarkTextView,warehouseTextView,lineView1,lineView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupPrinterData];
    //进入页面就帮用户增加一条
    [self addBtnOnClickAction];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupProductData];
    [self setupCustomerList];
    [self setupPayList];
}


- (void)setupUI
{
    self.navigationItem.title = @"销售需求";
    self.view.backgroundColor = [UIColor whiteColor ];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"new_lists")];
    
    [self setupHeaderView];
    [self setupFooterView];
    
    //初始化tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, APPWidth, APPHeight -44) style:UITableViewStylePlain];
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
    self.footerView.frame = CGRectMake(0, 0, APPWidth, 519 + 132);
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

	self.ViImage = [[UIView alloc]init];
	self.ViImage.backgroundColor = [UIColor whiteColor];
	[self.footerView addSubview:self.ViImage];
	self.ViImage.sd_layout
	.leftSpaceToView(self.footerView, 0)
	.topSpaceToView(self.lineView1, 0)
	.widthIs(APPWidth)
	.heightIs(132);//这个高度根据屏幕尺寸去算-->这个高度为 图片的lable和collection高的总和
	//设置图片信息
	[self setupImageView];

	//第三条灰色line
	self.lineView3.sd_layout
	.topSpaceToView(self.ViImage, 0)
	.leftSpaceToView(self.footerView, 0)
	.widthIs(APPWidth)
	.heightIs(10);

    //客户名字
    self.nameCell.sd_layout
    .topSpaceToView(self.lineView3, 0)
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
/**
 设置图片
 */
- (void)setupImageView{
	//图片
	self.labImage =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, APPWidth, 28)];
	self.labImage.textColor = CD_Text33;
	self.labImage.font = FONT(14);
	self.labImage.text = @"图片";
	self.labImage.backgroundColor = [UIColor whiteColor];
	[self.ViImage addSubview:self.labImage];

    //Collection
	CGRect tFrame =CGRectMake(0, 28, APPWidth, 104);//这个高度根据屏幕去算的暂时写死
	_collectionVC = [[ToolsCollectionVC alloc]init];
	self.collectionVC.maxCountTF = @"5";//最多选择5张
	_collectionVC.columnNumberTF = @"4";
	_collectionVC.view.frame = tFrame;
	_collectionVC.view.backgroundColor = [UIColor whiteColor];
	[self addChildViewController:_collectionVC];
	[self.ViImage addSubview:_collectionVC.view];
	[_collectionVC didMoveToParentViewController:self];
	[self.collectionVC setupMainCollectionViewWithFrame:CGRectMake(0, 0, APPWidth, 104)];
	[self.collectionVC.view addSubview:self.collectionVC.mainCollectionView];
}
#pragma mark ----- 网络请求 ------
//功能用到产品列表
- (void)setupProductData
{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/product_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        self.dataMuArray = [productListModel LLMJParse:baseModel.data];
        
       weakSelf.products = [productListModel LLMJParse:baseModel.data];
        //拼接要展示的列表数据
        weakSelf.productsListMTArray = [NSMutableArray array];
        weakSelf.productsIdMTArray = [NSMutableArray array];
        if (weakSelf.products) {
            for (int i = 0; i <weakSelf.products.count; i++) {
                productListModel *model = [productListModel LLMJParse:weakSelf.products[i]];
                [weakSelf.productsListMTArray addObject:model.name];
                [weakSelf.productsIdMTArray addObject:model.id];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
}

//功能用到客户列表
- (void)setupCustomerList{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        weakSelf.customerList = baseModel.data;
        weakSelf.customerNameAry = [NSMutableArray array];
        weakSelf.customerIdAry = [NSMutableArray array];
        weakSelf.customerPhoneAry = [NSMutableArray array];
        for (int i = 0 ; i <weakSelf.customerList.count; i++) {
            [weakSelf.customerNameAry addObject:weakSelf.customerList[i][@"name"]];
            [weakSelf.customerIdAry addObject:weakSelf.customerList[i][@"id"]];
            [weakSelf.customerPhoneAry addObject:weakSelf.customerList[i][@"mobile"]];
        }
        WEAKSELF;
		self.nameCell.contentTF.delegate = self;
		self.nameCell.contentTF.scrollView = (UIScrollView * )self.view;
		self.nameCell.contentTF.positionType = ZJPositionBottom;
        [self.nameCell.contentTF popOverSource:weakSelf.customerNameAry index:^(NSInteger index) {
//            [weakSelf.tableView reloadData];
            //        _ProductColorId = _productsIdMTArray[index];
            //        [self setupProductColorData];
            weakSelf.phoneCell.contentTF.text = weakSelf.customerPhoneAry[index];
            weakSelf.customerIdStr = weakSelf.customerIdAry[index];
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)setupPayList{
    WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        weakSelf.payNameAry = [NSMutableArray array];
        weakSelf.payIdAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [weakSelf.payIdAry addObject:tempAry[i][@"id"]];
            [weakSelf.payNameAry addObject:tempAry[i][@"name"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

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

///价格输入完成后回调
-(void)didPriceTFValueChange:(SalesDemandCell *)colorCell {
    __block NSInteger  totalPrice = 0;
    [self.listModels enumerateObjectsUsingBlock:^(productListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice+= ([obj.number integerValue] * [obj.shearPrice integerValue]);
    }];
    self.arrearsCell.contentTF.text = [@(totalPrice) stringValue];
}

- (void)didClickTitleTextField:(UITextField *)titleTF andCell:(SalesDemandCell*)titleCell{
    titleTF.delegate = self;
    titleTF.scrollView = (UIScrollView *)self.view;
    //选择框出来的位置
    titleTF.positionType = ZJPositionAuto;
    WEAKSELF;
    [titleTF popOverSource:_productsListMTArray index:^(NSInteger index) {
        [weakSelf.listModels replaceObjectAtIndex:titleCell.indexPath.row withObject:self.dataMuArray[index]];
        [weakSelf.tableView reloadData];
    }];
}

- (void) didClickColorTextField:(SalesDemandCell *)colorCell{
    if (!colorCell.model.name) {
        [LLHudTools showWithMessage:@"请选择品名"];
        return;
    }
    LZSearchVC * rightSeletedVc = [LZSearchVC new];
    WEAKSELF;
//    回调
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
    
    NSMutableArray <NSDictionary *> * produstsItems = [NSMutableArray array];
    
    [self.listModels enumerateObjectsUsingBlock:^(productListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NSDictionary * param = @{
						 @"productId":obj.id == nil ? @"" : obj.id,
						 @"productColorId":obj.colorModel.id == nil ? @"" :obj.colorModel.id ,
						 @"number":obj.number == nil ? @"" : obj.number ,
						 @"price":obj.shearPrice == nil ?@"":obj.shearPrice,
						 };
                [produstsItems addObject:param];
    }];
    
    if (produstsItems.count < 1) {
        BXS_Alert(@"请输入品名");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.nameCell.contentTF.text]) {
        BXS_Alert(@"请输入客户名称再选择");
        return;
    }

	WEAKSELF
	[self.collectionVC uploadDatePhotosWithUrlStr:^(NSString *urlStr) {
		weakSelf.urlStr = urlStr;
		[weakSelf requestComment:produstsItems];
	}];
}


- (void)requestComment:(NSMutableArray *)pProdustsItems{
	WEAKSELF
	NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
							 @"bankId":_payIdStr == nil ? @"0" : _payIdStr,
							 @"customerId":_customerIdStr,
							 @"deposit":[self.depositCell.contentTF.text isEqualToString:@""] ? @"0" : self.depositCell.contentTF.text,
							 @"imgs":self.urlStr == nil ?  @"":self.urlStr,
							 @"matter":self.warehouseTextView.textView.text,
							 @"orderNeedItems":[pProdustsItems mj_JSONString],
							 @"remark":self.remarkTextView.textView.text
							 };
	[BXSHttp requestGETWithAppURL:@"settle/create_order.do" param:param success:^(id response) {
		LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
		if ([baseModel.code integerValue] != 200) {
			[LLHudTools showWithMessage:baseModel.msg];
			return ;
		}

		NSDictionary *dic1 = baseModel.data;
		weakSelf.orderId = [dic1 objectForKey:@"orderId"];

		NSString *url = [NSString stringWithFormat:@"http://www.buxiaosheng.com/web-h5/html/print/needOrderPrint.html?companyId=%@&orderId=%@&housePrinter=%@",
						 [BXSUser currentUser].companyId,
						 weakSelf.orderId,
						 weakSelf.printerState];

		LZWKWebViewVC *webVC = [[LZWKWebViewVC alloc]init];
		webVC.url = url;
		//        NSLog(@"即将进入的页面链接：%@",url);
		[self.navigationController pushViewController:webVC animated:NO];

	} failure:^(NSError *error) {
		BXS_Alert(LLLoadErrorMessage);
	}];
}
//接口名称 仓库打印机配置状态
- (void)setupPrinterData{
	WEAKSELF
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"printer/house_printer_status.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        weakSelf.printerState = [NSString stringWithFormat:@"%@",baseModel.data];

    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)navigationSetupClick
{
    LZSaleOrderListVC *vc = [[LZSaleOrderListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.navigationController pushViewController:[LZWKWebViewVC new] animated:YES];
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
    WEAKSELF
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        self.paymentMethodCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
        weakSelf.payIdStr = weakSelf.payIdAry[row];
    };
    [self.view addSubview:pickerView];
}

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
- (UIView *)lineView3
{
	if (!_lineView3) {
		UIView *view = [[UIView alloc]init];
		view.backgroundColor = LZHBackgroundColor;
		[self.footerView addSubview:(_lineView3 = view)];
	}
	return _lineView3;
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
        cell.contentTF.enabled = NO;
        [self.footerView addSubview:(phoneCell = cell)];
    }
    return phoneCell;
}

- (TextInputCell *)arrearsCell
{
    if (!arrearsCell) {
        TextInputCell *cell = [[TextInputCell alloc]init];
        cell.titleLabel.text = @"本单应收";
        cell.contentTF.placeholder = @"请输入本单应收";
        cell.backgroundColor = [UIColor whiteColor];
        cell.contentTF.enabled = NO;
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

#pragma mark ----横屏设置 ----
//支持旋转
-(BOOL)shouldAutorotate{
    return NO;
}
//
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationUnknown;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
