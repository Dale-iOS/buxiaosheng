//
//  AppDelegate+LLJPuchAppDelegate.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/7/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AppDelegate.h"
#import <JPush/JPUSHService.h>
@interface AppDelegate (LLJPuchAppDelegate)<JPUSHRegisterDelegate>
-(void)setupJPuchWith:(UIApplication*)application Options:(NSDictionary *)launchOptions;
@end
