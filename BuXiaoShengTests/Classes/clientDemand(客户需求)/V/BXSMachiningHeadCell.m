//
//  BXSMachiningHeadCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSMachiningHeadCell.h"

#import "GridView.h"

@interface BXSMachiningHeadCell ()<GridDelegate,GridDataSource>

@end


@implementation BXSMachiningHeadCell
{
    UILabel *_nameLanel;
    UILabel *_needLabel;
    UIButton *_rightButton;
    GridView *_gridView;
    NSInteger  _col;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

-(void)setup {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 50)];
    [self.contentView addSubview:head];
    
    _nameLanel = [UILabel new];
    _nameLanel.textColor = [UIColor colorWithHexString:@"#333333"];
    _nameLanel.font = [UIFont systemFontOfSize:14];
    _nameLanel.text = @"品名儿二";
    _nameLanel.frame = CGRectMake(15, 0, 80, head.height);
    [head addSubview:_nameLanel];
    
    _needLabel =  [UILabel new];
    _needLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    _needLabel.font = [UIFont systemFontOfSize:14];
    _needLabel.text = @"需求量：3";
    _needLabel.frame = CGRectMake(_nameLanel.right+5, 0, 120, head.height);
    [head addSubview:_needLabel];
    
    
    
    _rightButton = [ComView foldingBtnWithSupView:head];
    [_rightButton addTarget:self action:@selector(clickShow:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.selected = YES;
    
    
    
    _col = 4;
    //gridView
    GridView *gridView = [[GridView alloc]initWithCol:5];
    gridView.frame = CGRectMake(0, 50, APPWidth, 500);
    gridView.delegate = self;
    gridView.dataSource = self;
    gridView.headLineColor = LZHBackgroundColor;
    [gridView setHeadTitleColor:[UIColor colorWithHexString:@"#333333"] titleFont:FONT(15)];
    
    [gridView setHeadBackColor:LZHBackgroundColor CellColor:[UIColor whiteColor]];
    [gridView setCellTextColor:CD_Text99 titleFont:FONT(14)];
    
    [self.contentView addSubview:gridView];
    [gridView reloData];
    _gridView = gridView;
    gridView.hidden = NO;
    
}
#pragma mark ---Model
-(void)setPurchaseModel:(LZPurchaseModel *)purchaseModel {
    _purchaseModel = purchaseModel;
    _nameLanel.text = purchaseModel.productName;
    _needLabel.text =[NSString stringWithFormat:@"需求量：%@",purchaseModel.totalNumber];
    
    [_gridView reloData];
    
    purchaseModel.cellHeight = _gridView.bottom + 10;
}
#pragma mark ---Click
- (void)clickShow:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    _gridView.hidden = !sender.selected;
    _purchaseModel.isShow = !_gridView.hidden;
    !_clickShowBlock?:_clickShowBlock(sender.selected);
    
}
#pragma mark --- GridViewDelegate

///  有多少的row
- (NSInteger)numberOfRowInGridView:(GridView *)gridView {
    return (_purchaseModel.itemList.count+1)/2;
}
/// 具体每一个cell中的数据 row ==-1则表示标题
- (__kindof NSArray *)gridView:(GridView *)gridView cellForItemAtGridIndex:(GridIndex )gridIndex {
    
    if (gridIndex.row == -1) {
        return @[@"颜色",@"需求量",@"颜色",@"需求量"];
    }
    LZPurchaseItemListModel *item = _purchaseModel.itemList[gridIndex.row*2];
    LZPurchaseItemListModel *item1 = nil;
    if (_purchaseModel.itemList.count > gridIndex.row*2+1) {
        item1 =_purchaseModel.itemList[gridIndex.row*2+1];
    }
    
    
    return @[item.productColorName,item.number,HandleNilString(item1.productColorName),HandleNilString(item1.number)];
}

- (CGFloat)heightOfGridViewAtRow:(NSUInteger)row {
    if (row == -1) {
        return 40.f;
    }
    return 40.f;
}

#pragma mark --- GridViewDelegate
- (NSArray *)widthsOfGridView:(GridView *)gridView {
    return @[@0.25,@0.25,@0.25,@0.25];
}

@end
