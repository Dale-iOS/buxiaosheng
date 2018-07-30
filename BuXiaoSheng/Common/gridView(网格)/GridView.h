//
//  GridView.h
//  JDemo
//
//  Created by BangYou on 2018/7/2.
//  Copyright © 2018年 BangYou. All rights reserved.
// 麻痹 添加删除功能 没看到的

#import <UIKit/UIKit.h>

#import "GridDelegate.h"




@interface GridView : UIView<GridViewDelegate>
/// 头部标题数据
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,weak)id <GridDataSource>dataSource;
@property (nonatomic,weak)id <GridDelegate>delegate;
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
/// 设置代理和数据源
-(void)setDelegate:(id<GridDelegate>)delegate dataSouce:(id<GridDataSource>)dataSouce;
@end


/*  edg:
 - (void)viewDidLoad {
 [super viewDidLoad];
 _col = 5;
 GridView *gridView = [[GridView alloc]initWithCol:5];
 gridView.frame = CGRectMake(0, 100, kScreenWidth, 500);
 gridView.delegate = self;
 gridView.dataSource = self;
 gridView.headLineColor = globalBackColor;
 [gridView setHeadTitleColor:[UIColor redColor] titleFont:Font_med(16)];
 [self.view addSubview:gridView];
 [gridView reloData];
 
 UILabel *botton = [[UILabel alloc]initWithFrame:CGRectMake(0, 500, 100, 25)];
 botton.text = @"加一个";
 [self.view addSubview:botton];
 [botton addHanderBlock:^(UIView *sender) {
 _col ++;
 [gridView reloData];
 }];
 
 UILabel *botton1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 500, 100, 25)];
 botton1.text = @"剪一个";
 [self.view addSubview:botton1];
 [botton1 addHanderBlock:^(UIView *sender) {
 _col --;
 [gridView reloData];
 }];
 
 
 }
 #pragma mark --- GridViewDelegate
 
 ///  有多少的row
 - (NSInteger)numberOfRowInGridView:(GridView *)gridView {
 return _col;
 }
 /// 具体每一个cell中的数据 row ==-1则表示标题
 - (__kindof NSArray *)gridView:(GridView *)gridView cellForItemAtGridIndex:(GridIndex )gridIndex {
 
 if (gridIndex.row == -1) {
 return @[@"标题1",@"标题2",@"什么嘛",@"鬼东西"];
 }
 return @[@"kk",@"rt",@"3245",@"fvc"];
 }
 
 - (CGFloat)heightOfGridViewAtRow:(NSUInteger)row {
 if (row == -1) {
 return 40.f;
 }
 return 30.f;
 }
 
 #pragma mark --- GridViewDelegate
 - (NSArray *)widthsOfGridView:(GridView *)gridView {
 return @[@0.2,@0.3,@0.3,@0.2,@0.1];
 }
 */

