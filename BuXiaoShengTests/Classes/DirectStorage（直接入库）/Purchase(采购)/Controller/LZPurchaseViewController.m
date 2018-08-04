//
//  LZPurchaseViewController.m
//  BuXiaoSheng
//
//  Created by Dale on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseViewController.h"
#import "LZDirectStorageBottomView.h"

@interface LZPurchaseViewController ()

@property (weak, nonatomic) LZDirectStorageBottomView *bottomView;

@end

@implementation LZPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor redColor];
    [self setupBottomView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat height = 60;
    if (@available(iOS 11.0, *)) {
        height += self.view.safeAreaInsets.bottom;
    }
    _bottomView.frame = CGRectMake(0, self.view.height - height, SCREEN_WIDTH, height);
}

#pragma mark - Events
- (void)setupBottomView {
    LZDirectStorageBottomView *bottomView = [LZDirectStorageBottomView bottomView];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
}


@end
