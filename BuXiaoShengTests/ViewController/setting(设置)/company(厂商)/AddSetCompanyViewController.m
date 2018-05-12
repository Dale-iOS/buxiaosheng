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
////  分组
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
    [navRightBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
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

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return;
    }
    
    if (indexPath.row == 1) {
        WEAKSELF;
        UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选择您要添加的厂商类型" preferredStyle:UIAlertControllerStyleActionSheet];
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
    self.typeCell.contentTF.placeholder = @"请选择类型";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择状态";
    
    self.nicknameCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.nicknameCell.rightArrowImageVIew.hidden = NO;
    self.nicknameCell.titleLabel.text = @"别名";
    self.nicknameCell.contentTF.placeholder = @"请输入别名";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.titleCell,self.typeCell,self.stateCell,self.nicknameCell];
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
    self.addressTextView.textView.placeholder = @"请输入地址";
    
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
    if ([BXSTools stringIsNullOrEmpty:self.typeCell.contentTF.text]) {
        BXS_Alert(@"请选择地址");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
        BXS_Alert(@"请选择状态");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.contactCell.contentTF.text]) {
        BXS_Alert(@"请输入联系人姓名");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.phoneCell.contentTF.text]) {
        BXS_Alert(@"请输入座机号码");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.phoneNumberCell.contentTF.text]) {
        BXS_Alert(@"请输入手机号码");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.addressTextView.textView.text]) {
        BXS_Alert(@"请输入地址");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.addressTextView.textView.text]) {
        BXS_Alert(@"请输入联系地址");
        return;
    }
    NSInteger stauts;
    switch (self.type) {
        case 0:
            stauts = 0;
            break;
        case 1:
            stauts = 1;
            break;
        case 2:
            stauts = 2;
            break;
        default:
            break;
    }
    
    NSDictionary * param = @{
                             @"address":self.addressTextView.textView.text?:@"",
                             @"alias":self.nicknameCell.contentTF.text ? :@"",
                             @"companyId":self.addressTextView.textView.text ? :@"",
                             @"contactName":self.contactCell.contentTF.text ? :@"",
                             @"mobile" : self.phoneNumberCell.contentTF.text ? :@"",
                             @"name" : self.titleCell.contentTF.text ? :@"",
                             @"remark" : self.remarkTextView.textView.text ? : @"",
                             @"staus":self.stateCell.contentTF.text ? :@"",
                             @"tel" : self.phoneCell.contentTF.text ? :@"",
                             @"type" :@(stauts)
                             };
    [BXSHttp requestPOSTWithAppURL:@"factory/add.do" param:param success:^(id response) {
        
    } failure:^(NSError *error) {
      BXS_Alert(LLLoadErrorMessage)
    }];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
