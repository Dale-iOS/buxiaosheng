//
//  BYTakePhotoVideoTool.h
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger, BYTakePhotoVideoType) {
    BYTakePhotoVideoTypeForPhoto = 0,
    BYTakePhotoVideoTypeForVideo
};

@protocol BYTakePhotoVideoToolDelegate <NSObject>
@optional;
/// 点击拍照
- (void)didClickTakePhoto:(UIImage *)photo ;
/// 点击保存照片
- (void)didClickSavePhoto:(PHAsset *)asset;
/// 点击定制拍摄
- (void)didClickStopFilming:(NSURL *)videoUrl;
/// 点击开始拍摄开始计时
- (void)didClickStartFilming;
@end

@interface BYTakePhotoVideoTool : NSObject

- (instancetype)initWithSuperView:(UIView *)iSuperView
                             type:(BYTakePhotoVideoType )type;
/// 父类的视图 将会在最底层添加 layout
@property (nonatomic,strong,readonly)UIView *iSuperView;
/// 拍照／设想类型
@property (nonatomic,assign,readonly)BYTakePhotoVideoType type;
/// 代理
@property (nonatomic,weak)id <BYTakePhotoVideoToolDelegate>delegate;

/// 设备打开
- (void)startRunning;
/// 设备关闭
- (void)stopRunning;
/// 拍照
- (void)takePhoto;
/// 点击保存图片到相册
- (void)saveImage:(UIImage *)photo;
/// 开始拍摄
- (void)startFilming;
/// 停止拍摄
- (void)stopFilming;
/// 调焦
- (void)focusAtPoint:(CGPoint)point;

/// 更换设备的前后摄像头
- (void)changeDevicePosition;


@end
