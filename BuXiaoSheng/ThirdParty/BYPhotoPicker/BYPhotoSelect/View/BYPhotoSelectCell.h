//
//  BYPhotoSelectCell.h
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BYPhotoModel.h"

@interface BYPhotoSelectCell : UICollectionViewCell
@property (nonatomic,strong)BYPhotoModel *photoModel;
@property (copy,nonatomic)void (^clickSelectBlock)();
@end
