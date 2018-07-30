//
//  kVoid.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "kVoid.h"

NSString *HandleNilString(NSString *sring) {
    if ([sring isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (sring == nil ||sring.length == 0||[sring isEqualToString:@""]||[sring isEqualToString:@"(null)"]) {
        return @"";
    }
    return sring;
}
NSString *HandleNilStringToZone(NSString *sring) {
    if ([sring isKindOfClass:[NSNull class]]) {
        return @"0";
    }
    if (sring == nil ||sring.length == 0||[sring isEqualToString:@""]||[sring isEqualToString:@"(null)"]) {
        return @"0";
    }
    return sring;
}

id safeObjectAtIndex(NSArray *array,NSInteger index) {
    
    if (array.count <index) {
        return array[index];
    }
    return nil;
    
}
@implementation kVoid

@end
