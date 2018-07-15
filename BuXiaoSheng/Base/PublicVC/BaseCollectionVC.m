//
//  BaseCollectionVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseCollectionVC.h"

@interface BaseCollectionVC ()

@end

@implementation BaseCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page = 1;
}

-(NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)setColoctionBy:(UICollectionViewFlowLayout *)flowLayout {
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight - 64) collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    
    collection.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    collection.backgroundColor = [UIColor clearColor];
    collection.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    collection.delegate = self;
    collection.dataSource = self;
    _mainCollection = collection;
    
    
}

/// 子类必须重写的方法
#pragma marl - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
