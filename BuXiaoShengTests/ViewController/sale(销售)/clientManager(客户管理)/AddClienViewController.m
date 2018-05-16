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
#import "LZPickerView.h"
#import "LLAuditMangerModel.h"

@interface AddClienViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///名称
@property (nonatomic, strong) TextInputCell *titleCell;
///手机号码
@property (nonatomic, strong) TextInputCell *mobileCell;
///地址
@property (nonatomic, strong) TextInputCell *addressCell;
///标签
@property (nonatomic, strong) TextInputCell *tallyCell;
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

///标签列表数据
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * tallys;
///负责人列表数据
@property (nonatomic,strong) NSArray <LLAuditMangerModel *> * principals;
@end

@implementation AddClienViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupCustomerData];
    [self setupPrincipalData];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self setupCustomerData];
//    [self setupPrincipalData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight)];
        tableView.delegate = self;
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
    self.tallyCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.tallyCell.contentTF.placeholder = @"请选择标签";
    self.tallyCell.titleLabel.text = @"标签";
    self.tallyCell.rightArrowImageVIew.hidden = NO;
    self.tallyCell.contentTF.enabled = NO;
    
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
    self.quotaCell.contentTF.placeholder = @"给客户的信用额度";
    self.quotaCell.titleLabel.text = @"信用额度";
    
    //超额度操作
    self.exceedQuotaCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.exceedQuotaCell.contentTF.placeholder = @"客户的超额度操作";
    self.exceedQuotaCell.rightArrowImageVIew.hidden = NO;
    self.exceedQuotaCell.titleLabel.text = @"超额度操作";
    self.exceedQuotaCell.contentTF.enabled = NO;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.tallyCell,self.stateCell,self.aliasCell,self.principalCell,self.quotaCell,self.exceedQuotaCell];
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

#pragma mark -------- 网络请求 --------
//获取标签数据
- (void)setupCustomerData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId};
    
    [BXSHttp requestGETWithAppURL:@"customer_label/list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.tallys = [LLAuditMangerModel LLMJParse:baseModel.data];

    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}

//获取负责人列表
- (void)setupPrincipalData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId};
    
    [BXSHttp requestGETWithAppURL:@"member/list.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
////        LLAuditMangerModel *model = [LLAuditMangerModel LLMJParse:baseModel.data];
//        LLAuditMangerModel *model = [LLAuditMangerModel LLMJParse:baseModel.data];
//        self.principals = model.itemList;
////        self.principals.firstObject.sectionClick = true;

    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}


//tableview点击事件
-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WEAKSELF;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        if (!self.tallys) {
            [LLHudTools showWithMessage:@"暂无标签可选"];
            return;
        }
        
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.tallys titleDataArray:nil];
        //测试
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            weakSelf.tallyCell.contentTF.text = compoentString;
        };
        
        [self.view addSubview:pickerView];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
    
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该科目启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * enabled = [UIAlertAction actionWithTitle:@"启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.stateCell.contentTF.text = @"启用";
        }];
        
        UIAlertAction * disEnabled = [UIAlertAction actionWithTitle:@"未启用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.stateCell.contentTF.text = @"未启用";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:enabled];
        [alterVc addAction:disEnabled];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }else if (indexPath.section == 1 && indexPath.row == 3){
     
//        if (!self.principals) {
//            [LLHudTools showWithMessage:@"暂无负责人可选"];
//            return;
//        }
     
        
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:@[@"1",@"2"] titleDataArray:nil];
        //测试
        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
            weakSelf.principalCell.contentTF.text = compoentString;
            NSLog(@"+++++%@",titileString);
        };
        
        [self.view addSubview:pickerView];
        
    }else if (indexPath.section == 1 && indexPath.row ==5){
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用高额度操作" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * enabled = [UIAlertAction actionWithTitle:@"提醒" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.exceedQuotaCell.contentTF.text = @"提醒";
        }];
        
        UIAlertAction * disEnabled = [UIAlertAction actionWithTitle:@"不能保存单据" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.exceedQuotaCell.contentTF.text = @"不能保存单据";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:enabled];
        [alterVc addAction:disEnabled];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }

    
}


- (void)makeSureClick
{
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入客户名称");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.mobileCell.contentTF.text]) {
        BXS_Alert(@"请输入客户手机号码");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.addressCell.contentTF.text]) {
        BXS_Alert(@"请输入客户地址");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.aliasCell.contentTF.text]) {
        BXS_Alert(@"请输入客户别名");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.quotaCell.contentTF.text]) {
        BXS_Alert(@"请输入信用额度");
        return;
    }
    
    NSInteger status = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        status = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        status = 1;
    }
    
    NSInteger exceedQuotas = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"提醒"]) {
        exceedQuotas = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"单据"]){
        exceedQuotas = 1;
    }
    
    
    NSDictionary *param =@{@"name":self.titleCell.titleLabel.text,
                           @"mobile":self.mobileCell.titleLabel.text,
                           @"address":self.addressCell.titleLabel.text,
                           @"labelId":self.tallyCell.titleLabel.text,
                           @"status":@(status),
                           @"alias":self.aliasCell.titleLabel.text,
                           @"memberId":self.principalCell.titleLabel.text,
                           @"quota":self.quotaCell.titleLabel.text,
                           @"excessOperation":@(exceedQuotas),
                           @"remark":self.remarkTextView.textView.text
                           };
    
    [BXSHttp requestPOSTWithAppURL:@"customer/add.do" param:param success:^(id response) {
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
