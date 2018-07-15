//
//  BaseModel.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};
- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}
@end
