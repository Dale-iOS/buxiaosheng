//
//  LZsharedNavigationController.m
//  BuXiaoSheng
//
//  Created by 幸福的尾巴 on 2018/8/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZsharedNavigationController.h"

@implementation LZsharedNavigationController
static LZsharedNavigationController *_instance;
+ (id)allocWithZone:(struct _NSZone *)zone{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [super allocWithZone:zone];
	});
	return _instance;
}
+ (instancetype)sharedNavigationController{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[LZsharedNavigationController alloc] init];
//		[_instance initParams];
	});
	return _instance;
}
- (id)copyWithZone:(NSZone *)zone{
	return _instance;
}
@end
