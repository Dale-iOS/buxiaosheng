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
    if (str == nil ||str.length == 0||[str isEqualToString:@""]||[str isEqualToString:@"(null)"]) {
        return true;
    }
    
    return false;
}
@end
