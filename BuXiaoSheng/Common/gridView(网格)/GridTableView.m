//
//  GridView.m
//  JDemo
//
//  Created by BangYou on 2018/7/2.
//  Copyright © 2018年 BangYou. All rights reserved.
//




#import "GridTableView.h"


@interface GridTableCell : UITableViewCell<UITextFieldDelegate>

- (instancetype)initWithColWidths:(NSArray *)widths;
@property (nonatomic,strong)UIFont  *textFont;
@property (nonatomic,strong)UIColor *textColor;
@property (nonatomic,strong)NSArray *dataArray;
@property (strong,nonatomic)NSArray *widthArray;

@property (copy,nonatomic)void (^endEdtingBlock)(NSString *text, NSUInteger index);

@property (strong,nonatomic)NSArray *canEndtingArray;
@end
@implementation GridTableCell{
    //UIScrollView *_backScrView;
    
    NSArray *_textFieldArray;
    UIButton *_delectButton;
    
    UIView *_redView;
    
    BOOL _decelerate;
    NSInteger _gridCol;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _gridCol = reuseIdentifier.integerValue;
        [self setup];
    }
    return self;
}
- (instancetype)initWithColWidths:(NSArray *)widths {
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}
-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}
-(void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    for (UITextField *tf in _textFieldArray) {
        tf.font = textFont;
    }
}
-(void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for (UITextField *label in  _textFieldArray) {
        label.textColor = textColor;
    }
}
-(void)setCanEndtingArray:(NSArray *)canEndtingArray {
    _canEndtingArray = canEndtingArray;
    for (int i=0;i<_textFieldArray.count;i++) {
        UITextField *textField  = _textFieldArray[i];
        BOOL isCanEdting = [canEndtingArray[i] boolValue];
        textField.enabled = isCanEdting;
        
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    _delectButton.frame = CGRectMake(self.width , 0, 50, self.height);
    _redView.frame = CGRectMake(self.width, 0, 100, self.height);
    UITextField *lastLabel = nil;
    for (int i=0;i<_textFieldArray.count;i++) {
        UITextField *label = _textFieldArray[i];
        
        CGFloat widhMultiple = [_widthArray[i] floatValue];
        label.frame = CGRectMake(lastLabel.right,0, self.width *widhMultiple, self.height);
        lastLabel = label;
    }
}
- (void)setup {
    
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor whiteColor];
    // col
    UITextField *leftlabel;
    NSMutableArray *labels = [NSMutableArray arrayWithCapacity:_widthArray.count];
    // 创建label
    for (int i=0; i<_gridCol; i++) {
        UITextField *textField = [[UITextField alloc]init];
        [self addSubview:textField];
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = [UIColor clearColor];
        textField.enabled = NO;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.delegate = self;
        // 添加到数组
        [labels addObject:textField];
        leftlabel = textField;
    }
    
    _textFieldArray = [labels mutableCopy];
}

-(void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    NSUInteger count = MIN(dataArray.count, _textFieldArray.count);
    for (int i=0; i<count; i++) {
        UILabel *label = _textFieldArray[i];
        NSString *title = _dataArray[i];
        label.text = title;
        
    }
}


//MARK: -- UITextFieldDelegate --
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSUInteger index = 0;
    if ([_textFieldArray containsObject:textField]) {
        index = [_textFieldArray indexOfObject:textField];
    }
    NSString *text = [BXSTools isEmptyString:textField.text]?@"":textField.text;
    !_endEdtingBlock?:_endEdtingBlock(text,index);
}

@end

/////////////// 我是分割线 ///////////////
@interface GridTableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak)id <GridDataSource>dataSource;
@property (nonatomic,weak)id <GridDelegate>delegate;

@property (strong,nonatomic)NSMutableArray *dataSouce;
@end

@implementation GridTableView
{
    
    UITableView *_tableView;
    
    UIFont *_headFont,
    *_cellTextFont;
    
    UIColor *_headColor,
    *_cellTextColor,
    *_headBackColor,
    *_cellBaceColor;
    
    NSUInteger _gridCol;
    CGFloat _cellHeight;
    NSString *_cellID;
    NSArray *_cellWidths;
    NSArray *_canEdtingArray;
    
    
}


