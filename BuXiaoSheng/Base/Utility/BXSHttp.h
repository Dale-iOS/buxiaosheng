//
//  BXSHttp.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define appName @"buxiaosheng_ios"
#define appVersion @"1.0"
#define key_str @"3D49257E25A04D16D97A3F024AA718A1"
//正式环境
#define BXSBaseURL  @"http://www.buxiaosheng.com/web-api/"
//测试环境
//#define BXSBaseURL  @"http://192.168.3.253:8080/web-api/"
@interface BXSHttp : NSObject

+(void)requestPOSTWithAppURL:(NSString *) url  param:(NSDictionary *) param  success:(void (^)(id response))success  failure:(void (^) (NSError * error)) failure;

+(void)requestGETWithAppURL:(NSString *) url param:(NSDictionary *) param  success:(void (^)(id response))success  failure:(void (^) (NSError * error)) failure ;

+(void)downloadWithTaskUrl:(NSString *)downURL  downLoadBlock:(void (^) (NSString * filePath)) block;

+(void)requestPOSTPhotosWithArray:(NSArray *)photosArray param:(NSDictionary *)param AppURL:(NSString *)url Key:(NSString *)keyString success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;

/**
 获取一些写死的签名值

 @return 字典
 */
+(NSMutableDictionary*) getConstantParam;

/**
 获取签名的key

 @param param 所有要穿的参数
 @return MD5签名
 */
+(NSString *)sortObjectsAccordingToValueMD5With:(NSDictionary *)param;

///md5 32位加密 转大写
+ (NSString *)makeMD5:(NSString *)signString;


@end
