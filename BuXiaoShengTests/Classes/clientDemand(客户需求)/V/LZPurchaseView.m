//
//  LZPurchaseView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购(指派)

#import "LZPurchaseView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZChoosseWorkerVC.h"
#import "UITextField+PopOver.h"
#import "LZCompanyModel.h"

@interface LZPurchaseView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
///供货商名称
@property (nonatomic, strong) TextInputCell *companyCell;
///联系人
@property (nonatomic, strong) TextInputCell *contactCell;
///电话
@property (nonatomic, strong) TextInputCell *phoneCell;
///地址
@property (nonatomic, strong) TextInputCell *addresCell;
///指派
@property (nonatomic, strong) TextInputCell *assignCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
@property (nonatomic, strong) UIView *footerView;
@property(nonatomic,copy)NSString *SelectedWorkerId;//指派cell选中的员工id
//厂商数据
@property(nonatomic,strong)NSMutableArray *factoryListMuAry;
@property(nonatomic,strong)NSMutableArray *factoryNameAry;
@property(nonatomic,strong)NSMutableArray *factoryIdAry;
@property(nonatomic,copy)NSString *factoryId;//选择中的厂商id
@property(nonatomic,strong)LZCompanyModel *selectedModel;//选择中的厂商model
@end

@implementation LZPurchaseView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupFactoryListData];
        [self setupUI];
    }
    return self;
}
- (void)setOrderId:(NSString *)orderId{
    
    _orderId = orderId;
    [self setupProductDetail];
}
- (void)setupFooterView
{
    self.footerView = [[UIView alloc]init];
    self.footerView.userInteractionEnabled = YES;
    self.footerView.frame = CGRectMake(0, 0, APPWidth, 468);
    self.footerView.backgroundColor = [UIColor whiteColor];
    
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
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, addView.bottom, APPWidth, 10)];
    lineView1.backgroundColor = LZHBackgroundColor;
    lineView1.sd_layout
    .topSpaceToView(addView, 0)
    .leftSpaceToView(self.footerView, 0)
    .widthIs(APPWidth)
    .heightIs(10);
    
    //供货商名称
    self.companyCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, lineView1.bottom, APPWidth, 49)];
    self.companyCell.titleLabel.text = @"供货商名称";
    self.companyCell.contentTF.placeholder = @"请输入供货商名称";
    self.companyCell.contentTF.scrollView = self;
    self.companyCell.contentTF.positionType = ZJPositionTop;
    
    //联系人
    self.contactCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.companyCell.bottom, APPWidth, 49)];
    self.contactCell.titleLabel.text = @"联系人";
    self.contactCell.contentTF.placeholder = @"请输入联系人";
    self.contactCell.contentTF.enabled = NO;
    
    //电话
    self.phoneCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.contactCell.bottom, APPWidth, 49)];
    self.phoneCell.titleLabel.text = @"电话";
    self.phoneCell.contentTF.placeholder = @"请输入电话";
    self.phoneCell.contentTF.enabled = NO;
    
    //地址
    self.addresCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.phoneCell.bottom, APPWidth, 49)];
    self.addresCell.titleLabel.text = @"地址";
    self.addresCell.contentTF.placeholder = @"请输入地址";
    self.addresCell.contentTF.enabled = NO;
    
    //第二条灰色line
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.addresCell.bottom, APPWidth, 10)];
    lineView2.backgroundColor = LZHBackgroundColor;
    
    //指派人
    self.assignCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, lineView2.bottom, APPWidth, 49)];
    self.assignCell.titleLabel.text = @"指派人";
    self.assignCell.contentTF.placeholder = @"请选址指派人";
    self.assignCell.rightArrowImageVIew.hidden = NO;
    self.assignCell.titleLabel.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    self.assignCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tapAssignCell = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAssignCellClick)];
    [self.assignCell addGestureRecognizer:tapAssignCell];
    
    //第三条灰色line
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.assignCell.bottom, APPWidth, 10)];
    lineView3.backgroundColor = LZHBackgroundColor;
    
    //备注
    self.remarkTextView = [[TextInputTextView alloc]initWithFrame:CGRectMake(0, lineView3.bottom, APPWidth, 79)];
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    //第4条灰色line
    UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0, self.remarkTextView.bottom, APPWidth, 50)];
    lineView4.backgroundColor = LZHBackgroundColor;
    
    [self.footerView addSubview:addView];
    [self.footerView addSubview:lineView1];
    [self.footerView addSubview:self.companyCell];
    [self.footerView addSubview:self.contactCell];
    [self.footerView addSubview:self.phoneCell];
    [self.footerView addSubview:self.addresCell];
    [self.footerView addSubview:lineView2];
    [self.footerView addSubview:self.assignCell];
    [self.footerView addSubview:lineView3];
    [self.footerView addSubview:self.remarkTextView];
    [self.footerView addSubview:lineView4];

}

- (void)setupUI{
    
    [self setupFooterView];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = LZHBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = self.footerView;
    //隐藏分割线
//    self.tableView .separatorStyle = NO;
    [self addSubview:self.tableView];
}

#pragma mark ---- 网络请求 ----
//接口名称 功能用到厂商列表
- (void)setupFactoryListData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
//                             @"searchName":@"",
                             @"type":@"0"};
    [BXSHttp requestGETWithAppURL:@"factory/search_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        //        _factoryLists = [LZCompanyModel LLMJParse:baseModel.data];
        _factoryListMuAry = baseModel.data;
        _factoryNameAry = [NSMutableArray array];
        for (int i = 0; i <_factoryListMuAry.count; i++) {
            [_factoryNameAry addObject:_factoryListMuAry[i][@"name"]];
        }
        
        [self.companyCell.contentTF popOverSource:_factoryNameAry index:^(NSInteger index) {
            _selectedModel = [LZCompanyModel LLMJParse:_factoryListMuAry[index]];
            self.companyCell.contentTF.text = _selectedModel.name;
            self.contactCell.contentTF.text = _selectedModel.contactName;
            self.phoneCell.contentTF.text = _selectedModel.mobile;
            self.addresCell.contentTF.text = _selectedModel.address;
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 销售需求采购的产品的列表
- (void)setupProductDetail{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"orderId":self.orderId
                             };
    [BXSHttp requestGETWithAppURL:@"storehouse/product_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}



#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"AuditTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        cell.delegate = self;
    }
//    cell.model = _lists[indexPath.row];
    return cell;
}

#pragma mark ---- 点击事件 -----
- (void)addBtnOnClickAction{
    NSLog(@"点击了新增一条");
}

//选择指派人cell点击事件
- (void)tapAssignCellClick{
    LZChoosseWorkerVC *vc = [[LZChoosseWorkerVC alloc]init];
    vc.navTitle = @"选择指派人";
    [[self viewController].navigationController pushViewController:vc animated:YES];
    WEAKSELF;
    [vc setChooseBlock:^(NSString *workerId, NSString *workerName) {
        weakSelf.assignCell.contentTF.text = workerName;
        weakSelf.SelectedWorkerId = workerId;
    }];
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
