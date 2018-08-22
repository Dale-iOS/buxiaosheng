//
//  AddSetCompanyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  添加厂商页面

#import "AddSetCompanyViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "DefaultBankCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "LZCompanyModel.h"

@interface AddSetCompanyViewController ()<LZHTableViewDelegate>


@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

///名称
@property (nonatomic, strong) TextInputCell *titleCell;
/////分钟
//@property (nonatomic, strong) TextInputCell *groupCell;
///类型
@property (nonatomic, strong) TextInputCell *typeCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///别名
@property (nonatomic, strong) TextInputCell *nicknameCell;
///初始欠款
@property (nonatomic, strong) TextInputCell *arrearageCell;
///联系人
@property (nonatomic, strong) TextInputCell *contactCell;

///座机
@property (nonatomic, strong) TextInputCell *phoneCell;

///手机号码
@property (nonatomic, strong) TextInputCell *phoneNumberCell;
///地址
@property (nonatomic, strong) TextInputTextView *addressTextView;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
@end

@implementation AddSetCompanyViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupCompanyDetailData];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        tableView.delegate = self;
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}


- (void)setupUI
{

    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(saveBtnClick) title:@"确认"];
    
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(30);
    }];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    [self setupSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
}

-(void)setupCompanyDetailData {
    //从添加厂商过来的直接 return
    if (self.isFormCompanyAdd) {
        return;
    }
    NSDictionary * param = @{@"id":self.id};
    [BXSHttp requestGETWithAppURL:@"factory/detail.do" param:param success:^(id response) {
        NSLog(@"%@",response);
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            return ;
        }
        LZCompanyModel * model = [LZCompanyModel LLMJParse:baseModel.data];
        
//        self.accountCell.contentTF.text = [BXSTools stringIsNullOrEmpty:model.cardNumber] ? @"暂无" :model.cardNumber;
//        self.bankTitleCell.contentTF.text = model.name;
        
        self.titleCell.contentTF.text = model.name;
        
        if ([model.type integerValue] == 0) {
            self.typeCell.contentTF.text = @"供货商";
        }else if ([model.type integerValue] == 1)
        {
            self.typeCell.contentTF.text = @"生产商";
        }else if ([model.type integerValue] == 2)
        {
            self.typeCell.contentTF.text = @"加工商";
        }
        self.stateCell.contentTF.text = [model.status integerValue] == 0 ? @"启用" :@"未启用";
        self.nicknameCell.contentTF.text = model.alias;
        self.contactCell.contentTF.text = model.contactName;
        self.phoneCell.contentTF.text = model.tel;
        self.phoneNumberCell.contentTF.text = model.mobile;
        self.addressTextView.textView.text = model.address;
        self.remarkTextView.textView.text = model.remark;
        self.arrearageCell.contentTF.text = model.initialValue;
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage)
    }];
}

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return;
    }
    
    if (indexPath.row == 1) {
        WEAKSELF;
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择您要添加的厂商类型" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * offer = [UIAlertAction actionWithTitle:@"供货商" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.typeCell.contentTF.text = @"供货商";
        }];
        UIAlertAction * production = [UIAlertAction actionWithTitle:@"生产商" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.typeCell.contentTF.text = @"生产商";
        }];
        UIAlertAction * process = [UIAlertAction actionWithTitle:@"加工商" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.typeCell.contentTF.text = @"加工商";
        }];
        UIAlertAction * cacanle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alterVc addAction:offer];
        [alterVc addAction:production];
        [alterVc addAction:process];
        [alterVc addAction:cacanle];
        [self.navigationController presentViewController:alterVc animated:true completion:nil];
    }else if (indexPath.row == 2)
    {
        WEAKSELF;

        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择该供货启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
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
    }

}

