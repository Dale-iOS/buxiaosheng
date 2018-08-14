//
//  LZsharedNavigationController.h
//  BuXiaoSheng
//
//  Created by 幸福的尾巴 on 2018/8/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNavigationController.h"
@interface LZsharedNavigationController : NSObject
/**
 *  单列
 */
+ (instancetype)sharedNavigationController;
@property(strong,nonatomic)BaseNavigationController *baseNavigationController;
@property(copy,nonatomic)NSString * shortcutItemType;
@property(nonatomic,assign)BOOL navExistence;
-(void)pushPerformActionForShortcutItemVC;
@end
