//
//  BXSUser.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
@interface BXSUser : NSObject

/// 存储用户
+(void)saveUser:(LoginModel *)user;

/// 删除用户
+ (void)deleteUser:(LoginModel *)user;

/// 获取当前用户
+ (LoginModel *)currentUser;



/// 用户信息配置完成
+(void)postUserDataConfigureCompleteNotification;

/// 是否登录
+ (BOOL)isLogin;

@end
