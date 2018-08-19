//
//  BYPhotoAddView.h
//  JDemo
//
//  Created by BangYou on 2018/1/22.
//  Copyright © 2018年 BangYou. All rights reserved.
// 添加视频／图片，并展示结果

#import <UIKit/UIKit.h>
#import "BYPhotoModel.h"

#define CellMargin  10.0f
@protocol BYPhotoAddViewDelegate <NSObject>
@optional;
- (void)clickAddButton;
- (void)clickSubviewAtIndex:(NSUInteger)index;
- (void)didDelectPhotoModel;

@end


@interface BYPhotoAddView : UIView

/// 最多能选择几张（视频只能一个，图片默认4个，最大9个这个是需求。）
@property (nonatomic,assign)NSUInteger maxCount;
@property (nonatomic,assign)NSUInteger maxVideoCount;
///// subview的边距 (默认15.0f)
//@property (nonatomic,assign)CGFloat edge;
/// 选中的模型（也可能是拍照／拍摄）
@property (nonatomic,strong)NSMutableArray <BYPhotoModel *>*photoModelArray;
/// 代理
@property (nonatomic,weak)id <BYPhotoAddViewDelegate>delegate;
/// 是否包含+号按钮
@property (nonatomic,assign,readonly)BOOL isHadAddIcon;
/// 选择的类型
@property (nonatomic,assign,readonly)BYPhotoModelType selectType;
/// 刷新UI
- (void)reloadData;
/// 只是刷新colloctView 不会添加add按钮
- (void)reloadCollction;
@end





@interface BYPhotoAddViewCell : UICollectionViewCell
@property (nonatomic,strong)BYPhotoModel *photoModel;
@property (copy,nonatomic)void (^clickCloseBlock)(void);


@end


