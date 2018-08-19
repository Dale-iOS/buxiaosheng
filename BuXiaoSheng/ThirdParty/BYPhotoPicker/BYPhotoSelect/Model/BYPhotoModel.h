//
//  BYPhotoModel.h
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
// 这个模型将会贯穿拍照／拍摄／炫图／选视频／视频录制

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "BYPhotoTool.h"

typedef NS_ENUM(NSUInteger, BYPhotoModelType) {
    
    BYPhotoModelTypeImage = 0,
    BYPhotoModelTypeVideo,
};

@interface BYPhotoModel : NSObject
/// 图片／视频的PHAsset
@property (nonatomic,strong)PHAsset *asset;
/// 是否选中
@property (nonatomic,assign)BOOL isSelect;
/// 是add 添加按钮
@property (nonatomic,assign)BOOL isAdd;
/// 模型的唯一标示 (从asset中取得)
@property (nonatomic,strong,readonly)NSString *assetId;
/// 是add 添加按钮
@property (nonatomic,assign)BYPhotoModelType modelType;

/// 小的预览图片
@property (nonatomic,strong,readonly)UIImage *thumPhotoImage;
/// 原图
@property (nonatomic,strong)UIImage *originPhotoImage;
/// 用于发布的Data
@property (nonatomic,strong)NSData *imageData;
/// 图片的地址
@property (nonatomic,strong,readonly)NSString *photoFile;

@property (nonatomic,strong,readonly)NSURL *videoURL;
/// Asset的请求ID
@property (nonatomic,assign,readonly)PHImageRequestID requestID;
/// 视频的av
@property (nonatomic,strong,readonly)AVAsset *avAsset;;

/// 视频的时长 (6:12)
@property (nonatomic,strong,readonly)NSString *videoTimeStr;
/// 视频的时长 (100s)
@property (nonatomic,assign,readonly)NSUInteger videoTime;
 
/// 构造方法 1
- (instancetype)initWithAsset:(PHAsset *)asset;
/// 构造方法 2
- (instancetype)initWithVideoUrl:(NSURL *)videoURL;
/// 构造方法 3
- (instancetype)initWithAsset:(PHAsset *)asset
                   completion:(void(^)(void))completion;


- (void)loadThumImage:(void(^)(void))completeBlock;


@end
