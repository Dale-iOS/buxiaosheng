//
//  LoginViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  登录页面

#import "LoginViewController.h"
#import "HomeViewController.h"
//#import "SaleViewController.h"

@interface LoginViewController ()

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
    UITextField *loginTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 124, self.view.frame.size.width -60, 45)];
    loginTF.leftView = loginLeftView;
    loginTF.leftViewMode = UITextFieldViewModeAlways;
    loginTF.layer.cornerRadius = 22;
    loginTF.placeholder = @"手机号或ID";
    [loginTF setValue:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f] forKeyPath:@"_placeholderLabel.textColor"];
    [loginTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    loginTF.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f].CGColor;
    loginTF.textColor = [UIColor whiteColor];
    loginTF.layer.borderWidth = 0.5;
    [self.view addSubview:loginTF];
    
    //密码输入框
    UITextField *passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 183, self.view.frame.size.width -60, 44)];
    passwordTF.layer.cornerRadius = 22;
    passwordTF.leftView = passwordLeftView;
    passwordTF.leftViewMode = UITextFieldViewModeAlways;
    passwordTF.placeholder = @"请输入密码";
    [passwordTF setValue:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    passwordTF.layer.borderColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.3f].CGColor;
    passwordTF.textColor = [UIColor whiteColor];
    passwordTF.layer.borderWidth = 0.5;
    [self.view addSubview:passwordTF];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(30, 242, self.view.frame.size.width -60, 44);
    loginBtn.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    loginBtn.layer.cornerRadius = 22;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginBtn setTitleColor:[UIColor colorWithRed:62.0f/255.0f green:178.0f/255.0f blue:247.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
    
    //最底下的版本号
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height -15 -14, self.view.frame.size.width, 14)];
    versionLabel.text = @"V1.0";
    versionLabel.textColor = [UIColor whiteColor];
    versionLabel.font = [UIFont systemFontOfSize:13];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
}

#pragma mark ------- 点击事件 --------
- (void)loginBtnOnClickAction
{
    NSLog(@"loginBtnOnClickAction");
    HomeViewController *vc = [[HomeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
    
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    NSString *ts = [NSString stringWithFormat:@"%ld",(long)timeSp];//时间戳的值
    NSLog(@"时间戳：%@",ts);
    
}

//无论是UITextField还是UITextView弹出来的键盘，点击空白处都会取消。
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
        
        [self.view endEditing:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

