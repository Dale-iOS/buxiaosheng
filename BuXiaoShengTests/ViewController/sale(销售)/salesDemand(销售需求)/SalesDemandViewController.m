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
//#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "salesDemandModel.h"
#import "LZPickerView.h"
//#import "ChooseAddressVC.h"
#import "LZSearchVC.h"
#import "UITextField+PopOver.h"
#import "salesDemandModel.h"

@interface SalesDemandViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,SalesDemandCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) salesDemandModel *cellsModel;
@property (nonatomic, strong) NSMutableArray <salesDemandModel *>* dataMuArray;
@property (nonatomic, strong)NSArray *dataSources;
//@property (weak, nonatomic) LZHTableView *mainTableView;
//@property (strong, nonatomic) NSMutableArray *datasource;
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

@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;

///下一步按钮
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableArray <productListModel *> *products;
@property (nonatomic, strong) NSMutableArray <productListModel *> *productColors;
//展示图产品列表名称数组
@property (nonatomic, strong) NSMutableArray *productsListMTArray;
//展示图产品列表ID数组
@property (nonatomic, strong) NSMutableArray *productsIdMTArray;
//展示图产品颜色列表数组
@property (nonatomic, strong) NSMutableArray *productsColorsListMTArray;
@property (nonatomic, copy) NSString *ProductColorId;
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
        UIGestureRecognizer * tap = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(paymentMethodCellClick)];
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

- (void)setupUI
{
    self.navigationItem.title = @"销售需求";
    self.view.backgroundColor = [UIColor whiteColor ];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"search")];
    
    self.dataArray = [NSMutableArray array];
    self.dataMuArray = [NSMutableArray array];
    self.cellsModel = [[salesDemandModel alloc]init];

    [self setupHeaderView];
    [self setupFooterView];
    
    //初始化tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,LLNavViewHeight, APPWidth, APPHeight -44-LLNavViewHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    