- (void)setupSectionOne
{
    self.titleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.titleCell.titleLabel.text = @"名称";
    self.titleCell.contentTF.placeholder = @"请输入名称";
//
//    self.groupCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
//    self.groupCell.rightArrowImageVIew.hidden = NO;
//    self.groupCell.titleLabel.text = @"分组";
//    self.groupCell.contentTF.placeholder = @"请选择分组";
    
    self.typeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.typeCell.rightArrowImageVIew.hidden = NO;
    self.typeCell.titleLabel.text = @"类型";
    self.typeCell.contentTF.enabled = NO;
    self.typeCell.contentTF.placeholder = @"请选择类型";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.enabled = NO;
    self.stateCell.contentTF.placeholder = @"请选择状态";
    
    self.nicknameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.nicknameCell.titleLabel.text = @"别名";
    self.nicknameCell.contentTF.placeholder = @"请输入别名";
    
    self.arrearageCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.arrearageCell.titleLabel.text = @"初始欠款";
    self.arrearageCell.contentTF.placeholder = @"请输入初始欠款";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.typeCell,self.stateCell,self.nicknameCell,self.arrearageCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupSectionTwo
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    //    联系人
    self.contactCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.contactCell.titleLabel.text = @"联系人";
    self.contactCell.contentTF.placeholder = @"请输入联系人姓名";

    
    //   座机号
    self.phoneCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.phoneCell.titleLabel.text = @"电话";
    self.phoneCell.contentTF.placeholder = @"请输入座机号码";
    
    //   手机号码
    self.phoneNumberCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.phoneNumberCell.titleLabel.text = @"手机号码";
    self.phoneNumberCell.contentTF.placeholder = @"请输入手机号码";
    
    //   地址
    self.addressTextView = [[TextInputTextView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 70)];
    self.addressTextView.titleLabel.text = @"地址";
    self.addressTextView.textView.placeholder = @"请输入地址(非必填)";
    
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[ self.contactCell, self.phoneCell,self.phoneNumberCell , self.addressTextView,self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}

- (void)saveBtnClick
{
    if ([BXSTools stringIsNullOrEmpty:self.titleCell.contentTF.text]) {
        BXS_Alert(@"请输入名称");
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
    if ([BXSTools stringIsNullOrEmpty:self.contactCell.contentTF.text]) {
        BXS_Alert(@"请输入联系人姓名");
        return;
    }

    NSInteger stauts;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        stauts = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        stauts = 1;
    }

    
    NSInteger types = -1;
    if ([self.typeCell.contentTF.text isEqualToString:@"供货商"]) {
        types = 0;
    }else if ([self.typeCell.contentTF.text isEqualToString:@"生产商"]){
        types = 1;
    }else if ([self.typeCell.contentTF.text isEqualToString:@"加工商"]){
        types = 2;
    }
    
    NSDictionary * param = nil;
    NSString * AppURL = @"";
    
    if (_isFormCompanyAdd) {
        param = @{
                  @"address":self.addressTextView.textView.text?:@"",
                  @"alias":self.nicknameCell.contentTF.text ? :@"",
                  @"companyId":[BXSUser currentUser].companyId,
                  @"contactName":self.contactCell.contentTF.text ? :@"",
                  @"mobile" : self.phoneNumberCell.contentTF.text ? :@"",
                  @"name" : self.titleCell.contentTF.text ? :@"",
                  @"remark" : self.remarkTextView.textView.text ? : @"",
                  @"status" : @(stauts),
                  @"tel" : self.phoneCell.contentTF.text ? :@"",
                  @"type" : @(types),
                  @"initialValue":self.arrearageCell.contentTF.text ?:@"",
                  };
        AppURL = @"factory/add.do";
    }else
    {
        param = @{
                  @"address":self.addressTextView.textView.text?:@"",
                  @"alias":self.nicknameCell.contentTF.text ? :@"",
                  @"companyId":[BXSUser currentUser].companyId,
                  @"contactName":self.contactCell.contentTF.text ? :@"",
                  @"id":self.id,
                  @"mobile" : self.phoneNumberCell.contentTF.text ? :@"",
                  @"name" : self.titleCell.contentTF.text ? :@"",
                  @"remark" : self.remarkTextView.textView.text ? : @"",
                  @"status" : @(stauts),
                  @"tel" : self.phoneCell.contentTF.text ? :@"",
                  @"type" : @(types),
                  @"initialValue":self.arrearageCell.contentTF.text ?:@"",
                  };
        AppURL = @"factory/update.do";
    }
    
    [BXSHttp requestPOSTWithAppURL:AppURL param:param success:^(id response) {
        
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
        
    } failure:^(NSError *error) {
      BXS_Alert(LLLoadErrorMessage)
    }];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
