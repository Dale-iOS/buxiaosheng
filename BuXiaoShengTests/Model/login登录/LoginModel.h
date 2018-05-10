//
//  LoginModel.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/10.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

///登录名称
@property(nonatomic,copy)NSString *loginName;
///是否修改过密码 (老板首次登陆是否重置过密码（0：未修改 1：已修改）)
@property(nonatomic,assign)NSInteger pwdResetStaus;
///登录安全码
@property(nonatomic,copy)NSString *token;
///用户类型 (用户类型 (0:普通用户 1:老板 ))
@property(nonatomic,assign)NSInteger type;
///用户id (数据类型：long)
@property(nonatomic,assign)NSInteger userId;

@end
