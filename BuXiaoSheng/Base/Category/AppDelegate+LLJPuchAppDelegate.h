//
//  AppDelegate+LLJPuchAppDelegate.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/7/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AppDelegate.h"
#import <JPush/JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate (LLJPuchAppDelegate)<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>
-(void)setupJPuchWith:(UIApplication*)application Options:(NSDictionary *)launchOptions;
@end
