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

@interface SalesDemandViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,SalesDemandCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) salesDemandModel *cellsModel;
@property (nonatomic, strong) NSMutableArray <salesDemandModel *>* dataMuArray;

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

@end

@implementation SalesDemandViewController
@synthesize nameCell,phoneCell,depositCell,adjustmentCell,actualCell,arrearsCell,paymentMethodCell,remarkTextView,warehouseTextView,lineView1,lineView2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
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
    NSLog(@"点击了 下一步 按钮");
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

- (void)didClickTitleBtn:(UIButton *)titleBtn
{
    LZSearchVC *vc = [[LZSearchVC alloc]init];
    vc.titleStr = @"选择品名";
    vc.searchType = searchProduct;
    [self.navigationController pushViewController:vc animated:YES];
    
    [vc setTitleBtnBlock:^(NSString *titleInfo) {
        [titleBtn setTitle:titleInfo forState:UIControlStateNormal];
    }];
}

- (void)didClickTitleTextField:(NSString *)titleTFInfo
{
//    WEAKSELF
//
//    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] titleDataArray:nil];
//    pickerView.titleLabel.text = @"请选择品名";
//    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
////        weakSelf.principalCell.contentTF.text = compoentString;
////        NSInteger row = [titileString integerValue];
////        weakSelf.priceipalId = weakSelf.principalIdAry[row];
////
//    };
//
//    [self.view addSubview:pickerView];
    
    LZSearchVC *vc = [[LZSearchVC alloc]init];
    vc.titleStr = @"选择品名";
    vc.searchType = searchProductColor;
    [self.navigationController pushViewController:vc animated:YES];
    
    
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



@end
