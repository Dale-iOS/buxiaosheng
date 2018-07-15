//
//  BaseCollectionVC.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseViewController.h"

static CGFloat marginInset = 15.0f;

@interface BaseCollectionVC : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/// 主要的mainCollection
@property (nonatomic,strong)UICollectionView *mainCollection;
/// 数据源
@property (nonatomic,strong)NSMutableArray *dataSource;
// 第几页的数据
@property (nonatomic,assign)NSInteger page;



- (void)setColoctionBy:(UICollectionViewFlowLayout *)flowLayout;
/// 子类必须重写的方法
#pragma marl - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
