//
//  ChooseLabelsVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DrawerType) {
    DrawerDefaultLeft = 1, // 默认动画，左侧划出
    DrawerDefaultRight,    // 默认动画，右侧滑出
    DrawerTypeMaskLeft,    // 遮盖动画，左侧划出
    DrawerTypeMaskRight    // 遮盖动画，右侧滑出
};

@interface ChooseLabelsVC : UIViewController

@property (nonatomic,assign) DrawerType drawerType; // 抽屉类型

@property (nonatomic,copy) void(^LabelsArrayBlock)(NSString *labelString,NSString *id);

@end
