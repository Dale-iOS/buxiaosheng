//
//  BYCameraBottomTool.h
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

// h=70

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,BYCameraStateType) {
    BYCameraStateTypeBeginTakePhoto = 0,
    BYCameraStateTypeCompleteTakePhoto,
    
    BYCameraStateTypeBeginFilming,
    BYCameraStateTypeInFilminging,
    BYCameraStateTypeCompleteFilming,
};


@protocol BYCameraBottomToolDelegate <NSObject>

/// 点击取消
- (void)didClickCancle;
/// 点击切换镜头
- (void)didClickChangeCamera;
/// 点击保存图片
- (void)didClickSavePhoto;
/// 点击停止拍摄
- (void)didClickStopFilming;
/// 点击删除照片
- (void)didClickDeletePhoto;
/// 点击拍照／摄像
- (void)didClickCamare;
@end

@interface BYCameraBottomTool : UIView
/// 拍照／拍摄的状态
@property (nonatomic,assign,readonly)BYCameraStateType type;
/// 代理
@property (nonatomic,weak)id <BYCameraBottomToolDelegate>delegate;
/// 最大摄像的秒数(默认30s)
@property (nonatomic,assign)CGFloat maxSecond;

/// 构造方法
- (instancetype)initWithFrame:(CGRect)frame
                    isFilming:(BOOL)isFilming;
/// 进度设置 -暂时不实现
- (void)setupFilmingProgress:(CGFloat)progress;





@end
