//
//  BXSMachiningDBCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSMachiningDBCell.h"
#import "GridTableView.h"
#import "UIButton+EdgeInsets.h"
#import "CellView.h"
#import "LZOutboundModel.h"
@interface BXSMachiningDBCell ()<GridDataSource,GridDelegate>

@end

@implementation BXSMachiningDBCell
{
    GridTableView *_gridView;
    NSInteger _col;
   
    CellView *_nameCell;
     CellView *_colorCell;
    
    
    UILabel *_allKc;
    UILabel *_allCk;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setup {
    
    LineView *topL = [LineView lineViewOfHeight:10];
    [self.contentView addSubview:topL];
    
    self.selectionStyle = 0;
    //_addLabel
    UILabel *addLabel = [[UILabel alloc]init];
    addLabel.text = @"添加底步1";
    addLabel.textColor = CD_textCC;
    [self.contentView addSubview:addLabel];
    addLabel.frame = CGRectMake(15, topL.bottom, 120, 30);
    _addLabel = addLabel;
    addLabel.font = FONT(14);
    
    //delectButton
    UIButton *delectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:delectButton];
    [delectButton setTitle:@"删除" forState:UIControlStateNormal];
    [delectButton setImage:IMAGE(@"deleteGray") forState:UIControlStateNormal];
    delectButton.titleLabel.font = FONT(14);
    [delectButton setTitleColor:CD_textCC forState:UIControlStateNormal];
    delectButton.frame = CGRectMake(APPWidth -70, addLabel.top, 60, addLabel.height);
    [delectButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageRight imageTitlespace:5];
    [self.contentView addSubview:delectButton];
    [delectButton addTarget:self action:@selector(clickDelectDB) forControlEvents:UIControlEventTouchUpInside];
    
  //_nameCell
    WEAKSELF;
    ConItem *item = [[ConItem alloc]initWithTitle:@"品名" kpText:@"请选择品名" conType:ConTypeA];
    _nameCell = [[CellView alloc]initWithFrame:CGRectMake(0, addLabel.bottom+5, APPWidth, 49) item:item];
    _nameCell.clickCellBlock = ^{
        [weakSelf clickNameCell];
    };
    [self.contentView addSubview:_nameCell];
    
    LineView *line1 = [LineView lineViewOfHeight:1];
    line1.top = _nameCell.bottom;
    
    //_colorCell
    ConItem *item1 = [[ConItem alloc]initWithTitle:@"颜色" kpText:@"请选择颜色" conType:ConTypeA];
    _colorCell = [[CellView alloc]initWithFrame:CGRectMake(0, _nameCell.bottom+1, APPWidth, 49) item:item1];
    _colorCell.clickCellBlock = ^{
        [weakSelf clickColorCell];
    };
    [self.contentView addSubview:_colorCell];
    
    
    _col = 0;
    GridTableView *gridView = [[GridTableView alloc]initWithCol:5];
    _gridView = gridView;
    gridView.frame = CGRectMake(0, _colorCell.bottom, APPWidth, 50);
    [gridView setDelegate:self dataSouce:self];
    gridView.headLineColor = [UIColor whiteColor];
    [gridView setHeadTitleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:15]];
    [gridView setCellTextColor:CD_Text99 titleFont:FONT(14)];
    [gridView setHeadBackColor:LZHBackgroundColor CellColor:[UIColor whiteColor]];
    
    [self.contentView addSubview:gridView];
    [gridView reloData];
    
    // 添加仓库
    UIButton *addCkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addCkBtn addTarget:self action:@selector(addCKClick) forControlEvents:UIControlEventTouchUpInside];
    [gridView addSubview:addCkBtn];
    [addCkBtn setImage:IMAGE(@"dyeing_add") forState:UIControlStateNormal];
    [addCkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gridView);
        make.right.equalTo(gridView).offset(0);
        make.width.mas_offset(APPWidth *0.2);
        make.height.mas_offset(40);
    }];
    
    //_allKc
    _allKc = [[UILabel alloc]init];
    _allKc.text = @"总库存数:0";
    _allKc.textColor = CD_textCC;
    [self.contentView addSubview:_allKc];
    _allKc.font = FONT(14);
    [_allKc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(0.5);
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_offset(20);
    }];
    
    //_allCk
    _allCk = [[UILabel alloc]init];
    _allCk.text = @"总出存数:0";
    _allCk.textColor = CD_textCC;
    [self.contentView addSubview:_allCk];
    _allCk.font = FONT(14);
    [_allCk mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).multipliedBy(1.5);
        make.bottom.equalTo(self).offset(-5);
        make.height.mas_offset(20);
    }];
    
}
#pragma mark --- Model
-(void)setModel:(BXSDSModel *)model {
    _model = model;
    _col = model.boundModelList.count;
    _colorCell.midTF.text = model.productColorName;
    _nameCell.midTF.text = model.productName;
    [_gridView reloData];
    _model.cellHeight = _gridView.bottom+30;
    
    // 出库和库存总数
    NSArray*alld = [model.boundModelList valueForKey:@"number"];
    model.total = [NSString stringWithFormat:@"%@",[alld valueForKeyPath:@"@sum.integerValue"]];
    _allKc.text = [NSString stringWithFormat:@"总库存数:%@",model.total];
    
    NSArray*allc = [model.boundModelList valueForKey:@"total"];
    model.ckTotal = [NSString stringWithFormat:@"%@",[allc valueForKeyPath:@"@sum.integerValue"]];
    _allCk.text = [NSString stringWithFormat:@"总出库数:%@",model.ckTotal];
}


