//
//  AddClienViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加客户资料页面

#import "AddClienViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "LZPickerView.h"
#import "LLAuditMangerModel.h"
#import "LZClientModel.h"
#import "LZClientDetailsModel.h"
#import "LZChooseLabelVC.h"

@interface AddClienViewController ()<LZHTableViewDelegate,UITextFieldDelegate>

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
///初始欠款
@property (nonatomic, strong) TextInputCell *arrearageCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;

///标签列表数据
@property (nonatomic,strong) NSArray <LLAuditMangerItemModel *> * tallys;

///负责人model
@property (nonatomic,strong) NSArray <LZClientModel *> * clienModel;
@property (nonatomic, strong) LZClientDetailsModel *detailModel;

///负责人数组
@property (nonatomic, strong) NSArray *principalNameAry;
@property (nonatomic, strong) NSArray *principalIdAry;
@property (nonatomic, copy) NSString *priceipalId;
///标签数组
@property (nonatomic, strong) NSArray *labelsIDAry;
@property (nonatomic, strong) NSArray *labelsNameAry;
@property (nonatomic, copy) NSString *labelslId;
@end

@implementation AddClienViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupClientDetailData];
//    [self setupCustomerData];
    [self setupPrincipalData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:self.view.bounds];
        tableView.delegate = self;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{
    self.navigationItem.titleView = self.isFormSelect ? [Utility navTitleView:@"修改客户资料"] : [Utility navTitleView:@"添加客户资料"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(makeSureClick) title:@"确认"];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;

}

- (void)setupClientDetailData
{
    if (!self.isFormSelect) {
        return;
    }
    
    NSDictionary * param = @{@"id":self.id};
    [BXSHttp requestGETWithAppURL:@"customer/detail.do" param:param success:^(id response) {
        NSLog(@"%@",response);
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            return ;
        }
        
        self.detailModel = [LZClientDetailsModel LLMJParse:baseModel.data];
        
        //开始赋值
        self.titleCell.contentTF.text = self.detailModel.name;
        self.mobileCell.contentTF.text = self.detailModel.mobile;
        self.addressCell.contentTF.text = self.detailModel.address;
        self.tallyCell.contentTF.text = self.detailModel.labelName;
        self.labelslId = self.detailModel.labelId;
        self.arrearageCell.contentTF.text = self.detailModel.initialValue;
        if ([self.detailModel.status integerValue] == 0) {
            self.stateCell.contentTF.text = @"启用";
        }else
        {
            self.stateCell.contentTF.text = @"未启用";
        }
        self.aliasCell.contentTF.text = self.detailModel.alias;
        self.principalCell.contentTF.text = self.detailModel.memberName;
        self.priceipalId = self.detailModel.memberId;
        self.quotaCell.contentTF.text = self.detailModel.quota;
        if ([self.detailModel.excessOperation integerValue] == 0) {
            self.exceedQuotaCell.contentTF.text = @"提醒";
        }else
        {
            self.exceedQuotaCell.contentTF.text = @"不能保存单据";
        }
        self.remarkTextView.textView.text = self.detailModel.remark;
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}


- (void)setSectionOne
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //名称
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.contentTF.placeholder = @"请输入客户名称";
    self.titleCell.titleLabel.text = @"客户名称";
    
    //手机
    self.mobileCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.mobileCell.contentTF.placeholder = @"请输入客户手机(非必填)";
    self.mobileCell.titleLabel.text = @"手机号码";
    
    //地址
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
    self.quotaCell.contentTF.delegate = self;
    self.quotaCell.contentTF.keyboardType = UIKeyboardTypeNumberPad;
    
    //超额度操作
    self.exceedQuotaCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.exceedQuotaCell.contentTF.placeholder = @"客户的超额度操作";
    self.exceedQuotaCell.rightArrowImageVIew.hidden = NO;
    self.exceedQuotaCell.titleLabel.text = @"超额度操作";
    self.exceedQuotaCell.contentTF.enabled = NO;
    
    
    //初始欠款
    self.arrearageCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.arrearageCell.contentTF.placeholder = @"请输入初始欠款";
    self.arrearageCell.rightArrowImageVIew.hidden = YES;
    self.arrearageCell.titleLabel.text = @"初始欠款";
//    self.arrearageCell.contentTF.enabled = NO;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.tallyCell,self.stateCell,self.aliasCell,self.principalCell,self.quotaCell,self.exceedQuotaCell,self.arrearageCell];
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
        self.tallys = [LLAuditMangerItemModel LLMJParse:baseModel.data];
        
        //把name和id分别取出来，组件数组
        NSMutableArray *muArray1 = [NSMutableArray array];
        NSMutableArray *muArray2 = [NSMutableArray array];
        
        for (int i = 0; i <= self.clienModel[0].itemList.count -1; i++) {
            
            LLAuditMangerItemModel *model = self.tallys[0];
            [muArray1 addObject:model.name];
            [muArray2 addObject:model.id];
        }
        self.labelsNameAry = [muArray1 mutableCopy];
        self.labelsIDAry = [muArray2 mutableCopy];
        
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
        self.clienModel = [LZClientModel LLMJParse:baseModel.data];
        
        NSMutableArray *muArray1 = [NSMutableArray array];
        NSMutableArray *muArray2 = [NSMutableArray array];
        LZAuditMangerItemModel *model = [[LZAuditMangerItemModel alloc]init];
        
        for (int i = 0; i < self.clienModel.count ; i++) {
            
            if (self.clienModel[i].itemList.count >0) {
                
                model = self.clienModel[i].itemList[0];
                
                [muArray1 addObject:model.name];
                [muArray2 addObject:model.id];
            }
  
        }
        self.principalNameAry = [muArray1 mutableCopy];
        self.principalIdAry = [muArray2 mutableCopy];

    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}


