//
//  Utility.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

//创建navigation title
+ (UIView *)navTitleView:(NSString *)_title;

//+ (UIView *)navTitleView2:(NSString *)_title;
//
//+ (UIView *)navTitleViewSessionList:(NSString *)_title;

// 统一返回按钮
+ (UIBarButtonItem*)navLeftBackBtn:(id)_target action:(SEL)selector;

@end
