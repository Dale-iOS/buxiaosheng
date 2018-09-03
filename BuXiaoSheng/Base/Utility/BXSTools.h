//
//  BXSTools.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BXSTools : NSObject
+(BOOL)stringIsNullOrEmpty:(NSString *)str ;
+(BOOL)isBankCard:(NSString *)cardNumber;
///字符串转时间戳
+ (NSString *)getTimeStrWithString:(NSString*)str;
///时间戳转时间
+(NSString *)stringFromTimestamp:(NSString*)str;
///后台返回的数据转日期带"-"
+(NSString *)stringFromTData:(NSString*)str;
+ (UIViewController *)viewWithViewController:(UIView *)view;

+(BOOL)welcomeShow;

//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr;
+ (NSString *)notRounding:(double)price afterPoint:(int)position;

@end
