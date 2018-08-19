//
//  BYPhotoTool.h
//  JDemo
//
//  Created by BangYou on 2018/1/18.
//  Copyright © 2018年 BangYou. All rights reserved.
// 作为工具 的到相册／相片／phasset／phsset中的图片／phsset中的视频／phasset中的视频路径

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface BYPhotoTool : NSObject

#pragma mark - 图片类型
/// 得到预览图片 大小固定100*100 asy
+ (PHImageRequestID)getThumPhotoImageWithAsset:(PHAsset *)asset
                                    completion:(void(^)(UIImage *thumImage,NSDictionary *info))completion;
/// 得到原图图片 大小和原图一样 asy
+ (PHImageRequestID )getOriginPhotoImageWithAsset:(PHAsset *)asset
                                       completion:(void(^)(UIImage *originImage,NSDictionary *info))completion;



//+ (NSString *)getPhotoFileWithPHAsset:(PHAsset *)asset;
 
/// 得到视频的URL
+ (void) getVideoAVAssetWithPHAsset:(PHAsset *)pAsset
                         handleBack:(void(^)(AVAsset *asset,NSDictionary *info))complete;
/// 获取视频第一帧
+ (UIImage*) getVideoImageWithPHAsset:(NSURL *)videoURL;

/// 得到想要的尺寸的的预览图片 (只会的到一张图片 1334*750 勇于发布的)
+ (PHImageRequestID )getPhotoFromPHAsset:(PHAsset *)asset
                                    size:(CGSize )size
                              completion:(void(^)(UIImage *image,NSDictionary *info))completion;
#pragma mark - 视频类型




#pragma mark - Tool
/// 获取视频的时长
+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration;



@end
