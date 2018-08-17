//
//  GridTableView.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "GridDelegate.h"



@interface GridTableView : UIView<GridViewDelegate>
/// 头部标题数据
@property (nonatomic,strong)NSArray *titles;

@property (nonatomic,strong)UIColor *headLineColor;

/// 默认YES 是可以策划删除的
@property (assign,nonatomic) BOOL canDelect;
/// 构造方法
- (instancetype)initWithCol:(NSUInteger)gridCol;
/// 刷新数据
- (void)reloData;
/// 设置头部的颜色和字体
- (void)setHeadTitleColor:(UIColor *)color
                titleFont:(UIFont *)font;
/// 设置cell的字体和颜色
- (void)setCellTextColor:(UIColor *)color
               titleFont:(UIFont *)font;

- (void)setHeadBackColor:(UIColor *)backColor
               CellColor:(UIColor *)cellColor;

/// 设置代理和数据源
-(void)setDelegate:(id<GridDelegate>)delegate dataSouce:(id<GridDataSource>)dataSouce;
@end

