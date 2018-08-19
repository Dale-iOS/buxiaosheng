//
//  BXSHadSelectDBCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSHadSelectDBCell.h"
#import "GridTableView.h"

@interface BXSHadSelectDBCell ()<GridDataSource,GridDelegate>

@end

@implementation BXSHadSelectDBCell
{
    GridTableView *_gridView;
    NSInteger _col;
 
}

- (void)setup {
    
    UILabel *titleLabel = [ UILabel labelWithColor:CD_textCC font:FONT(14)];
    titleLabel.frame = CGRectMake(15, 0, 120, 30);
    titleLabel.text = @"已选底布";
    [self.contentView addSubview:titleLabel];
    
    _col = 0;
    GridTableView *gridView = [[GridTableView alloc]initWithCol:4];
    _gridView = gridView;
    gridView.frame = CGRectMake(0, titleLabel.bottom, APPWidth, 50);
    [gridView setDelegate:self dataSouce:self];
    gridView.headLineColor = [UIColor whiteColor];
    [gridView setHeadTitleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15]];
    [gridView setCellTextColor:CD_Text99 titleFont:FONT(14)];
    [gridView setHeadBackColor:LZHBackgroundColor CellColor:[UIColor whiteColor]];
    gridView.canDelect = NO;
    [self.contentView addSubview:gridView];
    [gridView reloData];
    
}

#pragma mark --- GridViewDelegate


-(void)setModel:(LZPurchaseModel *)model {
    _model = model;
    [_gridView reloData];
    _model.cellHeight = 70+ model.itemList.count * 30;
}
///  有多少的row
- (NSInteger)numberOfRowInGridView:(id <GridViewDelegate>)gridView {
    return _model.itemList.count;
}
/// 具体每一个cell中的数据 row ==-1则表示标题
- (__kindof NSArray *)gridView:(id<GridViewDelegate>)gridView cellForItemAtGridIndex:(GridIndex )gridIndex {
    
    if (gridIndex.row == -1) {
        return @[@"品名",@"颜色",@"条数",@"数量"];
    }
    LZPurchaseItemListModel *kModel = _model.itemList[gridIndex.row];
    
    return @[HandleNilString(kModel.productName),
             HandleNilString(kModel.productColorName),//有问题
             HandleNilString(kModel.total),
             HandleNilString(kModel.number)];
}

- (CGFloat)heightOfGridViewAtRow:(NSUInteger)row {
    if (row == -1) {
        return 40.f;
    }
    return 30.f;
}

#pragma mark --- GridViewDelegate
- (NSArray *)widthsOfGridView:(id <GridViewDelegate>)gridView {
    return @[@0.25,@0.25,@0.25,@0.25];
}

/// 点击cell的删除
- (void)didClickCellDelectAtRow:(NSInteger)row {
}
@end