//tableview点击事件
-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WEAKSELF;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
//标签
        LZChooseLabelVC *vc = [[LZChooseLabelVC alloc]init];
        vc.ToSearchWhat = ToSearchLabel;
        CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration configurationWithDistance:0 maskAlpha:0.4 scaleY:1.0 direction:CWDrawerTransitionFromRight backImage:[UIImage imageNamed:@"back"]];
        [self.navigationController cw_showDrawerViewController:vc animationType:(CWDrawerAnimationTypeMask) configuration:conf];
        [vc setLabelsDetailBlock:^(NSString *labelString, NSString *labelId) {
            weakSelf.tallyCell.contentTF.text = labelString;
            weakSelf.labelslId = labelId;
        }];
        
    }else if (indexPath.section == 1 && indexPath.row == 1){

//状态
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该客户启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
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
     
//负责人
        if (self.principalNameAry.count < 1) {
            [LLHudTools showWithMessage:@"暂无负责人可选"];
            return;
        }
        LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.principalNameAry titleDataArray:nil];

        pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        weakSelf.principalCell.contentTF.text = compoentString;
            NSInteger row = [titileString integerValue];
            weakSelf.priceipalId = weakSelf.principalIdAry[row];
    
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
    
    if ([BXSTools stringIsNullOrEmpty:self.principalCell.contentTF.text]) {
        BXS_Alert(@"请选择负责人");
        return;
    }

    if ([BXSTools stringIsNullOrEmpty:self.tallyCell.contentTF.text]) {
        BXS_Alert(@"请输入标签");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
        BXS_Alert(@"请选择状态");
        return;
    }
    
    if ([BXSTools stringIsNullOrEmpty:self.arrearageCell.contentTF.text]) {
        BXS_Alert(@"请输入初始欠款");
        return;
    }
    NSInteger status = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        status = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        status = 1;
    }
    
    NSInteger exceedQuotas = -1;
    if ([self.exceedQuotaCell.contentTF.text isEqualToString:@"提醒"]) {
        exceedQuotas = 0;
    }else if ([self.exceedQuotaCell.contentTF.text isEqualToString:@"不能保存单据"]){
        exceedQuotas = 1;
    }
    
    NSDictionary *param = @{
                           @"companyId":[BXSUser currentUser].companyId,
                           @"name":self.titleCell.contentTF.text,
                           @"mobile":self.mobileCell.contentTF.text,
                           @"address":self.addressCell.contentTF.text,
                           @"labelId":self.labelslId,
                           @"status":@(status),
                           @"alias":self.aliasCell.contentTF.text,
                           @"memberId":self.priceipalId,
                           @"quota":self.quotaCell.contentTF.text,
                           @"excessOperation":@(exceedQuotas),
                           @"initialValue":self.arrearageCell.contentTF.text,
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  
    //当不是信用额度cell，直接不走下面方法
    if (textField != self.quotaCell.contentTF) {
        return YES;
    }
    
    //限制只能输入数字
    BOOL isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            if([textField.text length] == 0){
                if(single == '.') {
                    [LLHudTools showWithMessage:@"只能输入数字和小数点"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            //输入的字符是否是小数点
            if (single == '.') {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian = YES;
                    return YES;
                    
                }else{
                    
                   [LLHudTools showWithMessage:@"只能输入数字和小数点"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian) {//存在小数点
                    
                    //判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    }else{
                        [LLHudTools showWithMessage:@"只能输入数字和小数点"];
                        return NO;
                    }
                }else{
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
           [LLHudTools showWithMessage:@"只能输入数字和小数点"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