#pragma mark --- Click
/// 删除底色
- (void)clickDelectDB {
    !_clickDelectDBBlock?:_clickDelectDBBlock();
}
/// 选择名字
- (void)clickNameCell {
       !_clickNameCellBlock?:_clickNameCellBlock();
}
/// 选择颜色
- (void)clickColorCell {
       !_clickColorCellBlock?:_clickColorCellBlock();
}
/// 添加仓库
- (void)addCKClick {
       !_addCKClickBlock?:_addCKClickBlock();
}
#pragma mark --- GridViewDelegate

///  有多少的row
- (NSInteger)numberOfRowInGridView:(id <GridViewDelegate>)gridView {
    return _model.boundModelList.count;
}
/// 具体每一个cell中的数据 row ==-1则表示标题
- (__kindof NSArray *)gridView:(id<GridViewDelegate>)gridView cellForItemAtGridIndex:(GridIndex )gridIndex {
    
    if (gridIndex.row == -1) {
        return @[@"库存数",@"出库数",@"条数",@"出仓库",@""];
    }
    LLOutboundRightModel *kModel = _model.boundModelList[gridIndex.row];
    
    return @[HandleNilString(kModel.number),
             HandleNilString(kModel.total),//有问题
             HandleNilString(kModel.total),
             HandleNilString(kModel.leftModel.houseName)];
}

- (CGFloat)heightOfGridViewAtRow:(NSUInteger)row {
    if (row == -1) {
        return 40.f;
    }
    return 30.f;
}

#pragma mark --- GridViewDelegate
- (NSArray *)widthsOfGridView:(id <GridViewDelegate>)gridView {
    return @[@0.2,@0.2,@0.2,@0.2,@0.2];
}
 
/// 点击cell的删除
- (void)didClickCellDelectAtRow:(NSInteger)row {
    
    LLOutboundRightModel *kModel = _model.boundModelList[row-1];
    NSMutableArray *array = [NSMutableArray arrayWithArray:_model.boundModelList];
    if ([array containsObject:kModel]) {
        [array removeObject:kModel];
    }
    _model.boundModelList = [array mutableCopy];
    !_clickDelectAKcBlock?:_clickDelectAKcBlock();
}
@end
