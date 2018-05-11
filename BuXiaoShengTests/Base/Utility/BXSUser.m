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
    static LoginModel *onceUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        onceUser = [LoginModel new];
    });
    LoginModel *user;
    WZLSERIALIZE_UNARCHIVE(user, BXSCacheUserKey, MHWeChatDocDirPath());
    [self setonceUserValue:user withOnceUser:onceUser];
    return onceUser;
}


+(void)setonceUserValue:(LoginModel *)user withOnceUser:(LoginModel *)onceUser{
        unsigned int iVarCount = 0;
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        Ivar *ivarList =  class_copyIvarList([user class], &iVarCount) ;/*变量列表，含属性以及私有变量*/
        objc_property_t *propList = class_copyPropertyList([user class], &propVarCount);/*属性列表*/
        sharedVarCount = iVarCount ;
        
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = property_getName(*(propList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/  \
            id varValue = [user valueForKey:key];
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"];
            if (varValue && [filters containsObject:key] == NO) {
                [onceUser setValue:varValue ? : @"" forKey:key];
            }
        }
        free(ivarList);
        free(propList);
        
   
}



/// 用户信息配置完成
+(void)postUserDataConfigureCompleteNotification{
    
}

/// 是否登录
+ (BOOL)isLogin{
    LoginModel *user = [self currentUser];
    if ([BXSTools stringIsNullOrEmpty:user.token]) {
        return false;
    }
    return true;
}



@end
