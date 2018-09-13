//
//  LZSalesDetailVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  订单详情页面

#import "LZSalesDetailVC.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZSalesDetailModel.h"
#import "LZSalesDetailCell.h"
#import "LZWKWebViewVC.h"

@interface LZSalesDetailVC ()<LZHTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *_url;
}
@property(nonatomic,weak)LZHTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UITableView *tableView;
///日期
@property(nonatomic,strong)UILabel *dateLbl;
@property(nonatomic,strong)UIView *lineView;
///客户名称
@property(nonatomic,strong)TextInputCell *nameCell;
///客户电话
@property(nonatomic,strong)TextInputCell *phoneCell;
///单号
@property(nonatomic,strong)TextInputCell *orderCell;
///预收贷款
@property(nonatomic,strong)TextInputCell *advanceMoneyCell;
///收款方式
@property(nonatomic,strong)TextInputCell *wayCell;
///备注
@property(nonatomic,strong)TextInputCell *remarkTextView;
///仓库注意事项
@property(nonatomic,strong)TextInputCell *noticeTextView;
@property(nonatomic,strong)LZSalesDetailModel *model;
@property(nonatomic,strong)NSArray <LZSalesDetailItemListModel *> *lists;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation LZSalesDetailVC
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
    [self setupPrinterData];
}

- (LZHTableView *)myTableView
{
    if (myTableView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = LZHBackgroundColor;
        tableView.delegate = self;
        [self.view addSubview:(myTableView = tableView)];
        
    }
    return myTableView;
}


- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"订单详情"];
    
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.myTableView];
    [self setSectionOne];
    [self setSectionTwo];
    self.myTableView.dataSoure = self.dataSource;
}

