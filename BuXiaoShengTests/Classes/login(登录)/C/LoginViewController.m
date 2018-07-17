//
//  LoginViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  登录页面

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "LoginModel.h"
#import "AlterPassworddViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UIButton *_emptyBtn;
}
///登录输入框
@property (nonatomic, strong)UITextField *loginTF;
///密码输入框
@property (nonatomic, strong)UITextField *passwordTF;
@property (nonatomic, strong) LoginModel *loginModel;
@property(nonatomic,strong)UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroud];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:animated];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(loginBack)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTFChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordNewTFChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setBackgroud
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f].CGColor,(id)[UIColor colorWithRed:65.0f/255.0f green:236.0f/255.0f blue:239.0f/255.0f alpha:1.0f].CGColor, nil];
    layer.locations = @[@0.0f,@0.9f];
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
}

- (void)setupUI
{
    //顶部登录两个字
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15 +34, self.view.frame.size.width, 16)];
    titleLabel.text = @"登录";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    //登录 左边图标
    UIView *loginLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
    UIImageView *loginLeftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user"]];
    loginLeftImageView.frame = CGRectMake(15, 0, 18, 18);
    [loginLeftView addSubview:loginLeftImageView];
    
    //密码 左边图标
    UIView *passwordLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
    UIImageView *passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"password"]];
    passwordImageView.frame = CGRectMake(15, 0, 18, 18);
    [passwordLeftView addSubview:passwordImageView];
    
    //登录输入框
    self.loginTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 124, self.view.frame.size.width -60, 45)];
    NSString * saveUserID = [[NSUserDefaults standardUserDefaults] objectForKey:LLUserSaveKey];
    if (saveUserID) {
        self.loginTF.text = saveUserID;
    }
    self.loginTF.leftView = loginLeftView;
//    self.loginTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.loginTF.leftViewMode = UITextFieldViewModeAlways;
    self.loginTF.layer.cornerRadius = 22;
    self.loginTF.placeholder = @"手机号或ID";
    [self.loginTF setValue:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f] forKeyPath:@"_placeholderLabel.textColor"];
    [self.loginTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.loginTF.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f].CGColor;
    self.loginTF.textColor = [UIColor whiteColor];
    self.loginTF.layer.borderWidth = 0.5;
    self.loginTF.keyboardType = UIKeyboardTypeNumberPad;
    self.loginTF.delegate = self;
    //清空账号按钮
    _emptyBtn = [[UIButton alloc]init];
    //密码形式
    [_emptyBtn setBackgroundImage:IMAGE(@"del_passworld") forState:UIControlStateNormal];
    _emptyBtn.frame = CGRectMake(0, 5, 20, 20);
    _emptyBtn.backgroundColor = [UIColor clearColor];
    _emptyBtn.hidden = YES;
    [_emptyBtn addTarget:self action:@selector(emptyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *emptyView = [[UIView alloc]init];
    emptyView.backgroundColor = [UIColor clearColor];
    emptyView.frame = CGRectMake(0, 0, 40, 40);
    emptyView.userInteractionEnabled = YES;
    emptyView.centerY = self.passwordTF.centerY;
    [emptyView addSubview:_emptyBtn];
    [_emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(emptyView);
        make.width.and.height.mas_offset(20);
    }];
    self.loginTF.rightView = emptyView;
    self.loginTF.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.loginTF];


    //密码输入框
    self.passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 183, self.view.frame.size.width -60, 44)];
    self.passwordTF.layer.cornerRadius = 22;
    self.passwordTF.leftView = passwordLeftView;
    self.passwordTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTF.placeholder = @"请输入密码";
    [self.passwordTF setValue:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.passwordTF.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f].CGColor;
    self.passwordTF.textColor = [UIColor whiteColor];
    self.passwordTF.layer.borderWidth = 0.5;
    self.passwordTF.keyboardType = UIKeyboardTypeURL;
    //密码明文或者暗文按钮
    UIButton *rightBtn = [[UIButton alloc]init];
    //密码形式
    self.passwordTF.secureTextEntry = YES;
    [rightBtn setBackgroundImage:IMAGE(@"password1") forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 5, 28, 30);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(passwordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.frame = CGRectMake(0, 0, 40, 40);
    rightView.userInteractionEnabled = YES;
    rightView.centerY = self.passwordTF.centerY;
    [rightView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(rightView);
        make.height.mas_offset(28);
        make.width.mas_offset(23);
    }];
    self.passwordTF.rightView = rightView;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passwordTF];

    //登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(30, 242, self.view.frame.size.width -60, 44);
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    _loginBtn.layer.cornerRadius = 22;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_loginBtn];
    
    //最底下的版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height -15 -14, self.view.frame.size.width, 14)];
    versionLabel.text = [NSString stringWithFormat:@"V%@",appVersion];
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.font = [UIFont systemFontOfSize:13];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];

}

