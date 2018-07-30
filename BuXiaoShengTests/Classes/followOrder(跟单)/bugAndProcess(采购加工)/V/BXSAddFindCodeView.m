//
//  BXSAddFindCodeView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/22.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
// 添加展示细码的cell

#import "BXSAddFindCodeView.h"
#import "LLDyeingCollectionViewCell.h"

#define COLLECTIONH 30.0
@interface BXSAddFindCodeView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation BXSAddFindCodeView
{
    UIView * _headView;
    UILabel *_findCodeLabel;
    
    UICollectionView *_collectionView;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    //header
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 50)];
    [self addSubview:_headView];
   _findCodeLabel = [UILabel new];
    _findCodeLabel.textColor = [UIColor blackColor];
    _findCodeLabel.font = FONT(14.0);
    _findCodeLabel.frame = CGRectMake(15, 0, 180, 50);
    [_headView addSubview:_findCodeLabel];
 
    
   
    UIButton*addBtn = [UIButton new];
    [_headView addSubview:addBtn];
    [addBtn setImage:[UIImage imageNamed:@"dyeing_add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(clickAddCode) forControlEvents:UIControlEventTouchUpInside];
    addBtn.frame = CGRectMake(APPWidth - 40, 0, 25, _headView.height);
 
    
    
    //_collectionView
    NSUInteger col = 4;
    CGFloat margin = 0;
    UICollectionViewFlowLayout *layout =[UICollectionViewFlowLayout new];
    layout.itemSize =  CGSizeMake((APPWidth - (col+1)*margin)/col, COLLECTIONH
                                  );
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = margin;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _headView.bottom, APPWidth, 0.1) collectionViewLayout:layout];
    [_collectionView registerClass:[LLDyeingCollectionViewCell class] forCellWithReuseIdentifier:[LLDyeingCollectionViewCell cellID]];
    

    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
}
// 0x600001025900 0x604000c58840
-(void)setCodeArray:(NSMutableArray *)codeArray {
    
    _codeArray = codeArray;
    
    _findCodeLabel.text = [NSString stringWithFormat:@"细码(总条数:%ld)",codeArray.count];
    BOOL add1 = (codeArray.count%4 == 0);
    CGFloat collectionH = (codeArray.count/4 + (add1?0:1) ) *COLLECTIONH;
    _collectionView.frame = CGRectMake(0, 50, APPWidth, collectionH);
    self.height = 50 + collectionH ;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
   
    [_collectionView reloadData];

}
#pragma marl ---- CLICK ---

- (void)clickAddCode {
 
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickAddCode)]) {
        [_delegate didClickAddCode];
    }
}
#pragma marl ---- UICollectionView ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.codeArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    LLDyeingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[LLDyeingCollectionViewCell cellID] forIndexPath:indexPath];
    
    LZFindCodeModel *model = self.codeArray[indexPath.row];
    cell.codeModel = model;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LZFindCodeModel *model = self.codeArray[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeCode:)]) {
        [_delegate didClickChangeCode:model];
    }
}

@end
