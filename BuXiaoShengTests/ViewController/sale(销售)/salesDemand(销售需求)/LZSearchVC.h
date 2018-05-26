//
//  LZSearchVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/25.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger,SearchType) {
    searchProduct = 0, // 搜索品名
    searchProductColor, //搜索颜色
    //    DrawerDefaultRight,    // 默认动画，右侧滑出
    //    DrawerTypeMaskLeft,    // 遮盖动画，左侧划出
    //    DrawerTypeMaskRight    // 遮盖动画，右侧滑出
};

@interface LZSearchVC : BaseViewController
@property (nonatomic,copy) void(^TitleBtnBlock)(NSString *titleInfo);
@property (nonatomic,assign) SearchType searchType; // 搜索内容
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *productId;

@end
