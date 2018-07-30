//
//  BXSAllCodeCell.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 总吗cell 

#import "BXSAllCodeCell.h"
#import "ConCell.h"
#import "LLDyeingCollectionViewCell.h"
#import "BXSAddFindCodeView.h"

@interface BXSAllCodeCell ()<BXSAddFindCodeViewDelegate>


@end

@implementation BXSAllCodeCell
{
    
    
    UIView *_headerView;
    
    
    UILabel *_nameLabel;
    UILabel *_colorLabel;
    UILabel *_unitLabel;
    UILabel *_needCountLabel;
    UILabel *_findCodeLabel;
    
    BXSAddFindCodeView *_findCodeView;
    
    
    UITableView *_tableView;
    
    UIButton *_bottomView;
    
    BOOL _isFindCode;
    
    
}
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//
//    }
//    return self;
//}


-(void)setup {
    
   NSString*cellID = self.reuseIdentifier;
    [self setupHeader];
    if (![cellID isEqualToString:NSStringFromClass([self class])]) {
        _isFindCode = YES;
        [self setupCollection];
    }
    [self setupTable];
    [self setupBottom];
     
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void) setupHeader {
    _headerView = [UIView new];
    [self.contentView addSubview:_headerView];
    // h = 80
    //_nameLabel
    _nameLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    _nameLabel.frame = CGRectMake(kMarinLeft, kMarginTop, APPWidth/2 - kMarinLeft, 20);
    [_headerView addSubview:_nameLabel];
    _nameLabel.text = @"品名：品名一";
    
    //_colorLabel
    _colorLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    _colorLabel.frame = CGRectMake(APPWidth/2, _nameLabel.top, APPWidth/2 - kMarinLeft, 20);
    [_headerView addSubview:_colorLabel];
    _colorLabel.text = @"品名颜色：#3红色";
    
    //_unitLabel
    _unitLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    _unitLabel.frame = CGRectMake(kMarinLeft, _nameLabel.bottom+kMarginTop, APPWidth/2 - kMarinLeft, 20);
    [_headerView addSubview:_unitLabel];
    _unitLabel.text = @"单位：公里";
    
    //_needCountLabel
    _needCountLabel = [UILabel labelWithColor:Text33 font:FONT(14)];
    _needCountLabel.frame = CGRectMake(APPWidth/2, _unitLabel.top, APPWidth/2 - kMarinLeft, 20);
    [_headerView addSubview:_needCountLabel];
    _needCountLabel.text = @"需求量：99";
    
    _headerView.frame = CGRectMake(0, 0, APPWidth, _needCountLabel.bottom +10);
    
    //line
    LineView *line = [LineView lineViewOfHeight:1];
    line.top = _headerView.height - 1;
    [_headerView addSubview:line];
}

/// _findCodeView
- (void)setupCollection {
    
    _findCodeView = [[BXSAddFindCodeView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, APPWidth, 50)];
    _findCodeView.delegate = self;
    [self.contentView addSubview:_findCodeView];
    
}

- (void) setupTable {
    
    // h =  12* 50 + 20
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _headerView.bottom, APPWidth, _isFindCode?520:620) style:UITableViewStylePlain];
    [self.contentView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource  = self;
    _tableView.separatorColor = LZHBackgroundColor;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.rowHeight = 50.f;
    [_tableView registerClass:[ConCell class] forCellReuseIdentifier:[ConCell cellID]];
    
}

- (void) setupBottom {
    
    _bottomView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView setImage:IMAGE(@"dyeing_show") forState:UIControlStateNormal];
    [_bottomView setImage:IMAGE(@"dyeing_close") forState:UIControlStateSelected];
    [_bottomView addTarget:self action:@selector(clickBottom) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_bottomView];
    _bottomView.frame = CGRectMake(0, _tableView.bottom, APPWidth, 40);
}



#pragma mark --- SET Model ----
-(void)setItem:(BXSAllCodeModel *)item {
    _item = item;
 
    
    _item.baseCellHeight = _item.select ? 120:740;
    _bottomView.selected = _item.select;
    _colorLabel.text = [NSString stringWithFormat:@"品名颜色：%@",item.productColorName];
    _needCountLabel.text = [NSString stringWithFormat:@"需求量：%@",item.number];
    _tableView.height = _item.select ? 0.1:620;
    _tableView.hidden = _item.select;
   
    // 通过细码的数据得到高度
    _findCodeView.codeArray = item.findCodeArray;
    if (_isFindCode) {
        _findCodeView.height = _item.select ? 0.1:_findCodeView.height;
        _tableView.top = _findCodeView.bottom;
        _tableView.height = _item.select ? 0.1:510;
        _item.baseCellHeight = _item.select ? 120:640+_findCodeView.height;
        _findCodeView.hidden =  _item.select;
    }
     _bottomView.top = _tableView.bottom;
    // allcount
    
    [_tableView reloadData];
}

-(void)setName:(NSString *)name unit:(NSString *)unit {
    _nameLabel.text = name;
    _unitLabel.text = unit;
    
}
#pragma mark --- CLICK
- (void)clickBottom {
    
    _item.select =  !_item.select;

    !_clickBottomBlock?:_clickBottomBlock();
    
}


#pragma mark --- BXSAddFindCodeViewDelegate ----
- (void)didClickAddCode {
 
    !_clickAddCodelBlock?:_clickAddCodelBlock(_item);
}
- (void)didClickChangeCode:(LZFindCodeModel *)model {
       !_clickChangeCodeBlock?:_clickChangeCodeBlock(model);
}

#pragma mark --- table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return  _item.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr =  _item.dataArray[section];
    if (_isFindCode && section == 0) {
        return 2;
    }
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ConItem *item =  _item.dataArray[indexPath.section][indexPath.row];
    if (_isFindCode && indexPath.section == 0) {
       item = _item.dataArray[indexPath.section][indexPath.row + 2];
    }
    
    ConCell *cell = [tableView dequeueReusableCellWithIdentifier:[ConCell cellID]];
    cell.item = item;
    WEAKSELF
    cell.endEdtingBlock = ^(ConItem *kItem) {
        if (kItem == weakSelf.item.dataArray[0][0]) {
            ConItem *citem = weakSelf.item.dataArray[1][4];
            ConItem *kuItem = weakSelf.item.dataArray[1][5];
            ConItem *jItem = weakSelf.item.dataArray[1][6];
            citem.kpText = kuItem.contenText = jItem.contenText = kItem.contenText;
            
        }
        
        !weakSelf.endEdtingBlock?:weakSelf.endEdtingBlock();
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        ConItem *item =  _item.dataArray[indexPath.section][indexPath.row];
        if (_isFindCode && indexPath.section == 0) {
            item = _item.dataArray[indexPath.section][indexPath.row + 2];
        }
        !_clickUnitBlock?:_clickUnitBlock(item);
    }
    
    if (_isFindCode &&  indexPath.section == 1 && indexPath.row == 5) {
        !_clickChangeRkBlock?:_clickChangeRkBlock();
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return [LineView lineViewOfHeight:10];
    }
    return [UIView new];
}




-(void)layoutSubviews {
    
    
}


 
@end
