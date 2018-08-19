//
//  BYPhotoSelect.h
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionVC.h"
#import "BYCameraViewController.h"
#import "BYPhotoSelectPreveiwVC.h"
#import "BYPhotoAddView.h"
//#import "BYVideoPreviewVC.h"

typedef NS_ENUM(NSUInteger,BYSendDyType){
     BYSendDyTypeNone = 0,
    BYSendDyTypeImage ,
    BYSendDyTypeVideo,
    BYSendDyTypeSelect,
};


@class BYPhotoModel;
@protocol BYPhotoSelectDelegate <NSObject>
- (void)didSelectPhotoModel:(NSArray <BYPhotoModel *>*)phtotoArray;
- (void)didSelectVideoModel:(BYPhotoModel *)videoModel;

@end

@class BYPhotoSelectConfig;

@interface BYPhotoSelect : BaseCollectionVC
/// 已经选择的model (从外部传进来的)
@property (nonatomic,strong)NSArray <BYPhotoModel *>*selectPhotos;
/// 最大的图片张数,0表示不能选择图片（默认4）
@property (nonatomic,assign)NSUInteger maxPhotoCount;
/// 最大的视频个数,0表示不能选择视频（默认1）
@property (nonatomic,assign)NSUInteger maxVideoCount;
/// 最大的视频时间 (默认60s)
@property (nonatomic,assign)NSUInteger videoMaxTime;
/// 是否能选择视频（默认是能选择一个视频）
@property (nonatomic,assign)BOOL canSelectVideo;
/// 代理
@property (nonatomic,weak)id <BYPhotoSelectDelegate>delegate;
/// 3.3.2 多个视频的选择
@property (nonatomic,assign)BOOL onlySelectVideo;

//// 3.4.2 优化成配置驱动方式
@property (nonatomic,strong,readonly)BYPhotoSelectConfig *config;

#pragma mark - 构造方法
- (instancetype)initWithConfig:(BYPhotoSelectConfig *)config;

@end


///配置类
@interface BYPhotoSelectConfig : NSObject

/// 最大的图片张数,0表示不能选择图片（默认4）
@property (nonatomic,assign)NSUInteger maxPhotoCount;
/// 最大的视频个数,0表示不能选择视频（默认1）
@property (nonatomic,assign)NSUInteger maxVideoCount;
/// 最大的视频时间 (默认60s)
@property (nonatomic,assign)NSUInteger videoMaxTime;

/// 是否能选择视频（默认是能选择一个视频）
@property (nonatomic,assign)BOOL canSelectVideo;

#pragma mark - 构造方法
/** 得到配置对象*/
- (instancetype)initWithMaxPhoto:(NSUInteger)maxPhoto
                        maxVideo:(NSUInteger)maxVideo;
/** 得到配置对象*/
- (instancetype)initWithMaxPhoto:(NSUInteger)maxPhoto
                        maxVideo:(NSUInteger)maxVideo
                    maxVideoTime:(NSUInteger)maxTime;

@end

