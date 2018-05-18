//
//  AllCompanyViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  全公司的（客户管理）

#import "AllCompanyViewController.h"

@interface AllCompanyViewController ()

@end

@implementation AllCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupData];
}

- (void)setupData
{
    NSDictionary *param = @{@"companyId":[BXSUser currentUser].companyId,
                            @"labelName":@"",
                            @"memberId":@"",
                            @"pageNo":@"1",
                            @"pageSize":@"20",
                            @"searchName":@"",
                            //                            @"status":@""
                            
                            };
    [BXSHttp requestGETWithAppURL:@"customer/list.do" param:param success:^(id response) {
        
        LLBaseModel *baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            
            [LLHudTools showWithMessage:baseModel.msg];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
