//
//  BYPhotoSelectPreveiwVC.h
//  JDemo
//
//  Created by BangYou on 2018/1/19.
//  Copyright © 2018年 BangYou. All rights reserved.
// 查看选中的图片

 
#import "BaseCollectionVC.h"
@class BYPhotoModel;
@interface BYPhotoSelectPreveiwVC : BaseCollectionVC

@property (nonatomic,assign)NSUInteger index;
- (instancetype)initWithPhotos:(NSArray<BYPhotoModel*>*) selectPhotos
        atIndex:(NSUInteger)atIdnex;

- (instancetype)initWithPhoto:(BYPhotoModel *)photo;

@end



@interface BYPhotoSelectPreveiwCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *imageView;
@end
