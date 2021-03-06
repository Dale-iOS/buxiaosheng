//
//  LLHudTools.m
//  JLCWorkForApple
//
//  Created by 周尊贤 on 2018/3/1.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLHudTools.h"
#import <objc/runtime.h>
@implementation LLHudTools



+(void)showWithMessage:(NSString *)message {
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setForegroundColor:CD_Text33];
//    [SVProgressHUD setBackgroundColor: [[UIColor lightGrayColor]colorWithAlphaComponent:0.95]];
    [SVProgressHUD setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.5]];
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD dismissWithDelay:1.5];
}

+(void)showLoadingMessage:(NSString *)message {
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeCustom)];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    [SVProgressHUD showWithStatus:LLLoadingMessage];
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD setForegroundColor:CD_Text33];
    [SVProgressHUD setFont:[UIFont boldSystemFontOfSize:16]];
    [SVProgressHUD setBackgroundColor: [UIColor colorWithWhite:1.0 alpha:0.5]];
}


+(void)dismiss{
    [SVProgressHUD dismiss];
}
@end
