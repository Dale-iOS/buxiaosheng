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
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

///后台返回的数据转日期带"-"
+(NSString *)stringFromTData:(NSString*)str{
    if (str.length >=8) {
        NSMutableString* date=[[NSMutableString alloc]initWithString:str];//存在堆区，可变字符串
        [date insertString:@"-"atIndex:4];//把一个字符串插入另一个字符串中的某一个位置
        [date insertString:@"-"atIndex:7];
        return date;
    }else{
        return str;
    }
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

+(BOOL)welcomeShow {
    
    //判断app的版本号
    NSString * key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString * curentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"%@",curentVersion);
    //获得沙盒中的版本号
    NSString * sanBoxVerison = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    NSLog(@"%@",sanBoxVerison);
    if (![curentVersion isEqualToString:sanBoxVerison]) {
        //存储当前的版本号
        [[NSUserDefaults standardUserDefaults]setObject:curentVersion forKey:key];
        //立即进行存储
        [[NSUserDefaults standardUserDefaults]synchronize];
        return true;
    }
    return false;
}

//字符串为空检查
+ (BOOL)isEmptyString:(NSString *)sourceStr {
    if ((NSNull *)sourceStr == [NSNull null]) {
        return YES;
    }
    if (sourceStr == nil) {
        return YES;
    }
    if (sourceStr == NULL) {
        return YES;
    }
    if ([sourceStr isEqual:[NSNull null]]) {
        return YES;
    }
    if (![sourceStr isKindOfClass:[NSString class]]) {
        return YES;
    }
    if([sourceStr isEqualToString:@"<null>"]){
        return YES;
    }
    if ([sourceStr isEqualToString:@"null"]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([sourceStr isEqualToString:@""]) {
        return YES;
    }
    if (sourceStr.length == 0) {
        return YES;
    }
    return NO;
}

+ (NSString *)notRounding:(double)price afterPoint:(int)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end