/// 懒加载

- (NSMutableArray *)dataSouce {
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];
    }
    return _dataSouce;
}

-(instancetype)initWithCol:(NSUInteger)gridCol {
    if (self = [super init]) {
        _gridCol = gridCol;
        _canDelect = YES;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.frame = CGRectMake(0, 0, APPWidth, 0);
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    
    //cell
    _cellID = [NSString stringWithFormat:@"%ld",_gridCol];
    [_tableView registerClass:[GridTableCell class] forCellReuseIdentifier:_cellID];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    // 设置默认的数据
    _cellHeight = 50.f;
    _headFont = _cellTextFont = [UIFont systemFontOfSize:15];
    _headColor = _cellTextColor = [UIColor blackColor];
    _headBackColor = _cellBaceColor = [UIColor whiteColor];
    
}


#pragma mark ----SET

-(void)setDelegate:(id)delegate dataSouce:(id)dataSouce {
    self.delegate = delegate;
    self.dataSource = dataSouce;
}
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
    int i = -1;
    
    if (row < 0) return;
    
    // 先移除全部的cell
    [self.dataSouce removeAllObjects];
    CGFloat kVHeight = 0;
    for (int k=0 ;k<row+1;k++) {
        i = k-1;
        // 从代理的数据源中取出cell数据
        NSArray *cellData = nil;
        if ([_dataSource respondsToSelector:@selector(gridView:cellForItemAtGridIndex:)])
        {
            cellData = [_dataSource gridView:self cellForItemAtGridIndex:GridIndexMake(0, i)];
            
        }
        // 代理中的title为空 则使用属性中的title
        if (cellData.count > 0) {
            [self.dataSouce addObject:cellData];
        }else{
            NSAssert(cellData.count > 0 ,i == -1? @"请设置数标题":@"请设置数据源");
            
        }
        
        if ([_delegate respondsToSelector:@selector(heightOfGridViewAtRow:)]) {
            CGFloat height = [_delegate heightOfGridViewAtRow:i];
            height = height>0?height:_cellHeight;
            kVHeight += height;
        }
    }
    
    //得到cell的能否编辑
    if ([_delegate respondsToSelector:@selector(canEdtingsOfGridView:)]) {
        _canEdtingArray = [_delegate canEdtingsOfGridView:self];
    }
    //得到cell的width
    if ([_delegate respondsToSelector:@selector(widthsOfGridView:)]) {
        _cellWidths = [_delegate widthsOfGridView:self];
    }
    if (_cellWidths == nil) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_gridCol];
        for (int i=0;i<_gridCol;i++) {
            CGFloat width = 1.0/(_gridCol*1.0);
            [arr addObject:@(width)];
        }
        _cellWidths = [arr mutableCopy];
    }
    self.height = kVHeight;
    _tableView.height = kVHeight;
    [_tableView reloadData];
}




#pragma mark ----UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellID];
    if (indexPath.row == 0) {
        cell.textColor = _headColor;
        cell.textFont = _headFont;
        cell.backgroundColor = _headBackColor;
    }else{
        cell.backgroundColor = _cellBaceColor;
        cell.textColor = _cellTextColor;
        cell.textFont = _cellTextFont;
    }
    
    if (_canEdtingArray) {
        cell.canEndtingArray = _canEdtingArray;
    }
    
    NSArray *titls = [self.dataSouce objectAtIndex:indexPath.row];
    cell.widthArray = _cellWidths;
    cell.dataArray = titls;
    
    WEAKSELF;
    cell.endEdtingBlock = ^(NSString *text, NSUInteger index) {
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(gridView:endEdtingWithText:atIndex:)]) {
            [weakSelf.delegate gridView:weakSelf endEdtingWithText:text atIndex:GridIndexMake(index, indexPath.row-1)];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(heightOfGridViewAtRow:)]) {
        CGFloat height = [_delegate heightOfGridViewAtRow:indexPath.row-1];
        height = height>0?height:_cellHeight;
        return height;
    }
    return _cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return NO;
    }
    return _canDelect;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickCellDelectAtRow:)]) {
            [_delegate didClickCellDelectAtRow:indexPath.row];
        }
    }
}


@end


