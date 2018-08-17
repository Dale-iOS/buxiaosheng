//
//  GridView.m
//  JDemo
//
//  Created by BangYou on 2018/7/2.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "GridView.h"


@interface GridCell : UIView
- (instancetype)initWithColWidths:(NSArray *)widths;
@property (nonatomic,strong)UIFont  *textFont;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)NSArray *dataArray;

@end
@implementation GridCell{
    //UIScrollView *_backScrView;
    NSArray *_widthArray;
    NSArray *_labelArray;
}
- (instancetype)initWithColWidths:(NSArray *)widths {
    if (self = [super init]) {
        
        _widthArray = widths;
        [self setup];
    }
    return self;
}
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}
-(void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    for (UILabel *label in _labelArray) {
        label.font = textFont;
    }
}
-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (UILabel *label in _labelArray) {
        label.textColor = textColor;
    }
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    UILabel *lastLabel = nil;
    for (int i=0;i<_labelArray.count;i++) {
        UILabel *label = _labelArray[i];
        CGFloat widhMultiple = [_widthArray[i] floatValue];
        label.frame = CGRectMake(lastLabel.right,0, self.width *widhMultiple, self.height);
        lastLabel = label;
    }
}
- (void)setup {
    
    //_backScrView
    //    _backScrView = [[UIScrollView alloc]init];
    //    _backScrView.showsVerticalScrollIndicator = NO;
    //    _backScrView.showsHorizontalScrollIndicator = NO;
    //    _backScrView.scrollEnabled = NO;
    //    [self addSubview:_backScrView];
    //    _backScrView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    // col
    UILabel *leftlabel;
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:_widthArray.count];
    // 创建label
    for (int i=0; i<_widthArray.count; i++) {
        UILabel *label = [[UILabel alloc]init];
        [self addSubview:label];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        // 添加到数组
        [labels addObject:label];
        leftlabel = label;
    }
    
    _labelArray = [labels mutableCopy];
}

-(void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    NSUInteger count = MIN(dataArray.count, _labelArray.count);
    for (int i=0; i<count; i++) {
        UILabel *label = _labelArray[i];
        NSString *title = HandleNilString(_dataArray[i]);
        label.text = title;
        
    }
}


@end

/////////////// 我是分割线 ///////////////

@implementation GridView
{
    
    UIFont *_headFont,
    *_cellTextFont;
    
    UIColor *_headColor,
    *_cellTextColor,
    *_headBackColor,
    *_cellBaceColor;
    
    NSUInteger _gridCol;
    CGFloat _cellHeiht;
    
    NSMutableDictionary *_cellDict;
    
}

-(instancetype)initWithCol:(NSUInteger)gridCol {
    if (self = [super init]) {
        _gridCol = gridCol;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    _cellDict = [NSMutableDictionary dictionary];
    // 设置默认的数据
    _cellHeiht = 50.f;
    _headFont = _cellTextFont = [UIFont systemFontOfSize:15];
    _headColor = _cellTextColor = [UIColor blackColor];
    _headBackColor = _cellBaceColor = [UIColor whiteColor];
}

#pragma mark - SET
-(void)setHeadTitleColor:(UIColor *)color titleFont:(UIFont *)font {
    _headColor = color;
    _headFont = font;
}
-(void)setCellTextColor:(UIColor *)color titleFont:(UIFont *)font {
    _cellTextColor = color;
    _cellTextFont = font;
    
}
- (void)setHeadBackColor:(UIColor *)backColor
               CellColor:(UIColor *)cellColor {
    _headBackColor = backColor;
    _cellBaceColor = cellColor;
}


-(void)reloData {
    
    if (!_delegate||!_dataSource) {
        NSLog(@"请设置代理 傻不傻@~@");
        return;
    }
    // 获取row的个数
    NSInteger row = [_dataSource numberOfRowInGridView:self];
    UIView *lastView = nil;
    int i = -1;
    if (row < 0) return;
    
    // 先移除全部的cell
    [self removeAllSubviews];
    
    for (int k=0 ;k<row+1;k++) {
        i = k-1;
        // 从代理的数据源中取出cell数据
        NSArray *cellData = nil;
        if ([_dataSource respondsToSelector:@selector(gridView:cellForItemAtGridIndex:)])
        {
            cellData = [_dataSource gridView:self cellForItemAtGridIndex:GridIndexMake(0, i)];
            
        }
        // 代理中的title为空 则使用属性中的title
        if (i==-1) {
            _titles = cellData?cellData:_titles;
        }else{
            _titles = cellData;
        }
        
        //得到cell的width
        NSArray *cellWidths = nil;
        if ([_delegate respondsToSelector:@selector(widthsOfGridView:)]) {
            cellWidths = [_delegate widthsOfGridView:self];
        }
        if (cellWidths == nil) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_gridCol];
            for (int i=0;i<_gridCol;i++) {
                CGFloat width = 1.0/(_gridCol*1.0);
                [arr addObject:@(width)];
            }
            cellWidths = [arr mutableCopy];
        }
        // 标题高度
        CGFloat cellHeight = 50.f;
        if ([_delegate respondsToSelector:@selector(heightOfGridViewAtRow:)]) {
            CGFloat height = [_delegate heightOfGridViewAtRow:i];
            cellHeight = height>0?height:cellHeight;
        }
        
        //从缓存取出titleView,没有则创建
        NSString *key = [NSString stringWithFormat:@"%d",i];
        GridCell *cell = [_cellDict valueForKey:key];
        if (cell == nil) {
            cell = [[GridCell alloc] initWithColWidths:cellWidths];
            [_cellDict setValue:cell forKey:key];
            if (i==-1) {
                cell.textColor = _headColor;
                cell.textFont = _headFont;
                
            }else{
                cell.textColor = _cellTextColor;
                cell.textFont = _cellTextFont;
            }
        }
        if (i==-1) {
            cell.backgroundColor = _headBackColor;
        }else{
            cell.backgroundColor = _cellBaceColor;
        }
        
        
        [self addSubview:cell];
        cell.frame = CGRectMake(0, lastView.bottom, self.width, cellHeight);
        // cell刷数据
        cell.dataArray = cellData;
        lastView = cell;
    }
    self.height = lastView.bottom;
}

@end
