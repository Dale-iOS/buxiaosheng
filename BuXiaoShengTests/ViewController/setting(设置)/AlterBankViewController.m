//
//  AlterBankViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改银行页面

#import "AlterBankViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "DefaultBankCell.h"

@interface AlterBankViewController ()<LZHTableViewDelegate>

@property (nonatomic,assign)BOOL isdefault;
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;

/////账户类型
//@property (nonatomic, strong) TextInputCell *typeCell;
///账号
@property (nonatomic, strong) TextInputCell *accountCell;
///现金银行名称
@property (nonatomic, strong) TextInputCell *bankTitleCell;
///所属分店
@property (nonatomic, strong) TextInputCell *belongStoreCell;
///状态
@property (nonatomic, strong) TextInputCell *stateCell;
///设为默认
@property (nonatomic, strong) DefaultBankCell *defaultCell;

@end

@implementation AlterBankViewController
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
    self.navigationItem.titleView = self.isFormBankAdd ?[Utility navTitleView:@"添加银行"] : [Utility navTitleView:@"修改银行"];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_equalTo(40);
         make.height.mas_equalTo(30);
    }];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setupSectionOne];
    //    [self setSectionTwo];
    self.mainTabelView.dataSoure = self.datasource;
}

- (void)setupSectionOne
{
//    self.typeCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
//    self.typeCell.rightArrowImageVIew.hidden = NO;
//    self.typeCell.titleLabel.text = @"账户类型";
//    self.typeCell.contentTF.placeholder = @"请选择账户类型";
    
    self.accountCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    //    self.accountCell.rightArrowImageVIew.hidden = NO;
    self.accountCell.titleLabel.text = @"账号";
    self.accountCell.contentTF.placeholder = @"请填写银行卡号";
    
    self.bankTitleCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    //    self.bankTitleCell.rightArrowImageVIew.hidden = NO;
    self.bankTitleCell.titleLabel.text = @"现金银行名称";
    self.bankTitleCell.contentTF.placeholder = @"请填写银行名称";
    
    self.belongStoreCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.belongStoreCell.rightArrowImageVIew.hidden = NO;
    self.belongStoreCell.titleLabel.text = @"所属分店";
    self.belongStoreCell.contentTF.placeholder = @"请选择所属分店";
    
    self.stateCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.stateCell.rightArrowImageVIew.hidden = NO;
    self.stateCell.contentTF.enabled = false;
    self.stateCell.titleLabel.text = @"状态";
    self.stateCell.contentTF.placeholder = @"请选择银行卡状态";
    
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.accountCell,self.bankTitleCell,self.stateCell];
    item.canSelected = true;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionTwo
{
    self.defaultCell = [[DefaultBankCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.defaultCell.selectImageView.image = IMAGE(@"noSelect");
    _isdefault = NO;
    UITapGestureRecognizer *defaultCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(defaultCellAction)];
    [self.defaultCell addGestureRecognizer:defaultCellTap];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.defaultCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

-(void)LzhTableView:(LZHTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 ||indexPath.row == 1) {
        return;
    }
    WEAKSELF;
    UIAlertController * alterVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请选用该卡启动状态" preferredStyle:UIAlertControllerStyleActionSheet];
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

- (void)saveBtnClick
{
    if ([BXSTools stringIsNullOrEmpty:self.accountCell.contentTF.text]) {
         BXS_Alert(@"请输入您的银行卡号");
        return;
       
    }
    if (![BXSTools isBankCard:self.accountCell.contentTF.text]) {
         BXS_Alert(@"请输入正确的银行卡号");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.bankTitleCell.contentTF.text]) {
         BXS_Alert(@"请输入银行名称");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.stateCell.contentTF.text]) {
         BXS_Alert(@"请选择银行卡状态");
        return;
    }
    NSInteger status = -1;
    if ([self.stateCell.contentTF.text isEqualToString:@"启用"]) {
        status = 0;
    }else if ([self.stateCell.contentTF.text isEqualToString:@"未启用"]){
        status = 1;
    }
    NSString * requestUrl ;
    if (self.isFormBankAdd) {
        requestUrl = @"bank/add.do";
    }else {
        requestUrl = @"bank/update.do";
    }
    NSDictionary * param = @{
                             @"cardNumber":self.accountCell.contentTF.text,
                             @"companyId":[BXSUser currentUser].companyId,
                             @"name":self.bankTitleCell.contentTF.text,
                             @"status":@(status)
                             };
    [BXSHttp requestPOSTWithAppURL:requestUrl param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
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

- (void)defaultCellAction
{
    NSLog(@"defaultCellAction");
    
    _isdefault = !_isdefault;
    
    if (!_isdefault) {
        self.defaultCell.selectImageView.image = IMAGE(@"noSelect");
    }else
    {
        self.defaultCell.selectImageView.image = IMAGE(@"yesSelect");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
