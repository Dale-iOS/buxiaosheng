//
//  BaseSearchViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface BaseSearchViewController ()<LZSearchBarDelegate>

@end

@implementation BaseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSearchBar];
}

- (void)setupSearchBar
{
    self.searchBar = [[LZSearchBar alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 49)];
    self.searchBar.placeholder = @"输入搜索";
    self.searchBar.textColor = Text33;
    self.searchBar.delegate = self;
    self.searchBar.iconImage = IMAGE(@"search1");
    self.searchBar.iconAlign = LZSearchBarIconAlignCenter;
    [self.view addSubview:self.searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
