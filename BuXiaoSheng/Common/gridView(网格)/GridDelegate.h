//
//  GridDelegate.h
//  MarkSelect
//
//  Created by 家朋 on 2018/7/5.
//  Copyright © 2018年 家朋. All rights reserved.
//

typedef struct CG_BOXABLE GridIndex GridIndex;
struct GridIndex {
    NSUInteger col,row;
};
CG_INLINE struct GridIndex
GridIndexMake(NSInteger col, NSInteger row)
{
    GridIndex index;
    index.col = col;
    index.row = row;
    return index;
}
#define DELETEWIDTH 70.0


#import <Foundation/Foundation.h>
@class GridDataSource,GridDelegate;
/// 整个girdView是不备重用的
@protocol GridViewDelegate <NSObject>
/// 头部标题数据
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)UIColor *headLineColor;
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

-(void)setDelegate:(id)delegate dataSouce:(id)dataSouce;


@end



@protocol GridDelegate <NSObject>


@optional;
/// 每行的高度 row ==-1表示标题的高度（默认是50.f）
- (CGFloat)heightOfGridViewAtRow:(NSUInteger)row;
/// 每一列的宽度（返回nil则平分）@[@0.2,@0.3...];
- (NSArray *)widthsOfGridView:(id <GridViewDelegate>)gridView;
/// 每一列的对应能否可以输入（返回nil则平分）@[@0.2,@0.3...];
- (NSArray *)canEdtingsOfGridView:(id <GridViewDelegate>)gridView;
/// 点击cell
- (void)didClickCellAtIndex:(GridIndex )index;
/// 点击cell的删除
- (void)didClickCellDelectAtRow:(NSInteger)row;
/// 第几行第几列 数据结束编辑，以及结束编辑的内容
- (void )gridView:(id <GridViewDelegate>)gridView
endEdtingWithText:(NSString *)text
          atIndex:(GridIndex )index;
@end


/// 数据源代理
@protocol GridDataSource <NSObject>
@required
///  有多少的row
- (NSInteger)numberOfRowInGridView:(id <GridViewDelegate>)gridView;
/// 具体每一个cell中的数据 row ==-1则表示标题
- (__kindof NSArray *)gridView:(id <GridViewDelegate>)gridView cellForItemAtGridIndex:(GridIndex )gridIndex;


@optional
/////  <<<< 以后的拓展 >>>>
//- (NSInteger)gridView:(GridView *)gridView numberOfItemsInSection:(NSInteger)section;
///// section类型的gridView--暂时不做
//- (NSInteger)numberOfSectionsInGridView:(GridView *)gridView;
@end

