//
//  ColorDetailCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReimColorDetailCell.h"
#import "ReimXiMaCollectionViewCell.h"

#define minimumInteritemSpacing 0
#define minimumLineSpacing 0


@implementation ReimColorDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView setBackgroundColor:[UIColor yellowColor]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ReimXiMaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReimXiMaCollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.scrollEnabled = NO;
    
}

- (void)setColorListModel:(LZBackOrderDetialProductColorListModel *)colorListModel{
    _colorListModel = colorListModel;
    self.total.text =  colorListModel.total;//条数
    self.price.text =  colorListModel.price;//单价
    self.unitName.text = colorListModel.unitName;//单位
    self.productColorName.text = colorListModel.productColorName;//产品名字
}

#pragma mark Collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _colorListModel.valList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"ReimXiMaCollectionViewCell";
    ReimXiMaCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.valListModel = _colorListModel.valList[indexPath.row];
//    NSLog(@"132");
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width - (5-1)*minimumInteritemSpacing)/5;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return minimumInteritemSpacing;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
