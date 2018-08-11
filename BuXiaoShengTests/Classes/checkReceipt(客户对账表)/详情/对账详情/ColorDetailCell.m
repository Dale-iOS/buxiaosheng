//
//  ColorDetailCell.m
//  对账详情
//
//  Created by 王猛 on 2018/8/8.
//  Copyright © 2018年 WM. All rights reserved.
//

#import "ColorDetailCell.h"
#import "XiMaCollectionViewCell.h"

#define minimumInteritemSpacing 2
#define minimumLineSpacing 2


@implementation ColorDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView setBackgroundColor:[UIColor yellowColor]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XiMaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"XiMaCollectionViewCell"];
    
    self.collectionView.scrollEnabled = NO;
    
}

- (void)showData:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    _productColorNameLabel = dataDic[@"productColorName"];
    _unitNameLabel = dataDic[@"unitName"];
    _priceLabel = dataDic[@"price"];
    _totalLabel = dataDic[@"total"];
    _valList = dataDic[@"valList"];
}

#pragma mark Collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rtn = 25;
    return rtn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"XiMaCollectionViewCell";
    XiMaCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
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
