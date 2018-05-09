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

+(NSMutableDictionary*) getConstantParam;
@end
