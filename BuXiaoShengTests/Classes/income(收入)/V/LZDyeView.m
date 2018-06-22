//
//  LZDyeView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZDyeView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "ArrearsNameTextInputCell.h"
#import "UITextField+PopOver.h"
#import "LZReceipCustomerModel.h"

@interface LZDyeView()<LZHTableViewDelegate>
@property(nonatomic,weak)LZHTableView *myTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
///名称
@property(nonatomic,strong)ArrearsNameTextInputCell *titileCell;
///调整金额
@property(nonatomic,strong)TextInputCell *collectionCell;
///现欠款
@property(nonatomic,strong)TextInputCell *arrearsCell;
///备注
@property(nonatomic,strong)TextInputTextView *remarkTextView;
//客户数组
@property(nonatomic,strong)NSMutableArray *customerList;
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
@property(nonatomic,copy)NSString *customerId;///选择中的客户id
///保存按钮
@property(nonatomic,strong)UIButton *saveBtn;
@end

@implementation LZDyeView
@synthesize myTableView;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupCustomerList];
        [self setupUI];
    }
    return self;
}

- (LZHTableView *)myTableView
{
    if (myTableView == nil) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.bounds];
        tableView.backgroundColor = LZHBackgroundColor;
        [self addSubview:(myTableView = tableView)];
        
    }
    return myTableView;
}

- (void)setupUI{
    self.dataSource = [NSMutableArray array];
    [self addSubview:self.myTableView];
    [self setSectionOne];
    self.myTableView.dataSoure = self.dataSource;
    
    //保存按钮
    _saveBtn = [UIButton new];
    _saveBtn.backgroundColor = LZAppBlueColor;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(saveBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.left.and.right.equalTo(self);
        make.height.mas_offset(45);
    }];
}

- (void)setSectionOne{
    //    名称
    self.titileCell = [[ArrearsNameTextInputCell alloc]init];
    self.titileCell.frame = CGRectMake(0, 0, APPWidth, 75);
    self.titileCell.titleLabel.text = @"名称";
    self.titileCell.beforeLabel.text = @"前欠款:￥0";
    self.titileCell.contentTF.placeholder = @"请输入客户名称";
    self.titileCell.contentTF.scrollView = self;
    self.titileCell.contentTF.positionType = ZJPositionBottomTwo;
    
    //    收款金额
    self.collectionCell = [[TextInputCell alloc]init];
    self.collectionCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.collectionCell.contentTF.placeholder = @"请输入收款金额";
    self.collectionCell.titleLabel.text = @"调整金额";
    
    //    现欠款
    self.arrearsCell = [[TextInputCell alloc]init];
    self.arrearsCell.contentTF.textColor = [UIColor redColor];
    self.arrearsCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.arrearsCell.titleLabel.text = @"现欠款";
    self.arrearsCell.contentTF.placeholder = @"请输入现欠款";
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    lineView.backgroundColor = LZHBackgroundColor;
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titileCell,self.collectionCell,self.arrearsCell,lineView,self.remarkTextView];
    item.canSelected = NO;
    [self.dataSource addObject:item];
}

#pragma mark ----- 网络请求 -----
//接口名称 功能用到客户列表
- (void)setupCustomerList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _customerList = baseModel.data;
        _customerNameAry = [NSMutableArray array];
        _customerIdAry = [NSMutableArray array];
        for (int i = 0 ; i <_customerList.count; i++) {
            [_customerNameAry addObject:_customerList[i][@"name"]];
            [_customerIdAry addObject:_customerList[i][@"id"]];
        }
        //        名称cell设置数据源 获取客户id
        WEAKSELF
        [self.titileCell.contentTF popOverSource:_customerNameAry index:^(NSInteger index) {
            //设置名称 前欠款
            NSString *str = _customerList[index][@"mobile"];
            weakSelf.titileCell.beforeLabel.text = [NSString stringWithFormat:@"前欠款:￥%@",str];
            _customerId = _customerList[index][@"id"];
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//保存按钮事件
- (void)saveBtnOnClickAction{
    
    if ([BXSTools stringIsNullOrEmpty:self.titileCell.contentTF.text]) {
        BXS_Alert(@"请输入客户名称");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.collectionCell.contentTF.text]) {
        BXS_Alert(@"请输入收款金额");
        return;
    }
    //    接口名称 添加收款单
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"amount":self.collectionCell.contentTF.text,
                             @"arrears":self.arrearsCell.contentTF.text,
                             @"bankId":@"0",
                             @"customerId":self.customerId,
                             @"remark":self.remarkTextView.textView.text,
                             @"type":@"1"
                             };
    [BXSHttp requestGETWithAppURL:@"finance/receipt_add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        [LLHudTools showWithMessage:@"保存成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[self viewController].navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
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
