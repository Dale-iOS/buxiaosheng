//
//  LZBackOrderItem.h
//  BuXiaoSheng
//
//  Created by Dale on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ClickType) {
    ClickTypeProduct    = 1,
    ClickTypeColor      = 2,
    ClickTypeWarehouse  = 3,
    ClickTypePayMentWay = 4,
    ClickTypeChangeNum  = 5
};

typedef NS_ENUM(NSInteger, CellType) {
    CellTypeNormal = 0,
    CellTypeBtn    = 1,
    CellTypeAddYard = 2
};

@interface LZBackOrderItem : NSObject

/**
 标题
 */
@property (nonatomic,strong) NSString *textTitle;
//输入的内容或者选择的内容
@property (nonatomic,strong) NSString *detailTitle;
//占位符
@property (nonatomic,strong) NSString *placeHolder;
//输入内容或选择内容的颜色
@property (nonatomic,strong) UIColor *detailColor;
//cell点击需要跳转的类型(比如选择品名,颜色)
@property (nonatomic,assign) ClickType clickType;
//cell的样式
@property (nonatomic,assign) CellType cellType;
//是否可以输入内容
@property (nonatomic,assign,getter=isCanInput) BOOL canInput;
//是否需要显示右侧箭头
@property (nonatomic,assign,getter=isShowArrow) BOOL showArrow;
//是否是必填项
@property (nonatomic,assign,getter=isMandatoryOption) BOOL mandatoryOption;
//是否是数字键盘
@property (nonatomic,assign,getter=isNumericKeyboard) BOOL numericKeyboard;


@end
