//
//  BXSUser.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSUser.h"
#import "WZLSerializeKit.h"
#import "MHConstInline.h"

#define BXSCacheUserKey @"BXSCacheUserKey"
@implementation BXSUser

/// 存储用户
+(void)saveUser:(LoginModel *)user{
    if (user) {
         WZLSERIALIZE_ARCHIVE(user, BXSCacheUserKey, MHWeChatDocDirPath());
    }
}

/// 删除用户
+ (void)deleteUser;{
    // 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isExist = [manager fileExistsAtPath:MHWeChatDocDirPath()];
    if (isExist) {
        NSError * error;
        [[NSFileManager defaultManager] removeItemAtPath:MHWeChatDocDirPath() error:&error];
        if (error) {
            NSLog(@"删除用户信息失败");
        }
    }
   
}

/// 获取当前用户
+ (LoginModel *)currentUser{
    LoginModel *user = nil;
    WZLSERIALIZE_UNARCHIVE(user, BXSCacheUserKey, MHWeChatDocDirPath());
    if (user) {
        return user;
    }
    return nil;
}



/// 用户信息配置完成
+(void)postUserDataConfigureCompleteNotification{
    
}

/// 是否登录
+ (BOOL)isLogin{
    LoginModel *user = [self currentUser];
    if (stringIsNullOrEmpty(user.token)) {
        return false;
    }
    return true;
}



@end