- (void)setSectionOne{
    
    _dateLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APPWidth -15*2, 34)];
    _dateLbl.backgroundColor = [UIColor whiteColor];
    _dateLbl.textColor = CD_Text99;
    _dateLbl.font = FONT(12);
    _dateLbl.text = @"12313213";
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0.5)];
    _lineView.backgroundColor = LZHBackgroundColor;
    
    
    //客户
    self.nameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.nameCell.lineView.hidden = YES;
    self.nameCell.titleLabel.text = @"客户";
    self.nameCell.userInteractionEnabled = NO;
    self.nameCell.contentTF.sd_layout
    .topEqualToView(self.nameCell.titleLabel)
    .leftSpaceToView(self.nameCell.titleLabel, -10)
    .heightRatioToView(self.nameCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    
    //客户电话
    self.phoneCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.phoneCell.titleLabel.text = @"客户电话";
    self.phoneCell.lineView.hidden = YES;
    self.phoneCell.userInteractionEnabled = NO;
    self.phoneCell.contentTF.sd_layout
    .topEqualToView(self.phoneCell.titleLabel)
    .leftSpaceToView(self.phoneCell.titleLabel, -10)
    .heightRatioToView(self.phoneCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    
    //单号
    self.orderCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.orderCell.titleLabel.text = @"单号";
    self.orderCell.userInteractionEnabled = NO;
    self.orderCell.lineView.hidden = YES;
    self.orderCell.contentTF.sd_layout
    .topEqualToView(self.orderCell.titleLabel)
    .leftSpaceToView(self.orderCell.titleLabel, -10)
    .heightRatioToView(self.orderCell, 1)
    .widthIs(LZHScale_WIDTH(350));
    
    
    //预收贷款
    self.advanceMoneyCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.advanceMoneyCell.contentTF.textColor = LZAppRedColor;
    self.advanceMoneyCell.titleLabel.text = @"预收贷款";
    self.advanceMoneyCell.contentTF.enabled = NO;
    self.advanceMoneyCell.lineView.hidden = YES;
    self.advanceMoneyCell.contentTF.sd_layout
    .topEqualToView(self.advanceMoneyCell.titleLabel)
    .leftSpaceToView(self.advanceMoneyCell.titleLabel, -10)
    .heightRatioToView(self.advanceMoneyCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    
    //收款方式
    self.wayCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 44)];
    self.wayCell.titleLabel.text = @"收款方式";
    self.wayCell.contentTF.enabled = NO;
    self.wayCell.lineView.hidden = YES;
    self.wayCell.contentTF.sd_layout
    .topEqualToView(self.wayCell.titleLabel)
    .leftSpaceToView(self.wayCell.titleLabel, -10)
    .heightRatioToView(self.wayCell, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    
    //备注
    self.remarkTextView = [[TextInputCell alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 44);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.lineView.hidden = YES;
    self.remarkTextView.userInteractionEnabled = NO;
    self.remarkTextView.sd_layout
    .topEqualToView(self.remarkTextView.titleLabel)
    .leftSpaceToView(self.remarkTextView.titleLabel, -10)
    .heightRatioToView(self.remarkTextView, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    
    //仓库注意事项
    self.noticeTextView = [[TextInputCell alloc]init];
    self.noticeTextView.frame = CGRectMake(0, 0, APPWidth, 44);
    self.noticeTextView.titleLabel.text = @"仓库注意事项";
    self.noticeTextView.lineView.hidden = YES;
    self.noticeTextView.userInteractionEnabled = NO;
    self.noticeTextView.sd_layout
    .topEqualToView(self.noticeTextView.titleLabel)
    .leftSpaceToView(self.noticeTextView.titleLabel, -10)
    .heightRatioToView(self.noticeTextView, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headview.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_dateLbl,_lineView,self.nameCell,self.phoneCell,self.orderCell,self.advanceMoneyCell,self.wayCell,self.remarkTextView,self.noticeTextView];
    item.sectionView = headview;
    item.canSelected = NO;
    [self.dataSource addObject:item];
}

- (void)setSectionTwo{
    
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
    
    UILabel *unitLabel = [[UILabel alloc]init];
    unitLabel.font = FONT(14);
    unitLabel.text = @"单位";
    unitLabel.textAlignment = NSTextAlignmentCenter;
    unitLabel.textColor = CD_Text33;
    [_headerView addSubview:unitLabel];
    
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
    
    unitLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(colorLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    numLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(unitLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(150));
    
    priceLabel.sd_layout
    .topSpaceToView(_headerView, 0)
    .leftSpaceToView(numLabel, 0)
    .heightRatioToView(_headerView, 1)
    .widthIs(LZHScale_WIDTH(105));
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LZSalesDetailCell class] forCellReuseIdentifier:@"LZSalesDetailCell"];
    
    
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headview.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_headerView,_tableView];
    item.sectionView = headview;
    item.canSelected = NO;
    [self.dataSource addObject:item];
}


#pragma mark ---- 网络请求 ----
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderId":self.orderId
                             };
    [BXSHttp requestGETWithAppURL:@"sale/need_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZSalesDetailModel LLMJParse:baseModel.data];
        _lists = [LZSalesDetailItemListModel LLMJParse:_model.itemList];
        
        //赋值
        _dateLbl.text = [BXSTools stringFromTimestamp:[BXSTools getTimeStrWithString:_model.createTime]];
        self.nameCell.contentTF.text = _model.customerName;
        self.phoneCell.contentTF.text = _model.customerMobile;
        self.orderCell.contentTF.text = _model.orderNo;
        self.advanceMoneyCell.contentTF.text = _model.deposit;
        self.wayCell.contentTF.text = _model.bankName;
        self.remarkTextView.contentTF.text = _model.remark;
        self.noticeTextView.contentTF.text = _model.matter;
        //
        //        //更新第一部分
        //        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
        //        headview.backgroundColor = LZHBackgroundColor;
        //        LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
        //        if ([self.remarkTextView.textView.text isEqualToString:@""] && [self.noticeTextView.textView.text isEqualToString:@""]) {
        //            item.sectionRows = @[_dateLbl,_lineView,self.nameCell,self.phoneCell,self.orderCell,self.advanceMoneyCell,self.wayCell];
        //        }else if ([self.remarkTextView.textView.text isEqualToString:@""] && ![self.noticeTextView.textView.text isEqualToString:@""]){
        //            item.sectionRows = @[_dateLbl,_lineView,self.nameCell,self.phoneCell,self.orderCell,self.advanceMoneyCell,self.wayCell,self.noticeTextView];
        //        }else if (![self.remarkTextView.textView.text isEqualToString:@""] && [self.noticeTextView.textView.text isEqualToString:@""]){
        //            item.sectionRows = @[_dateLbl,_lineView,self.nameCell,self.phoneCell,self.orderCell,self.advanceMoneyCell,self.wayCell,self.remarkTextView];
        //        }else{
        //            item.sectionRows = @[_dateLbl,_lineView,self.nameCell,self.phoneCell,self.orderCell,self.advanceMoneyCell,self.wayCell,self.remarkTextView,self.noticeTextView];
        //        }
        //        item.sectionView = headview;
        //        [self.dataSource replaceObjectAtIndex:0 withObject:item];
        //
        //        //更新第二部分
        //        _tableView.frame = CGRectMake(0, 0, APPWidth, 44 *_lists.count);
        //        [_tableView reloadData];
        //        LZHTableViewItem *item1 = [[LZHTableViewItem alloc]init];
        //        item1.sectionRows = @[_headerView,_tableView];
        //        item1.sectionView = headview;
        //        [self.dataSource replaceObjectAtIndex:1 withObject:item1];
        [self.myTableView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 仓库打印机配置状态
- (void)setupPrinterData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"printer/house_printer_status.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSString *printerState = [NSString stringWithFormat:@"%@",baseModel.data];
        _url = [NSString stringWithFormat:@"http://www.buxiaosheng.com/web-h5/html/print/needOrderPrint.html?companyId=%@&orderId=%@&housePrinter=%@",[BXSUser currentUser].companyId,self.orderId,printerState];
        NSLog(@"拼接得到的打印机网址：%@",_url);
        self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationSetupClick) image:IMAGE(@"print")];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ----横屏设置 ----
//支持旋转
-(BOOL)shouldAutorotate{
    return NO;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

//一开始的方向  很重要
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationUnknown;
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LZSalesDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LZSalesDetailCell"];
    cell.model = _lists[indexPath.row];
    return cell;
}

- (void)navigationSetupClick{
    LZWKWebViewVC *webVC = [[LZWKWebViewVC alloc]init];
    webVC.url = _url;
    [self.navigationController pushViewController:webVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
