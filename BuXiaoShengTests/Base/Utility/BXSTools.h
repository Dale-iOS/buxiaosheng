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
@end