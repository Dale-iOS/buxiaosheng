//
//  AddClienViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加客户页面

#import "AddClienViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"

@interface AddClienViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///名称
@property (nonatomic, strong) TextInputCell *titleCell;
///手机号码
@property (nonatomic, strong) TextInputCell *mobileCell;
///地址
@property (nonatomic, strong) TextInputCell *addressCell;
///分组
@property (nonatomic, strong) TextInputCell *groupCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///别名
@property (nonatomic, strong) TextInputCell *aliasCell;
///负责人
@property (nonatomic, strong) TextInputCell *principalCell;
///信用额度
@property (nonatomic, strong) TextInputCell *quotaCell;
///超额度操作
@property (nonatomic, strong) TextInputCell *exceedQuotaCell;

///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;

@end

@implementation AddClienViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight)];
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"添加客户资料"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(makeSureClick) title:@"确认"];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //名称
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.contentTF.placeholder = @"请输入客户名称";
    self.titleCell.titleLabel.text = @"名称";
    
    //名称
    self.mobileCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.mobileCell.contentTF.placeholder = @"请输入客户手机号码";
    self.mobileCell.titleLabel.text = @"手机名称";
    
    //名称
    self.addressCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.addressCell.contentTF.placeholder = @"请输入客户地址";
    self.addressCell.titleLabel.text = @"地址";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.mobileCell,self.addressCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //分组
    self.groupCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.groupCell.contentTF.placeholder = @"请选择分组";
    self.groupCell.titleLabel.text = @"分组";
    self.groupCell.rightArrowImageVIew.hidden = NO;
    self.groupCell.contentTF.enabled = NO;
    
    //状态
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.contentTF.placeholder = @"请选择状态";
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.contentTF.enabled = NO;
    
    //别名
    self.aliasCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.aliasCell.contentTF.placeholder = @"请输入客户别名";
    self.aliasCell.titleLabel.text = @"别名";
    
    //负责人
    self.principalCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.principalCell.contentTF.placeholder = @"请选择负责人";
    self.principalCell.titleLabel.text = @"负责人";
    self.principalCell.rightArrowImageVIew.hidden = NO;
    self.principalCell.contentTF.enabled = NO;
    
    //信用额度
    self.quotaCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.quotaCell.contentTF.placeholder = @"请输入给客户的信用额度";
    self.quotaCell.titleLabel.text = @"信用额度";
    
    //超额度操作
    self.exceedQuotaCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.exceedQuotaCell.contentTF.placeholder = @"请选择客户的超额度操作";
    self.exceedQuotaCell.rightArrowImageVIew.hidden = NO;
    self.exceedQuotaCell.titleLabel.text = @"超额度操作";
    self.exceedQuotaCell.contentTF.enabled = NO;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.groupCell,self.stateCell,self.aliasCell,self.principalCell,self.quotaCell,self.exceedQuotaCell];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)setSectionThree
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)makeSureClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
