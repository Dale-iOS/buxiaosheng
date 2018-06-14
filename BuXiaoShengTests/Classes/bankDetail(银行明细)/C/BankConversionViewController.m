//
//  BankConversionViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/24.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  银行互转页面

#import "BankConversionViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "UITextView+Placeholder.h"
#import "TextInputTextView.h"
#import "BankConversionCell.h"
#import "LZPickerView.h"


@interface BankConversionViewController ()<LZHTableViewDelegate>

@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///转入金额
@property (nonatomic, strong) TextInputCell *intoPriceCell;
///银行转账
@property (nonatomic, strong) BankConversionCell *conversionCell;
///备注
@property (nonatomic, strong) TextInputTextView *remarkTextView;
@property(nonatomic,strong)UIView *ConversionView;//转化view
@property(nonatomic,strong)UILabel *leftLbl;//转出银行
@property(nonatomic,strong)UILabel *balanceLbl;//转出银行余额
@property(nonatomic,strong)UILabel *rightLbl;//转入银行
//付款方式数组
@property (nonatomic, strong) NSMutableArray *payNameAry;
@property (nonatomic, strong) NSMutableArray *payIdAry;
@property (nonatomic, copy) NSString *leftPayIdStr;//左边选择中的付款方式id
@property(nonatomic,strong)NSMutableArray *balanceAry;//选中的银行的原来的余额
@property (nonatomic, copy) NSString *rightPayIdStr;//右边选择中的付款方式id
@end

@implementation BankConversionViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationItem.titleView = [Utility navWhiteTitleView:@"银行互转"];
//
    [self.navigationController.navigationBar setBackgroundImage:[Utility createImageWithColor:[UIColor colorWithHexString:@"#3d9bfa"]] forBarMetrics:UIBarMetricsDefault];

    [self setCustomLeftButton];
    [self setupPayList];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //恢复到设置背景图之前的外观
    
    [super viewWillDisappear:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = nil;
    
    //恢复到之前的状态
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:nil
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:nil];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)];
        //        tableView.tableView.allowsSelection = YES;
        //        tableView.tableHeaderView = self.headView;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setupUI
{

    //    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
        self.view.backgroundColor = [UIColor whiteColor];
    
    self.datasource = [NSMutableArray array];
    
    [self.view addSubview:self.mainTabelView];
    self.mainTabelView.delegate = self;
    [self setSectionOne];
    [self setSectionTwo];
//    [self setSectionThree];
    self.mainTabelView.dataSoure = self.datasource;
    
}

- (void)setSectionOne
{
    self.intoPriceCell = [[TextInputCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 49)];
    self.intoPriceCell.titleLabel.text = @"转入金额";
    self.intoPriceCell.contentTF.placeholder = @"请输入金额";
    self.intoPriceCell.contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    
     self.conversionCell = [[BankConversionCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 75)];
    
    //转化view
    _ConversionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 75)];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = IMAGE(@"conversionbank");
    [_ConversionView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(19);
        make.height.mas_offset(14);
        make.center.equalTo(_ConversionView);
    }];
    
    
    //转出银行
    _leftLbl = [[UILabel alloc]init];
    _leftLbl.textColor = CD_textCC;
    _leftLbl.text = @"请选择转出银行";
    _leftLbl.font = FONT(14);
    _leftLbl.textAlignment = NSTextAlignmentCenter;
    _leftLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftClick)];
    [_leftLbl addGestureRecognizer:leftTap];
    [_ConversionView addSubview:_leftLbl];
    [_leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ConversionView).offset(20);
        make.left.equalTo(_ConversionView).offset(30);
        make.right.equalTo(imageView.mas_left).offset(-30);
        make.height.mas_offset(20);
    }];
    
    //转入银行
    _rightLbl = [[UILabel alloc]init];
    _rightLbl.textColor = CD_textCC;
    _rightLbl.text = @"请选择转入银行";
    _rightLbl.font = FONT(14);
    _rightLbl.textAlignment = NSTextAlignmentCenter;
    _rightLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightClick)];
    [_rightLbl addGestureRecognizer:rightTap];
    [_ConversionView addSubview:_rightLbl];
    [_rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ConversionView).offset(20);
        make.right.equalTo(_ConversionView).offset(-30);
        make.left.equalTo(imageView.mas_right).offset(30);
        make.height.mas_offset(20);
    }];
    
    //余额
    _balanceLbl = [[UILabel alloc]init];
    _balanceLbl.textColor = CD_Text99;
    _balanceLbl.font = FONT(12);
    _balanceLbl.text = @"￥:";