//    self.datasource = [NSMutableArray array];
//
//    self.mainTableView.delegate = self;
//    [self.view addSubview:self.mainTableView];
//
//    [self setSectionOne];
//    [self setSectionTwo];
//    [self setSectionThree];
//    [self setSectionFour];
//
//    self.mainTableView.dataSoure = self.datasource;
//
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
        _products = [productListModel LLMJParse:baseModel.data];
        //拼接要展示的列表数据
        _productsListMTArray = [NSMutableArray array];
        _productsIdMTArray = [NSMutableArray array];
        if (_products) {
            for (int i = 0; i <_products.count; i++) {
                productListModel *model = [productListModel LLMJParse:_products[i]];
                [_productsListMTArray addObject:model.name];
                [_productsIdMTArray addObject:model.id];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

//功能用到颜色列表
- (void)setupProductColorData
{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"productId":_ProductColorId
                             };
    [BXSHttp requestGETWithAppURL:@"product_color/color_list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        _productColors = [productListModel LLMJParse:baseModel.data];
        _productsColorsListMTArray = [NSMutableArray array];
        if (_productColors) {
            for (int i = 0; i <_productColors.count; i++) {
                productListModel *model = [productListModel LLMJParse:_productColors[i]];
                [_productsColorsListMTArray addObject:model.name];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMuArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cellid";
    SalesDemandCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SalesDemandCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self;
        
        if (self.dataMuArray.count >0) {
            
            [cell settitleTFContent:self.cellsModel.titleInfo WithColorTFContent:self.cellsModel.colorInfo WithlineTFContent:self.cellsModel.lineInfo WithNumberTFContent:self.cellsModel.numberInfo WithPriceTFContent:self.cellsModel.priceInfo WithReturnBlock:^(salesDemandModel *model) {
                

                //防止上一条有tf为空不传值为空
                if (!model.titleInfo) {
                    model.titleInfo = self.cellsModel.titleInfo;
                }
                if (!model.colorInfo)
                {
                    model.colorInfo = self.cellsModel.colorInfo;
                }
                if (!model.lineInfo)
                {
                    model.lineInfo = self.cellsModel.lineInfo;
                }
                if (!model.numberInfo)
                {
                    model.numberInfo = self.cellsModel.numberInfo;
                }if (!model.priceInfo)
                {
                    model.priceInfo = self.cellsModel.numberInfo;
                }
                    
                
                self.cellsModel = model;
            }];
        }
        }

    return cell;
}

//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    
}

//是否可以编辑tableView的cell
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//编辑cell是触发此方法
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //要先把数据源的对应的数据删除掉
    [self.dataMuArray removeObjectAtIndex:indexPath.row];
    
    //删除cell
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark -------- 点击事件 ----------
- (void)nextBtnOnClickAction
{
    
}

- (void)navigationSetupClick
{
    NSLog(@"点击了放大镜");

}

- (void)addBtnOnClickAction
{
    [self.dataMuArray addObject:self.cellsModel];
    [self.tableView reloadData];
}

//品名TF点击方法
- (void)didClickTitleTextField:(UITextField *)titleTF
{
    titleTF.delegate = self;
    //        cell.colorTF.borderStyle = UITextBorderStyleRoundedRect;
    titleTF.scrollView = self.view;
    titleTF.positionType = ZJPositionAuto;
    [titleTF popOverSource:_productsListMTArray index:^(NSInteger index) {
        _ProductColorId = _productsIdMTArray[index];
        [self setupProductColorData];
    }];
}

//颜色TF点击方法
- (void)didClickColorTextField:(UITextField *)colorTF
{
    colorTF.delegate = self;
    //        cell.colorTF.borderStyle = UITextBorderStyleRoundedRect;
    colorTF.scrollView = self.view;
    colorTF.positionType = ZJPositionAuto;
    [colorTF popOverSource:_productsColorsListMTArray index:^(NSInteger index) {
        NSLog(@"dataSources index == %ld",index);
        
    }];
}

//收款方式点击事件
- (void)paymentMethodCellClick
{
    NSLog(@"收款方式点击事件");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*)dataSources{
    if (!_dataSources) {
        _dataSources = @[@"安能物流", @"安迅物流", @"巴伦支快递", @"北青小红帽", @"百世汇通", @"百福东方物流", @"邦送物流", @"宝凯物流", @"百千诚物流", @"博源恒通",
                         @"百成大达物流", @"百世快运", @"COE（东方快递）", @"城市100", @"传喜物流", @"城际速递", @"成都立即送", @"出口易", @"晟邦物流", @"DHL快递（中国件）", @"DHL（国际件）", @"DHL（德国件）", @"德邦", @"大田物流", @"东方快递", @"递四方",
                         @"大洋物流", @"店通快递", @"德创物流", @"东红物流", @"D速物流", @"东瀚物流", @"达方物流", @"EMS快递查询", @"EMS国际快递查询", @"俄顺达", @"FedEx快递查询", @"FedEx国际件", @"FedEx（美国）", @"凡客如风达", @"飞康达物流",
                         @"飞豹快递", @"飞狐快递", @"凡宇速递", @"颿达国际", @"飞远配送", @"飞鹰物流", @"风行天下", @"GATI快递", @"国通快递", @"国际邮件查询", @"港中能达物流", @"挂号信/国内邮件", @"共速达", @"广通速递（山东）", @"广东速腾物流", @"港快速递",
                         @"高铁速递", @"冠达快递", @"华宇物流", @"恒路物流", @"好来运快递", @"华夏龙物流", @"海航天天", @"河北建华", @"海盟速递", @"华企快运", @"昊盛物流", @"户通物流", @"华航快递", @"黄马甲快递", @"合众速递（UCS）", @"韩润物流", @"皇家物流",
                         @"伙伴物流", @"红马速递", @"汇文配送", @"i-parcel", @"佳吉物流", @"佳怡物流", @"加运美快递", @"急先达物流", @"京广速递快件", @"晋越快递", @"京东快递", @"捷特快递", @"久易快递", @"快捷快递", @"康力物流", @"跨越速运", @"快优达速递",
                         @"快淘快递", @"联邦快递（国内）", @"联昊通物流", @"龙邦速递", @"乐捷递", @"立即送", @"蓝弧快递", @"乐天速递", @"民航快递", @"美国快递", @"门对门", @"明亮物流", @"民邦速递", @"闽盛快递", @"麦力快递", @"美国韵达", @"能达速递", @"偌亚奥国际",
                         @"平安达腾飞", @"陪行物流", @"全峰快递", @"全一快递", @"全日通快递", @"全晨快递", @"秦邦快运", @"如风达快递", @"日昱物流", @"瑞丰速递", @"申通快递", @"顺丰速运", @"速尔快递", @"山东海红", @"盛辉物流", @"世运快递", @"盛丰物流", @"上大物流",
                         @"三态速递", @"赛澳递", @"申通E物流", @"圣安物流", @"山西红马甲", @"穗佳物流", @"沈阳佳惠尔", @"上海林道货运", @"十方通物流", @"山东广通速递", @"TNT快递", @"天天快递", @"天地华宇", @"通和天下", @"天纵物流", @"同舟行物流", @"腾达速递",
                         @"UPS快递查询", @"UPS国际快递", @"UC优速快递", @"USPS美国邮政", @"万象物流", @"微特派", @"万家物流", @"万博快递", @"希优特快递", @"新邦物流", @"信丰物流", @"新蛋物流", @"祥龙运通物流", @"西安城联速递", @"西安喜来快递", @"鑫世锐达",
                         @"鑫通宝物流", @"圆通速递", @"韵达快运", @"运通快递",@"邮政国内", @"邮政国际", @"远成物流", @"亚风速递", @"优速快递", @"亿顺航", @"越丰物流", @"源安达快递", @"原飞航物流", @"邮政EMS速递", @"银捷速递", @"一统飞鸿", @"宇鑫物流", @"易通达",
                         @"邮必佳", @"一柒物流", @"音素快运", @"亿领速运", @"煜嘉物流", @"英脉物流", @"云豹国际货运", @"云南中诚", @"中通快递", @"宅急送", @"中铁快运", @"中铁物流",@"中邮物流", @"中国东方(COE)", @"芝麻开门", @"中国邮政快递", @"郑州建华",
                         @"中速快件", @"中天万运", @"中睿速递", @"中外运速递", @"增益速递", @"郑州速捷", @"智通物流"];
    }
    
    return _dataSources;
}

@end
