//
//  AppDelegate.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "IQKeyboardManager.h"
#import "LLWelcomeVC.h"
#import "AppDelegate+LLJPuchAppDelegate.h"

#import "LZSalesDemandVC.h"
#import "SpendingViewController.h"
#import "InventoryViewController.h"
#import "AuditViewController.h"
#import "LZsharedNavigationController.h"
@interface AppDelegate ()
@property(strong,nonatomic)BaseNavigationController *baseNaVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	//设置IQKeyboardManager
	[self settingIQKeyboardManager];
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
   self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    //初始化激光推送
    [self setupJPuchWith:application Options:launchOptions];
	[LZsharedNavigationController sharedNavigationController];
    if ([BXSTools welcomeShow]) {
        LLWelcomeVC *vc = [[LLWelcomeVC alloc]init];
        self.window.rootViewController = vc;
        //nav.navigationBarHidden = true;
    }else {
        if ([BXSUser isLogin]) {
            HomeViewController *vc = [[HomeViewController alloc]init];
            self.baseNaVC = [[BaseNavigationController alloc]initWithRootViewController:vc];
			[LZsharedNavigationController sharedNavigationController].baseNavigationController =self.baseNaVC;
            self.window.rootViewController = self.baseNaVC;
        }else {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            self.baseNaVC = [[BaseNavigationController alloc]initWithRootViewController:loginVC];
            self.window.rootViewController = self.baseNaVC;
            self.baseNaVC.navigationBarHidden = NO;
        }
    }
//    nav.navigationBarHidden = NO;
    [self.window makeKeyAndVisible];

	//创建应用图标上的3D touch快捷选项
	UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
	//如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
	if (shortcutItem) {
		[self setting3DtouchPerformActionForShortcutItem:shortcutItem];
		return NO;
	}
    return YES;
}
/**
 3Dtouch 跳转的对应控制器

 @param shortcutItem item
 */
- (void)setting3DtouchPerformActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem{
	BaseNavigationController *nav= [LZsharedNavigationController sharedNavigationController].baseNavigationController;
	if (![LZsharedNavigationController sharedNavigationController].baseNavigationController) {
		NSLog(@"--nav不存在,跳转失败!");
	}else{
		//进入开单界面
		if([shortcutItem.type isEqualToString:@"com.LZSalesDemandVC.bxc"]){

			LZSalesDemandVC *vc = [[LZSalesDemandVC alloc]init];
			[nav pushViewController:vc animated:YES];
			NSLog(@"点击了开单界面");

			//进入支出界面
		} else if ([shortcutItem.type isEqualToString:@"com.SpendingVC.bxc"]) {
			SpendingViewController *vc = [[SpendingViewController alloc]init];
			[nav pushViewController:vc animated:YES];
			NSLog(@"点击进入支出界面");

			//进入库存界面
		} else if ([shortcutItem.type isEqualToString:@"com.InventoryVC.bxc"]) {
			InventoryViewController *vc = [[InventoryViewController alloc]init];
			[nav pushViewController:vc animated:YES];
			NSLog(@"点击进入库存界面");

			//进入审批界面
		}else if([shortcutItem.type isEqualToString:@"com.AuditVC.bxc"]){
			AuditViewController *vc = [[AuditViewController alloc]init];
			[nav pushViewController:vc animated:YES];
			NSLog(@"点击进入审批界面");
		}
	}
}
#pragma mark -------  设置IQKeyboardManager -------
- (void)settingIQKeyboardManager{
	IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量

	keyboardManager.enable = YES; // 控制整个功能是否启用
	keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
	keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
	keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
	keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
	//    keyboardManager.shouldShowTextFieldPlaceholder = YES;
	keyboardManager.shouldShowToolbarPlaceholder = YES;
	// 是否显示占位文字
	keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
	keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
    
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application  didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
        NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    }
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];

    completionHandler(UIBackgroundFetchResultNewData);
}
//如果app在后台，通过快捷选项标签进入app，则调用该方法，如果app不在后台已杀死，则处理通过快捷选项标签进入app的逻辑在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
	if (![LZsharedNavigationController sharedNavigationController].baseNavigationController) {
		NSLog(@"--nav不存在,跳转失败!");
	}else{
		if (shortcutItem) {
			[self setting3DtouchPerformActionForShortcutItem:shortcutItem];
		}
		if (completionHandler) {
			completionHandler(YES);
		}
	}
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