#pragma mark ------- 点击事件 --------
//登录事件
- (void)loginBtnOnClickAction
{
    if ([BXSTools stringIsNullOrEmpty:self.loginTF.text]) {
        BXS_Alert(@"请输入登录账号");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.passwordTF.text]) {
        BXS_Alert(@"密码必须大于或等于6位数");
        return;
    }
    NSString * JPushId = [[NSUserDefaults standardUserDefaults] objectForKey:LLJPushRegistrationID] ? : @"";
    NSDictionary *param = @{@"loginName":self.loginTF.text,
                           @"password":[BXSHttp makeMD5:self.passwordTF.text],
                            @"registrationId" : JPushId
                           };
    [BXSHttp requestPOSTWithAppURL:@"login.do" param:param success:^(id response) {
        if ([[response objectForKey:@"code"] integerValue] == 200) {
             self.loginModel = [LoginModel mj_objectWithKeyValues:response[@"data"]];
            
            if ([self.loginModel.pwdResetStaus isEqualToString:@"0"]) {
                AlterPassworddViewController *vc = [[AlterPassworddViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                return ;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:self.loginTF.text forKey:LLUserSaveKey];
            [[NSUserDefaults standardUserDefaults]setObject:[BXSHttp makeMD5:self.passwordTF.text] forKey:LLUserPassWordSaveKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [BXSUser deleteUser];
            [BXSUser saveUser:self.loginModel];
            HomeViewController *vc = [[HomeViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
        }

        [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

- (void)AlterPassworldloginBtnOnClickAction
{
    AlterPassworddViewController *vc = [[AlterPassworddViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)loginBack {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)emptyBtnClick:(UIButton *)btn{
    self.loginTF.text = nil;
    [_emptyBtn setHidden:YES];
}

- (void)passwordBtnClick:(UIButton *)btn
{
//    [self.passwordTF resignFirstResponder];
    btn.selected = !btn.selected;
    if (!btn.selected) {
        [btn setBackgroundImage:IMAGE(@"password1") forState:UIControlStateNormal];
        self.passwordTF.secureTextEntry = YES;
    }else{
        [btn setBackgroundImage:IMAGE(@"password2") forState:UIControlStateNormal];
        self.passwordTF.secureTextEntry = NO;
    }
//    [self.passwordTF becomeFirstResponder];
}


#pragma mark --------- 监听事件 -----------
- (void)loginTFChanged:(NSNotification *)notify
{
    //监听登录账号是否有输入 ->loginTF的右侧删除按钮的显示
    if (self.loginTF.text.length >0) {
        [_emptyBtn setHidden:NO];
    }else if (self.loginTF.text.length ==0){
        [_emptyBtn setHidden:YES];
    }
}

- (void)passwordNewTFChanged:(NSNotification *)notify
{
    //监听输入框是否都有内容，确认按钮样式变化
    if (self.loginTF.text.length >0 && self.passwordTF.text.length >=6) {

        _loginBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];

        [_loginBtn setTitleColor:[UIColor colorWithRed:62.0f/255.0f green:178.0f/255.0f blue:247.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        
    }else
    {
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }
}

//#pragma mark ---- uitextfielddelegate ----
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if ([textField isEqual:self.loginTF]) {
//        self.loginTF.rightView.hidden = NO;
//        return YES;
//    }
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

