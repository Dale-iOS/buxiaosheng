//
//  BYPhotoTool.m
//  JDemo
//
//  Created by BangYou on 2018/1/18.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYPhotoTool.h"

@implementation BYPhotoTool

/// 得到预览图片 大小固定100*100 asy
+ (PHImageRequestID)getThumPhotoImageWithAsset:(PHAsset *)asset
                                    completion:(void(^)(UIImage *thumImage,NSDictionary *info))completion {
    PHImageRequestID requestID = -1;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.synchronous = YES;
    //只会的到一张图片
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    requestID =  [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completion &&result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result,info);
            });
        }
    }];
    
    return requestID;
}
/// 得到原图图片 大小和原图一样 asy
+ (PHImageRequestID )getOriginPhotoImageWithAsset:(PHAsset *)asset
                                       completion:(void(^)(UIImage *originImage,NSDictionary *info))completion {
    
    PHImageRequestID requestID = -1;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.synchronous = YES;
    //只会的到一张图片
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[PHImageManager defaultManager]requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion([UIImage imageWithData:imageData],info);
            });
            
        }];
    });
    return requestID;
}



/// 得到图片
+ (void )getPhotoImageWithPHAsset:(PHAsset *)asset
                       handleBack:(void(^)(NSData *imageData,NSString *imageFile))complete {
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = YES;
    
    
    [[PHImageManager defaultManager] requestImageDataForAsset:asset
                                                      options:options
                                                resultHandler:
     ^(NSData *imageData,
       NSString *dataUTI,
       UIImageOrientation orientation,
       NSDictionary *info) {
         
         complete(imageData,[info valueForKey:@"PHImageFileURLKey"]);
     }];
}
/// 从phsset中得到URL
+ (void) getVideoAVAssetWithPHAsset:(PHAsset *)pAsset handleBack:(void(^)(AVAsset *asset,NSDictionary *info))complete{
    
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc]init];
    options.version = PHVideoRequestOptionsDeliveryModeAutomatic;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    [[PHImageManager defaultManager] requestAVAssetForVideo:pAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_main_queue(), ^{
           complete(asset,info);
        });
        
    }];
}


/// 获取视频第一帧
+ (UIImage*) getVideoImageWithPHAsset:(NSURL *)videoURL;
{
    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
    assetGen.appliesPreferredTrackTransform = YES;
   
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}


/// 得到想要的尺寸的的预览图片 1334*750（勇用于上传到后台的，大小建议在2M以内）
+ (PHImageRequestID )getPhotoFromPHAsset:(PHAsset *)asset
                                    size:(CGSize )size
                              completion:(void(^)(UIImage *image,NSDictionary *info))completion  {
    
    
    PHImageRequestID requestID = -1;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.synchronous = YES;
    //只会的到一张图片
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    requestID =  [[PHImageManager defaultManager]requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (completion &&result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(result,info);
            });
        }
    }];
    
    return requestID;
}





#pragma mark - Tool
/// 获取视频的时长
+ (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    
    NSString *newTime;
    if (duration < 10) {
        newTime = [NSString stringWithFormat:@"00:0%zd",duration];
    } else if (duration < 60) {
        newTime = [NSString stringWithFormat:@"00:%zd",duration];
    } else {
        NSInteger min = duration / 60;
        NSInteger sec = duration - (min * 60);
        if (sec < 10) {
            newTime = [NSString stringWithFormat:@"%zd:0%zd",min,sec];
        } else {
            newTime = [NSString stringWithFormat:@"%zd:%zd",min,sec];
        }
    }
    return newTime;
}


@end

