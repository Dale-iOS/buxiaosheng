//
//  CellImageCollVi.h
//  UICollectionViewss
//
//  Created by 幸福的尾巴 on 2018/8/30.
//  Copyright © 2018年 幸福的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellImageCollVi : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

@end
