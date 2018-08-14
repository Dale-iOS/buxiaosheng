//
//  LZsharedNavigationController.m
//  BuXiaoSheng
//
//  Created by 幸福的尾巴 on 2018/8/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZsharedNavigationController.h"
#import "LZSalesDemandVC.h"
#import "SpendingViewController.h"
#import "InventoryViewController.h"
#import "AuditViewController.h"
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
//登录成功后是否跳转
-(void)pushPerformActionForShortcutItemVC{
	//点击某个item进入的
	if ([self.shortcutItemType hasPrefix:@"com"]) {
		//进入开单界面
		if([self.shortcutItemType isEqualToString:@"com.LZSalesDemandVC.bxc"]){
			self.shortcutItemType = nil;
			if (self.navExistence) {
				self.navExistence = NO;
				LZSalesDemandVC *vc = [[LZSalesDemandVC alloc]init];
				[self.baseNavigationController pushViewController:vc animated:YES];
			}
			NSLog(@"点击了开单界面");

			//进入支出界面
		} else if ([self.shortcutItemType isEqualToString:@"com.SpendingVC.bxc"]) {
			self.shortcutItemType = nil;
			if (self.navExistence) {
			SpendingViewController *vc = [[SpendingViewController alloc]init];
			[self.baseNavigationController pushViewController:vc animated:YES];
			}
			NSLog(@"点击进入支出界面");

			//进入库存界面
		} else if ([self.shortcutItemType isEqualToString:@"com.InventoryVC.bxc"]) {
			self.shortcutItemType = nil;
			if (self.navExistence) {
			InventoryViewController *vc = [[InventoryViewController alloc]init];
			[self.baseNavigationController pushViewController:vc animated:YES];
			}
			NSLog(@"点击进入库存界面");

			//进入审批界面
		}else if([self.shortcutItemType isEqualToString:@"com.AuditVC.bxc"]){
			self.shortcutItemType = nil;
			if (self.navExistence) {
			AuditViewController *vc = [[AuditViewController alloc]init];
			[self.baseNavigationController pushViewController:vc animated:YES];
			}
			NSLog(@"点击进入审批界面");
		}
	}
}
@end