//    _balanceLbl.backgroundColor = [UIColor blueColor];
    _balanceLbl.textAlignment = NSTextAlignmentCenter;
    [_ConversionView addSubview:_balanceLbl];
    [_balanceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftLbl.mas_bottom).offset(10);
        make.height.mas_offset(13);
        make.left.equalTo(_ConversionView).offset(30);
        make.right.equalTo(imageView.mas_left).offset(-30);
    }];
    
    
    
    
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.intoPriceCell,_ConversionView];
    item.canSelected = NO;
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo
{
    //    备注textView
    self.remarkTextView = [[TextInputTextView alloc]init];
    self.remarkTextView.frame = CGRectMake(0, 0, APPWidth, 98);
    self.remarkTextView.titleLabel.text = @"备注";
    self.remarkTextView.textView.placeholder = @"请输入备注内容";
  
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headView.backgroundColor = LZHBackgroundColor;
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[self.remarkTextView];
    item.canSelected = NO;
    item.sectionView = headView;
    [self.datasource addObject:item];
}



- (void)setCustomLeftButton {
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:@"whiteback"] forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.tintColor = [UIColor whiteColor];
    leftButton.autoresizesSubviews = YES;
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [leftButton addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIView* rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.backgroundColor = [UIColor clearColor];
    rightButton.frame = rightButtonView.frame;
//    [rightButton setImage:[UIImage imageNamed:@"wihtesearch"] forState:UIControlStateNormal];
    [rightButton setTitle:@"确认" forState:UIControlStateNormal];
    //    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    rightButton.tintColor = [UIColor whiteColor];
    rightButton.autoresizesSubviews = YES;
    rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [rightButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:rightButton];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonView];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


#pragma mark --- 网络请求 ---
//接口名称 银行列表
- (void)setupPayList{
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"bank/pay_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSMutableArray *tempAry = baseModel.data;
        self.payNameAry = [NSMutableArray array];
        self.payIdAry = [NSMutableArray array];
        self.balanceAry = [NSMutableArray array];
        for (int i = 0; i <tempAry.count; i++) {
            [self.payIdAry addObject:tempAry[i][@"id"]];
            [self.payNameAry addObject:tempAry[i][@"name"]];
            [self.balanceAry addObject:tempAry[i][@"amount"]];
        }
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark --- 点击事件 ---
- (void)leftClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.payNameAry titleDataArray:nil];
    pickerView.titleLabel.text = @"请选择转出银行";
    WEAKSELF
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        weakSelf.leftLbl.textColor = CD_Text66;
        weakSelf.leftLbl.text = compoentString;
        NSInteger row = [titileString integerValue];
        weakSelf.leftPayIdStr = weakSelf.payIdAry[row];
        weakSelf.balanceLbl.textColor = CD_Text66;
        weakSelf.balanceLbl.text  = [NSString stringWithFormat:@"￥：%@",weakSelf.balanceAry[row]];
    };
    [self.view addSubview:pickerView];
}

- (void)rightClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:self.payNameAry titleDataArray:nil];
    pickerView.titleLabel.text = @"请选择到账银行";
    WEAKSELF
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        weakSelf.rightLbl.textColor = CD_Text66;
        weakSelf.rightLbl.text = compoentString;
        NSInteger row = [titileString integerValue];
        weakSelf.rightPayIdStr = self.payIdAry[row];
        
    };
    [self.view addSubview:pickerView];
}

- (void)saveClick{
    
    if ([BXSTools stringIsNullOrEmpty:self.intoPriceCell.contentTF.text]) {
        BXS_Alert(@"请输入金额");
        return;
    }
    if ([self.leftLbl.text isEqualToString:@"请选择转出银行"]) {
        BXS_Alert(@"请选择转出银行");
        return;
    }
    if ([self.rightLbl.text isEqualToString:@"请选择转入银行"]) {
        BXS_Alert(@"请选择转入银行");
        return;
    }
    if ([self.leftLbl.text isEqualToString:self.rightLbl.text]) {
        BXS_Alert(@"不能选择同一个银行");
        return;
    }
    //设置警告框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确认互转数据正确？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"取消执行");
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //确定的执行事件
        NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                                 @"amount":self.intoPriceCell.contentTF.text,
                                 @"intoBankId":self.rightPayIdStr,
                                 @"intoBankName":self.rightLbl.text,
                                 @"outBankId":self.leftPayIdStr,
                                 @"outBankName":self.leftLbl.text,
                                 @"remark":self.remarkTextView.textView.text
                                 };
        [BXSHttp requestGETWithAppURL:@"finance/bank_convert.do" param:param success:^(id response) {
            LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
            if ([baseModel.code integerValue] != 200) {
                [LLHudTools showWithMessage:baseModel.msg];
                return ;
            }
            [LLHudTools showWithMessage:@"提交成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });

        } failure:^(NSError *error) {
            BXS_Alert(LLLoadErrorMessage);
        }];

    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}


@end
