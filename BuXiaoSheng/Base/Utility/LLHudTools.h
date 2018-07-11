//
//  LLHudTools.h
//  JLCWorkForApple
//
//  Created by 周尊贤 on 2018/3/1.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLHudTools : NSObject
+(void)showWithMessage:(NSString *)message;

+(void)showLoadingMessage:(NSString *)message;

+(void)dismiss;
@end
