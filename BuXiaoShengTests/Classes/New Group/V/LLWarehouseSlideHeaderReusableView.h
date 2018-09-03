//
//  LLWarehouseSlideHeaderReusableView.h
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLWarehouseSideRigthSectionModel;
@interface LLWarehouseSlideHeaderReusableView : UICollectionReusableView
@property(nonatomic,strong)LLWarehouseSideRigthSectionModel *model;
@property(nonatomic,weak)UICollectionView *collectionView;

@end
