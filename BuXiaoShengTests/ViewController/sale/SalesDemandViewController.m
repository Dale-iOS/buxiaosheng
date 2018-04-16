//
//  SalesDemandViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/12.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  销售需求页面

#import "SalesDemandViewController.h"
#import "SalesDemandListView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"

@interface SalesDemandViewController ()<LZHTableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *datasource;
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
///本单欠款
@property (nonatomic, strong) TextInputCell *arrearsCell;
///收款方式
@property (nonatomic, strong) TextInputCell *paymentMethodCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
///仓库注意事项
@property (nonatomic, strong) TextInputTextView *warehouseTextView;

///下一步按钮
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation SalesDemandViewController
@synthesize mainTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (LZHTableView *)mainTableView
{
    if (!mainTableView) {
        LZHTableView *tabelView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight -44)];
        [self.view addSubview:(mainTableView = tabelView)];
    }
    return mainTableView;
}


- (void)setupUI
{
    self.navigationItem.title = @"销售需求";
    self.view.backgroundColor = [UIColor whiteColor ];
    
    self.datasource = [NSMutableArray array];
    
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    [self setSectionFour];
    
    self.mainTableView.dataSoure = self.datasource;
    
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

- (void)setSectionOne
{
    self.demandListView = [[SalesDemandListView alloc]init];
    self.demandListView.frame = CGRectMake(0, 0, APPWidth, 250);
    self.demandListView.backgroundColor = [UIColor blueColor];
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.demandListView];
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    self.nameCell = [[TextInputCell alloc]init];
    self.nameCell.hidden = NO;
//    self.nameCell.backgroundColor = [UIColor redColor];
    self.nameCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.phoneCell = [[TextInputCell alloc]init];
    self.phoneCell.hidden = NO;
//    self.phoneCell.backgroundColor = [UIColor orangeColor];
    self.phoneCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    
    self.depositCell = [[TextInputCell alloc]init];
    self.depositCell.hidden = NO;
//    self.depositCell.backgroundColor = [UIColor greenColor];
    self.depositCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    
    self.nameCell.titleLabel.text = @"客户名字";
    self.nameCell.contentTF.text = @"周鹏";
    
    self.phoneCell.titleLabel.text = @"客户电话";
    self.phoneCell.contentTF.placeholder = @"请输入客户电话";
    
    self.depositCell.titleLabel.text = @"预收定金";
    self.depositCell.contentTF.text = @"￥25,689";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.nameCell,self.phoneCell,self.depositCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setSectionThree
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    self.adjustmentCell = [[TextInputCell alloc]init];
    self.adjustmentCell.hidden = NO;
    self.adjustmentCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.actualCell = [[TextInputCell alloc]init];
    self.actualCell.hidden = NO;
    self.actualCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.arrearsCell = [[TextInputCell alloc]init];
    self.arrearsCell.hidden = NO;
    self.arrearsCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.paymentMethodCell = [[TextInputCell alloc]init];
    self.paymentMethodCell.hintLabel.hidden = NO;
    self.paymentMethodCell.rightArrowImageVIew.hidden = NO;
    self.paymentMethodCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 80);
    self.remarkTextView.textView.delegate = self;
    
    
    self.adjustmentCell.titleLabel.text = @"调整金额";
    self.adjustmentCell.contentTF.placeholder = @"请输入调整金额";
    self.adjustmentCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.actualCell.titleLabel.text = @"实收金额";
    self.actualCell.contentTF.text = @"500";
    self.actualCell.frame = CGRectMake(0, 0, APPWidth, 49);
    
    self.arrearsCell.titleLabel.text = @"本单欠款";
    self.arrearsCell.contentTF.text = @"100";
    self.arrearsCell.contentTF.textColor = [UIColor redColor];
    
    self.paymentMethodCell.titleLabel.text = @"付款方式";
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.adjustmentCell,self.actualCell,self.arrearsCell,self.paymentMethodCell,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionFour
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    self.warehouseTextView = [[TextInputTextView alloc]init];
    self.warehouseTextView.frame = CGRectMake(0, 0, APPWidth, 80);
    self.warehouseTextView.textView.delegate = self;
    
    self.warehouseTextView.titleLabel.text = @"仓库注意事项";
    self.warehouseTextView.textView.placeholder = @"请输入告知仓库事项";
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPHeight, 60)];
    footerView.backgroundColor = LZHBackgroundColor;
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.warehouseTextView,footerView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}


#pragma mark -------- 点击事件 ----------
- (void)nextBtnOnClickAction
{
    NSLog(@"点击了 下一步 按钮");
}


#pragma mark ----- uitextview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //    限制textView最大字数
#define MY_MAX 36
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        
//        [Utility showToastWithMessage:@"限制字数200以内"];
        
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
