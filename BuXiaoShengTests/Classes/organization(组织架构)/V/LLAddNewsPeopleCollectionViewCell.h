//
//  LLAddNewsPeopleCollectionViewCell.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLAddNewPeoleRoleModel;
@class LLAddNewsPeopleCollectionViewCell;
typedef void(^AddNewsPeopleCollectionViewCellBlock)(LLAddNewsPeopleCollectionViewCell * cell);
#import <UIKit/UIKit.h>

@interface LLAddNewsPeopleCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) LLAddNewPeoleRoleModel * model;
@property (nonatomic,copy) AddNewsPeopleCollectionViewCellBlock  block;
@end
