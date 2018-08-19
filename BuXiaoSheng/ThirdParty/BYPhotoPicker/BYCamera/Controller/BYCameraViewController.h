//
//  BYCameraViewController.h
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSUInteger,BYCameraViewType) {
    /// 拍照
    BYCameraViewTypeTakePhoto = 0,
    /// 摄像
    BYCameraViewTypeFilmingVideo,
};

@interface BYCameraViewController : UIViewController
 @property (nonatomic,assign)BYCameraViewType CameraType;

@property (nonatomic,copy) void(^completionHandler)(PHAsset *);
@property (nonatomic,copy) void(^completionVideoHandler)(NSURL *url);

@end
