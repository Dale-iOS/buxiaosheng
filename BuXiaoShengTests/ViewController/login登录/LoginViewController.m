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

@interface LoginViewController ()

///登录输入框
@property (nonatomic, strong)UITextField *loginTF;
///密码输入框
@property (nonatomic, strong)UITextField *passwordTF;
@property (nonatomic, strong) LoginModel *loginModel;

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
    [self.navigationController setNavigationBarHidden:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(loginBack)];
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
    self.loginTF.leftView = loginLeftView;
    self.loginTF.leftViewMode = UITextFieldViewModeAlways;
    self.loginTF.layer.cornerRadius = 22;
    self.loginTF.placeholder = @"手机号或ID";
    [self.loginTF setValue:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f] forKeyPath:@"_placeholderLabel.textColor"];
    [self.loginTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.loginTF.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f].CGColor;
    self.loginTF.textColor = [UIColor whiteColor];
    self.loginTF.layer.borderWidth = 0.5;
    self.loginTF.keyboardType = UIKeyboardTypeNumberPad;
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
    rightBtn.frame = CGRectMake(0, 5, 30, 30);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(passwordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor clearColor];
    rightView.frame = CGRectMake(0, 0, 40, 40);
    rightView.userInteractionEnabled = YES;
    rightView.centerY = self.passwordTF.centerY;
    [rightView addSubview:rightBtn];
    self.passwordTF.rightView = rightView;
    self.passwordTF.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.passwordTF];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, 242, self.view.frame.size.width -60, 44);
    loginBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    loginBtn.layer.cornerRadius = 22;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginBtn setTitleColor:[UIColor colorWithRed:62.0f/255.0f green:178.0f/255.0f blue:247.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(AlterPassworldloginBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn addTarget:self action:@selector(loginBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    //最底下的版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height -15 -14, self.view.frame.size.width, 14)];
    versionLabel.text = [NSString stringWithFormat:@"V%@",appVersion];
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.font = [UIFont systemFontOfSize:13];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    
#pragma mark ------- 假数据 --------
//    self.loginTF.text = @"18814188198";
//    self.passwordTF.text = @"666666";

    
}

#pragma mark ------- 点击事件 --------
//登录事件
- (void)loginBtnOnClickAction
{
    NSLog(@"loginBtnOnClickAction");
    
//    [LLHudTools showWithMessage:@"登录成功"];
    
    

    NSDictionary *param = @{@"loginName":self.loginTF.text,
                           @"password":[BXSHttp makeMD5:self.passwordTF.text]
                           };
    [BXSHttp requestPOSTWithAppURL:@"login.do" param:param success:^(id response) {
        //[BXSUser deleteUser:<#(LoginModel *)#>]
        if ([[response objectForKey:@"code"] integerValue] == 200) {
             self.loginModel = [LoginModel mj_objectWithKeyValues:response[@"data"]];
            [BXSUser deleteUser];
            [BXSUser saveUser:self.loginModel];
            
            if ([self.loginModel.pwdResetStaus isEqualToString:@"0"]) {
                AlterPassworddViewController *vc = [[AlterPassworddViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
                return ;
            }
            
            HomeViewController *vc = [[HomeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        NSLog(@"++++++%@",self.loginModel.loginName);
        
        [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)AlterPassworldloginBtnOnClickAction
{
    AlterPassworddViewController *vc = [[AlterPassworddViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

//无论是UITextField还是UITextView弹出来的键盘，点击空白处都会取消。
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        
        [self.view endEditing:YES];
        
    }
    
}
-(void)loginBack {
    [self.navigationController popToRootViewControllerAnimated:true];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

