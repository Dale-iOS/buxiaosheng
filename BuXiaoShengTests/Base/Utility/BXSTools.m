//
//  BXSTools.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSTools.h"

@implementation BXSTools
+(BOOL)stringIsNullOrEmpty:(NSString *)str {
    if ([str isKindOfClass:[NSNull class]]) {
        return true;
    }
    if (str == nil ||str.length == 0||[str isEqualToString:@""]||[str isEqualToString:@"(null)"]) {
        return true;
    }
    
    return false;
}

+(BOOL)isBankCard:(NSString *)cardNumber{
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

+ (NSString *)getTimeStrWithString:(NSString*)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];//创建一个时间
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];//设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];
    NSString *timeStr = [NSString stringWithFormat:@"%ld",(long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳，精确到毫秒*1000
    return timeStr;
}

//时间戳(13位)转为时间
+(NSString *)stringFromTimestamp:(NSString*)str {

    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[str doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

/**
 *  返回当前视图的控制器
 */
+ (UIViewController *)viewWithViewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
