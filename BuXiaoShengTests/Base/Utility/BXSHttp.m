//
//  BXSHttp.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/9.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSHttp.h"
#import "LLNetWorkTools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation BXSHttp

+(void)requestPOSTWithAppURL:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSString * requsetURL = [NSString stringWithFormat:@"%@%@?",BXSBaseURL,url];
    NSMutableDictionary * baseParam =  [self getConstantParam];
    [baseParam addEntriesFromDictionary:param];
    baseParam[@"sign"] = [self sortObjectsAccordingToValueMD5With:baseParam];
    
    [LLNetWorkTools.shareTools.param(baseParam).urlStr(requsetURL) POSTWithSucces:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } error:^(NSError * error) {
        if (failure) {
              failure(error);
        }
    }];
}
+(void)requestGETWithAppURL:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * requsetURL = [NSString stringWithFormat:@"%@%@?",BXSBaseURL,url];
    NSMutableDictionary * baseParam =  [self getConstantParam];
    [baseParam addEntriesFromDictionary:param];
    baseParam[@"sign"] = [self sortObjectsAccordingToValueMD5With:baseParam];
    [LLNetWorkTools.shareTools.urlStr(requsetURL).param(baseParam) GETWithSucces:^(id responseObject)
     {
     if (success) {
        success(responseObject);
        }
    } error:^(NSError * error) {
         if (failure) {
             failure(error);
         }
     }];
}

+(void)downloadWithTaskUrl:(NSString *)downURL downLoadBlock:(void (^)(NSString *))block {
    
    NSString * newURL =    [self makeMD5:downURL];
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    documentsPath  = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",newURL]];
    NSFileManager * fm=[NSFileManager defaultManager];
    NSData * data = [fm contentsAtPath:documentsPath];
    if (data != nil) {
        block(documentsPath);
    }else {
        [[LLNetWorkTools shareTools]setDownloadWithTaskUrl:downURL saveName:newURL downLoadBlock:^(NSString *filePath) {
            block(filePath);
        }];
        
    }
}

+(NSMutableDictionary*) getConstantParam {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"appVersion"] =  appVersion;
    param[@"appName"] = appName;
//    param[@"key_str"] =  key_str
    param[@"timestamp"] = [self stringFromDate];
    param[@"key_str"] = key_str;
    return param;
}

+(NSString*)stringFromDate {
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    double i=time;      //NSTimeInterval返回的是double类型
    NSString * str = [NSString stringWithFormat:@"%f",i];
    return [str substringWithRange:NSMakeRange(0, 13)];
}

// 按首字母分组排序数组
+(NSString *)sortObjectsAccordingToValueMD5With:(NSDictionary *)param {
    
    NSArray *keys = [param allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options: NSForcedOrderingSearch];
    }];
    
    for (NSString *categoryId in sortedArray) {
        NSLog(@"[dict objectForKey:categoryId] === %@",[param objectForKey:categoryId]);
    }
    
    NSMutableString * str = [NSMutableString string];
    [sortedArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendFormat:@"%@", param[obj]];
    }];
    [str appendFormat:@"%@", key_str];
    
    NSString * md5Str = [self makeMD5:str];
    
    return md5Str;
}
+ (NSString *)makeMD5:(NSString *)signString
{
    const char *cStr = [signString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X",result[i]];
    }
    return ret;
}

@end
