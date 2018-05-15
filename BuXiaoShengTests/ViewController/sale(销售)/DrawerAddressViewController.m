//
//  DrawerAddressViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//   选择地址抽屉 侧栏页面

#import "DrawerAddressViewController.h"


@interface DrawerAddressViewController ()

@property (nonatomic, strong) UIButton *nextBtn;


@end

@implementation DrawerAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect = self.view.frame;
    
    switch (_drawerType) {
        case DrawerDefaultLeft:
            [self.view.superview sendSubviewToBack:self.view];
            break;
        case DrawerTypeMaskLeft:
            rect.size.width = kCWSCREENWIDTH * 0.75;
            break;
        default:
            break;
    }
    
    self.view.frame = rect;
}

- (void)setupUI
{
    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, APPWidth, 30)];
    selectLabel.backgroundColor = LZHBackgroundColor;
    selectLabel.text = @"  选择地址";
    selectLabel.textColor = CD_Text99;
    selectLabel.font = FONT(12);
    selectLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:selectLabel];
    
    self.nextBtn = [UIButton new];
    self.nextBtn.frame = CGRectMake(0, APPHeight -44, APPWidth *3/4, 44);
    self.nextBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.nextBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.nextBtn];
    
 
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestGETWithAppURL:@"customer_label/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
      
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
