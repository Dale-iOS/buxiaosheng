//
//  ColorDetailCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ReColorDetailCell.h"
#import "ReXiMaCollectionViewCell.h"

#define minimumInteritemSpacing 2
#define minimumLineSpacing 2


@implementation ReColorDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ReXiMaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ReXiMaCollectionViewCell"];
    //[self.collectionView setBackgroundColor:[UIColor clearColor]];
    self.collectionView.scrollEnabled = NO;
    
}

- (void)setColorListModel:(LZPurchaseReceivingListDetailProductColorListModel *)colorListModel
{
    _colorListModel = colorListModel;
    _productColorNameLabel.text = colorListModel.productColorName;
    _unitNameLabel.text = colorListModel.unitName;
    _priceLabel.text = colorListModel.price;
    _totalLabel.text = colorListModel.total;
    _valList = colorListModel.valList;
    [self.collectionView reloadData];
}


#pragma mark Collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rtn = _valList.count;
    return rtn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"ReXiMaCollectionViewCell";
    ReXiMaCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.valListModel = _valList[indexPath.row];
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width)/5;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
