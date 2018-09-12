//
//  PurchaseDetailCell.m
//  BuXiaoSheng
//
//  Created by 王猛 on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "JGPurchaseDetailCell.h"
#define minimumInteritemSpacing 2
#define minimumLineSpacing 2
@implementation JGPurchaseDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.myCollectionView.collectionViewLayout = flowLayout;
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"JGPurchaseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JGPurchaseCollectionViewCell"];
    [self.myCollectionView setBackgroundColor:[UIColor clearColor]];
    self.myCollectionView.scrollEnabled = NO;
}


- (void)setDetailModel:(LZPurchasingInfoDetailModel *)detailModel
{
    _detailModel = detailModel;
    _productNameLB.text = [NSString stringWithFormat:@"品名：%@",detailModel.productName];
    _totalNumberLB.text = [NSString stringWithFormat:@"需求量：%@",detailModel.totalNumber];
    _itemList = detailModel.itemList;
    if (app.isSelected) {
        _backView.hidden = NO;
        _collectionViewHConstraint.constant = 50 + ceil(_itemList.count/2.0)*28;
        [self.myCollectionView reloadData];
    }else
    {
        _backView.hidden = YES;
        _collectionViewHConstraint.constant = 0;
    }
    
}



#pragma mark -- 点击收起、展开
- (IBAction)clickBtn:(UIButton *)sender {
    
    sender.selected = !app.isSelected;
    app.isSelected = !app.isSelected;
    if ([self.delegate respondsToSelector:@selector(refreshCell:)]) {
        [self.delegate refreshCell:self.indexPath];
    }
    
}


#pragma mark Collection datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger rtn = _itemList.count;
    return rtn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"JGPurchaseCollectionViewCell";
    JGPurchaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.itemModel = _itemList[indexPath.row];
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.frame.size.width;
    return CGSizeMake(width, 60);
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
    
    
}

@end
