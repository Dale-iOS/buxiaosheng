//
//  LLAddNewsPeopleSectionView.h
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//
@class LLAddNewsPeopleSectionView;
typedef void(^NewsPeopleSectionViewBlock)(LLAddNewsPeopleSectionView * sectionView);
@class LLAddNewPeoleRoleModel;
#import <UIKit/UIKit.h>

@interface LLAddNewsPeopleSectionView : UITableViewHeaderFooterView
@property (nonatomic,strong) LLAddNewPeoleRoleModel * model;
@property (nonatomic,copy) NewsPeopleSectionViewBlock block;
@end
