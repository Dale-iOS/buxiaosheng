//
//  AlterPassworddViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  修改密码页面

#import "AlterPassworddViewController.h"
#import "HomeViewController.h"
@interface AlterPassworddViewController ()<UITextFieldDelegate>

///红色提醒底图
@property (nonatomic, strong)UIView *remindView;
///新密码输入框
@property (nonatomic, strong)UITextField *passwordNewTF;
///再次确认密码输入框
@property (nonatomic, strong)UITextField *passwordAgainTF;
///确认按钮
@property (nonatomic, strong)UIButton *affirmBtn;
///两个输入框是否一样
@property (nonatomic, assign)BOOL isPasswordSame;
@end

@implementation AlterPassworddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    self.isPasswordSame = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordNewTFChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)setupUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRemidView];
   
}

//设置红色底图
- (void)setRemidView
{
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, APPWidth, LLNavViewHeight -8)];
    titleLbl.text = @"修改登录密码";
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:17];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];
    
    //红色底图
    self.remindView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 54)];
    self.remindView.backgroundColor = [UIColor colorWithHexString:@"#fc6666"];
    [self.view addSubview:self.remindView];
    
    UILabel *remindLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 4, APPWidth, 27)];
    remindLbl1.text = @"您的登录密码为默认";
    remindLbl1.textColor = [UIColor whiteColor];
    remindLbl1.font = FONT(12);
    remindLbl1.textAlignment = NSTextAlignmentCenter;
    [self.remindView addSubview:remindLbl1];
    
    UILabel *remindLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 27, APPWidth, 24)];
    remindLbl2.text = @"为了您的账号安全请设置一个新的登录密码";
    remindLbl2.textColor = [UIColor whiteColor];
    remindLbl2.font = FONT(12);
    remindLbl2.textAlignment = NSTextAlignmentCenter;
    [self.remindView addSubview:remindLbl2];
    
    
    
    //登录 左边图标
    UIView *loginLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
    UIImageView *loginLeftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newPassword"]];
    loginLeftImageView.frame = CGRectMake(15, 0, 18, 18);
    [loginLeftView addSubview:loginLeftImageView];
    
    //密码 左边图标
    UIView *passwordLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
    UIImageView *passwordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newPassword"]];
    passwordImageView.frame = CGRectMake(15, 0, 18, 18);
    [passwordLeftView addSubview:passwordImageView];

    //新密码输入框
    self.passwordNewTF = [[UITextField alloc]initWithFrame:CGRectMake(30, self.remindView.bottom +15, self.view.frame.size.width -60, 45)];
    self.passwordNewTF.delegate = self;
    self.passwordNewTF.leftView = loginLeftView;
    self.passwordNewTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordNewTF.layer.cornerRadius = 22;
    self.passwordNewTF.placeholder = @"设置6~16位新密码";
    [self.passwordNewTF setValue:[UIColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordNewTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.passwordNewTF.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    self.passwordNewTF.textColor = Text33;
    self.passwordNewTF.layer.borderWidth = 0.5;
    [self.view addSubview:self.passwordNewTF];
    
    //密码输入框
    self.passwordAgainTF = [[UITextField alloc]initWithFrame:CGRectMake(30, self.passwordNewTF.bottom +15, self.view.frame.size.width -60, 44)];
    self.passwordAgainTF.delegate = self;
    self.passwordAgainTF.layer.cornerRadius = 22;
    self.passwordAgainTF.leftView = passwordLeftView;
    self.passwordAgainTF.leftViewMode = UITextFieldViewModeAlways;
    self.passwordAgainTF.placeholder = @"再次输入登录密码";
    //密码形式
    self.passwordAgainTF.secureTextEntry = YES;
    [self.passwordAgainTF setValue:[UIColor colorWithHexString:@"#cccccc"] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordAgainTF setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    self.passwordAgainTF.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    self.passwordAgainTF.textColor = Text33;
    self.passwordAgainTF.layer.borderWidth = 0.5;
    [self.view addSubview:self.passwordAgainTF];
    
    //确认按钮
    self.affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.affirmBtn.frame = CGRectMake(30, self.passwordAgainTF.bottom +30, self.view.frame.size.width -60, 44);
    self.affirmBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    self.affirmBtn.layer.cornerRadius = 22;
    [self.affirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    self.affirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.affirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.affirmBtn addTarget:self action:@selector(affirmBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.affirmBtn];
}

//点击事件
- (void)affirmBtnOnClickAction
{
    
    if (self.isPasswordSame) {
        
       
        NSDictionary * param = @{@"token":[BXSUser currentUser].token,
                                 @"userId":[BXSUser currentUser].userId,
                                 @"newPassword":[BXSHttp makeMD5:self.passwordAgainTF.text]
                                 };
        [LLHudTools showLoadingMessage:LLLoadingMessage];
        [BXSHttp requestPOSTWithAppURL:@"member/reset_password.do" param:param success:^(id response) {
            [LLHudTools showWithMessage:[response objectForKey:@"msg"]];
            
            if ([[response objectForKey:@"code"] integerValue] == 200) {
                HomeViewController *vc = [[HomeViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                
            }
            
        } failure:^(NSError *error) {
              [LLHudTools showWithMessage:@"修改密码失败,请重试"];
        }];
    }
}

#pragma mark --------- 监听事件 -----------
- (void)passwordNewTFChanged:(NSBlockOperation *)notify
{
    //监听输入框是否都有内容，确认按钮样式变化
    if (self.passwordAgainTF.text.length >0 && self.passwordNewTF.text.length >0) {
        
        self.affirmBtn.backgroundColor = [UIColor colorWithHexString:@"#3d9bfa"];
        self.affirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.affirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else
    {
        self.affirmBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        self.affirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.affirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    //两次密码是否一样
    if ([self.passwordNewTF.text isEqual:self.passwordAgainTF.text]) {
        
        self.isPasswordSame = YES;
    }else
    {
        self.isPasswordSame = NO;
    }
}


#pragma mark -------- UITextFieldDelegate ---------
//当数值大于16 停止输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

        NSMutableString *text = [textField.text mutableCopy];
        [text replaceCharactersInRange:range withString:string];
    
    //限制只能填英文字母和数字
    NSUInteger lengthOfString = string.length;  //lengthOfString的值始终为1
    
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
        
        unichar character = [string characterAtIndex:loopIndex]; //将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
        
        // 48-57;{0,9};65-90;{A..Z};97-122:{a..z}
        
        if (character < 48) return NO; // 48 unichar for 0
        
        if (character > 57 && character < 65) return NO; //
        
        if (character > 90 && character < 97) return NO;
        
        if (character > 122) return NO;
        
        
        
    }
    
    // Check for total length
//    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
//    
//    if (proposedNewLength > 6) {
//        
//        return NO;//限制长度
//        
//    }
    
        if (text.length > 16 && range.length == 0)
        {
            return NO;
        }

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
