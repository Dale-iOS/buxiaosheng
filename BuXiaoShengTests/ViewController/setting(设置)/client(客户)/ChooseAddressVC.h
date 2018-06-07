//
//  ChooseAddressVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger,DrawerType1) {
//    DrawerDefaultLeft1 = 1, // 默认动画，左侧划出
//    DrawerDefaultRight1,    // 默认动画，右侧滑出
//    DrawerTypeMaskLeft1,    // 遮盖动画，左侧划出
//    DrawerTypeMaskRight1    // 遮盖动画，右侧滑出
//};

@interface ChooseAddressVC : UIViewController
//@property (nonatomic,assign) DrawerType1 drawerType; // 抽屉类型

@property (nonatomic,copy) void(^LabelsArrayBlock)(NSString *labelString);

@end
