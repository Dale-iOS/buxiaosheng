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
#define BXSBaseURL  @"http ://www.buxiaosheng.com/web-api/"

@interface BXSHttp : NSObject

+(void)requestPOSTWithAppURL:(NSString *) url  param:(NSDictionary *) param  success:(void (^)(id response))success  failure:(void (^) (NSError * error)) failure;

+(void)requestGETWithAppURL:(NSString *) url param:(NSDictionary *) param  success:(void (^)(id response))success  failure:(void (^) (NSError * error)) failure ;

+(void)downloadWithTaskUrl:(NSString *)downURL  downLoadBlock:(void (^) (NSString * filePath)) block;

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
@end
