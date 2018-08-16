//
//  LZDyeView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  调整金额(收款单)

#import "LZDyeView.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "ArrearsNameTextInputCell.h"
#import "UITextField+PopOver.h"
#import "LZReceipCustomerModel.h"

@interface LZDyeView()<LZHTableViewDelegate,UITextFieldDelegate>
{
    NSString *_darkStr;//欠款
}
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
        [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(changeValue:)   name:@"changeValue"  object:nil];
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
    self.titileCell.titleLabel.text = @"*名称";
    self.titileCell.beforeLabel.text = @"前欠款:￥0";
    self.titileCell.contentTF.placeholder = @"请输入客户名称";
    self.titileCell.contentTF.scrollView = (UIScrollView *)self;
    self.titileCell.contentTF.positionType = ZJPositionBottomTwo;
    if ([self.titileCell.titleLabel.text containsString:@"*"]) {
        [self.titileCell.titleLabel setupAttributeString:self.titileCell.titleLabel.text changeText:@"*" color:[UIColor redColor]];
    }
    
    //    收款金额
    self.collectionCell = [[TextInputCell alloc]init];
    self.collectionCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.collectionCell.contentTF.placeholder = @"请输入收款金额";
    self.collectionCell.titleLabel.text = @"*调整金额";
    self.collectionCell.contentTF.delegate = self;
    self.collectionCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.collectionCell.contentTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if ([self.collectionCell.titleLabel.text containsString:@"*"]) {
        [self.collectionCell.titleLabel setupAttributeString:self.collectionCell.titleLabel.text changeText:@"*" color:[UIColor redColor]];
    }
    
    //    现欠款
    self.arrearsCell = [[TextInputCell alloc]init];
    self.arrearsCell.contentTF.textColor = LZAppRedColor;
    self.arrearsCell.frame = CGRectMake(0, 0, APPWidth, 49);
    self.arrearsCell.titleLabel.text = @"现欠款";
    self.arrearsCell.contentTF.placeholder = @"请选择客户";
    self.arrearsCell.contentTF.enabled = NO;
    
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
             _darkStr = _customerList[index][@"mobile"];
            weakSelf.titileCell.beforeLabel.text = [NSString stringWithFormat:@"前欠款:￥%@", _darkStr];
            weakSelf.arrearsCell.contentTF.text = [NSString stringWithFormat:@"￥%@",_darkStr];
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
        BXS_Alert(@"请输入调整金额");
        return;
    }
    //    接口名称 添加收款单
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"amount":self.collectionCell.contentTF.text,
                             @"arrears":self.arrearsCell.contentTF.text,
                             @"customerId":self.customerId,
                             @"remark":self.remarkTextView.textView.text,
                             @"type":@"1",
                             @"bankId":@"0"
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

#pragma mark ---- uitextfieldDelegate ----
-(void)textFieldDidChange:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:textField];
}
-(void)changeValue:(NSNotification *)notification {
    UITextField *textField = notification.object;
    float floatValue = _darkStr.floatValue - textField.text.floatValue;
    self.arrearsCell.contentTF.text = [NSString stringWithFormat:@"￥%.2f",floatValue];
    //要实现的监听方法操作
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
