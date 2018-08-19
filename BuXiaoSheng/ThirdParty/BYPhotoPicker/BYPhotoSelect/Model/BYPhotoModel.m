//
//  BYPhotoModel.m
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYPhotoModel.h"
@class BYPhotoTool;
@interface BYPhotoModel ()

@property (copy,nonatomic)void (^completion)(void);
@end;
@implementation BYPhotoModel

/// 构造方法
- (instancetype)initWithAsset:(PHAsset *)asset {
    
    
    if (self = [super init]) {
        _asset = asset;
        _assetId = asset.localIdentifier;
        _requestID = -1;
        if (asset.mediaType == PHAssetMediaTypeImage) {
           _modelType = BYPhotoModelTypeImage;

        }else if (asset.mediaType == PHAssetMediaTypeVideo){
           _modelType = BYPhotoModelTypeVideo;
           
        }
    }
    return self;
}

/// 构造方法 2
- (instancetype)initWithVideoUrl:(NSURL *)videoURL {
   
    if (self = [super init]) {
        _modelType = BYPhotoModelTypeVideo;
        
        _videoURL = videoURL;
        AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:videoURL options:nil];
        // 计算时长
        _videoTime = CMTimeGetSeconds(asset.duration);
        _videoTimeStr = [BYPhotoTool getNewTimeFromDurationSecond:_videoTime];
        _thumPhotoImage = [BYPhotoTool getVideoImageWithPHAsset:videoURL];
    }
    return self;
}

/// 构造方法 3
- (instancetype)initWithAsset:(PHAsset *)asset
                   completion:(void(^)(void))completion {
    if (self = [[super init]initWithAsset:asset]) {
        _completion = completion;
    }
    
    return self;
}
- (UIImage *)getThumImageFromData:(NSData *)imageData {
    UIImage *bigImg = [UIImage imageWithData:imageData];
    
    //控制大小
    CGFloat scale = 1.0f;
    if (bigImg.size.width >40) {
        scale = 100.0/bigImg.size.width;
    }
    NSData *data = UIImageJPEGRepresentation(bigImg, scale);
    UIImage *thuImage =  [UIImage imageWithData:data scale:1];
    return thuImage;
    
}

- (void)loadThumImage:(void(^)(void))completeBlock{
    
    
    if (_requestID != -1) {
         completeBlock();
        return;
    }
    _requestID = [BYPhotoTool getThumPhotoImageWithAsset:_asset completion:^(UIImage *thumImage, NSDictionary *info) {
        _thumPhotoImage = thumImage;
        _photoFile = [info valueForKey:@"PHImageFileURLKey"];
        completeBlock();
    }];
    
      if (_asset.mediaType == PHAssetMediaTypeVideo) {
          dispatch_async(dispatch_get_global_queue(0, 0), ^{
                  [BYPhotoTool getVideoAVAssetWithPHAsset:_asset handleBack:^(AVAsset *asset, NSDictionary *info) {
                      NSString *TokenKey = [info valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
                      NSArray *strArray = [TokenKey componentsSeparatedByString:@";"];
                      if (strArray.count > 0) {
                          NSString *urlPath = [strArray lastObject];
                          _videoURL = [NSURL fileURLWithPath:urlPath];
                          _avAsset = asset;
                      }
                      // 计算时长
                      _videoTime = CMTimeGetSeconds(asset.duration);
                      _videoTimeStr = [BYPhotoTool getNewTimeFromDurationSecond:_videoTime];
                      completeBlock();
                  }];
              });
      }
}

@end
