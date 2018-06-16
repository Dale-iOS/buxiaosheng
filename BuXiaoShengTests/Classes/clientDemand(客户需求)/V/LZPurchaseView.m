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
@end

@implementation LZPurchaseView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        [self setupCustomerList];
//        [self setupPayList];
        [self setupUI];
    }
    return self;
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
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
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
    
    //联系人
    self.contactCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.companyCell.bottom, APPWidth, 49)];
    self.contactCell.titleLabel.text = @"联系人";
    self.contactCell.contentTF.placeholder = @"请输入联系人";
    
    //电话
    self.phoneCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.contactCell.bottom, APPWidth, 49)];
    self.phoneCell.titleLabel.text = @"电话";
    self.phoneCell.contentTF.placeholder = @"请输入电话";
    
    //地址
    self.addresCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.phoneCell.bottom, APPWidth, 49)];
    self.addresCell.titleLabel.text = @"地址";
    self.addresCell.contentTF.placeholder = @"请输入地址";
    
    //第二条灰色line
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.addresCell.bottom, APPWidth, 10)];
    lineView2.backgroundColor = LZHBackgroundColor;
    
    //指派人
    self.assignCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, self.phoneCell.bottom, APPWidth, 49)];
    self.assignCell.titleLabel.text = @"指派人";
    self.assignCell.contentTF.placeholder = @"请选址指派人";
    self.assignCell.rightArrowImageVIew.hidden = NO;
    self.assignCell.titleLabel.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    
    //第三条灰色line
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, self.assignCell.bottom, APPWidth, 10)];
    lineView3.backgroundColor = LZHBackgroundColor;
    
    //备注
    self.remarkTextView = [[TextInputTextView alloc]initWithFrame:CGRectMake(0, self.assignCell.bottom, APPWidth, 79)];
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    [self.footerView addSubview:addView];
    [self.footerView addSubview:lineView1];
    [self.footerView addSubview:self.companyCell];
    [self.footerView addSubview:self.contactCell];
    [self.footerView addSubview:self.phoneCell];
    [self.footerView addSubview:self.addresCell];
    [self.footerView addSubview:lineView2];
    [self.footerView addSubview:self.assignCell];

}

- (void)setupUI{
    
    [self setupFooterView];
    
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = LZHBackgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = self.footerView;
    //隐藏分割线
//    self.tableView .separatorStyle = NO;
    [self addSubview:self.tableView];
}

#pragma mark ----- tableviewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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

@end
