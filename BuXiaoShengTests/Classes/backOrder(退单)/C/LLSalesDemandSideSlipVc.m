//
//  LLSalesDemandSideSlipVc.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/8.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLSalesDemandSideSlipVc.h"

@interface LLSalesDemandSideSlipVc ()

@end

@implementation LLSalesDemandSideSlipVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI {
    UISearchBar *searchBar = [UISearchBar new];
    [self.view addSubview:searchBar];
    searchBar.placeholder = @"搜索颜色";
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(22);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
