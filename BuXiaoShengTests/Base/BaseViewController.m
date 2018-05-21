//
//  BaseViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/26.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = LZHBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////无论是UITextField还是UITextView弹出来的键盘，点击空白处都会取消。
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [touches anyObject];
//    
//    if (![touch.view isKindOfClass: [UITextField class]] || ![touch.view isKindOfClass: [UITextView class]]) {
//        
//        [self.view endEditing:YES];
//        
//    }
//    
//}


- (void)backMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
