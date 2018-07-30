//
//  kVoid.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *HandleNilString(NSString *sring);
NSString *HandleNilStringToZone(NSString *sring);
id safeObjectAtIndex(NSArray *array,NSInteger index);

@interface kVoid : NSObject

@end
