//
//  BYCameraBottomTool.m
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

//

#import "BYCameraBottomTool.h"
#import "BYTimer.h"
@interface BYCameraBottomTool ()
/// 是否摄像
@property (nonatomic,assign)BOOL isFilming;
/// 拍照按钮
@property (nonatomic,strong)UIButton *takePhotoButton;
/// 取消按钮
@property (nonatomic,strong) UIButton *cancleButton;
/// 切换摄像头按钮
@property (nonatomic,strong)UIButton *changeButton;
@end

@implementation BYCameraBottomTool

- (instancetype)initWithFrame:(CGRect)frame
                    isFilming:(BOOL)isFilming {
             
    if (self = [super initWithFrame:frame]) {
        self.isFilming = isFilming;
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor clearColor];
     _type = self.isFilming?BYCameraStateTypeBeginFilming:BYCameraStateTypeBeginTakePhoto;
    
    //takePhotoButton
    UIButton *takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:takePhotoButton];
    takePhotoButton.frame = CGRectMake((self.width - 60)/2, (self.height-60)/2, 60, 60);
    self.takePhotoButton = takePhotoButton;
    
    [takePhotoButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_filming60"] forState:UIControlStateNormal];
    [takePhotoButton setImage:[UIImage imageNamed:self.isFilming?@"BYCamera.bundle/icon_Infilming60":@"BYCamera.bundle/icon_takePhoto_Suceess60"]
                     forState:UIControlStateSelected];
    [takePhotoButton addTarget:self action:@selector(didClickTakePhotoButton:) forControlEvents:UIControlEventTouchUpInside];
    takePhotoButton.adjustsImageWhenHighlighted = NO;
    
    
    //cancleButton 40*40
    CGFloat smallWidth = 40.0f;
    CGFloat smallEdge = 15.0f;
    
    UIButton *cancleButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(smallEdge, (self.height-smallWidth)/2, smallWidth, smallWidth);
    [self addSubview:cancleButton];
    self.cancleButton = cancleButton;
    [cancleButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_takePhoto_exit28"] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(didClickCancleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //changeButton
    UIButton *changeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake(self.width - smallWidth - smallEdge, (self.height-smallWidth)/2, smallWidth, smallWidth);
    [self addSubview:changeButton];
    self.changeButton = changeButton;
    [changeButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_takePhoto_change"] forState:UIControlStateNormal];
    [changeButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_takePhoto_delete28"] forState:UIControlStateSelected];
    [changeButton addTarget:self action:@selector(didClickChangeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - Click
/// 点击拍照
- (void)didClickTakePhotoButton:(UIButton *)sender {
    
    if (_type == BYCameraStateTypeInFilminging && [BYTimer sharedBYTimer].timeDex <5) {
        /// 提示‘短视频录制不能短于10秒钟’
        return;
    }
   // [sender disableForTime:1.5];
    sender.selected = !sender.selected;
    if (!sender.selected) {
        _type = self.isFilming?BYCameraStateTypeCompleteFilming:BYCameraStateTypeCompleteTakePhoto;
        if (self.isFilming) {
            if (_delegate && [_delegate respondsToSelector:@selector(didClickStopFilming)]) {
                [_delegate didClickStopFilming];
            }
        }else{
            if (_delegate && [_delegate respondsToSelector:@selector(didClickSavePhoto)]) {
                [_delegate didClickSavePhoto];
            }
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(didClickCamare)]) {
            [_delegate didClickCamare];
        }
        _type = self.isFilming?BYCameraStateTypeInFilminging:BYCameraStateTypeCompleteTakePhoto;
        self.changeButton.selected = !self.isFilming;
    }
   
}

/// 点击取消
- (void)didClickCancleButton:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didClickCancle)]) {
        [_delegate didClickCancle];
    }
}

/// 点击切换
- (void)didClickChangeButton:(UIButton *)sender {
    if (_type == BYCameraStateTypeInFilminging ) {
        return;
    }
    if (sender.selected) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(didClickDeletePhoto)]) {
            [_delegate didClickDeletePhoto];
        }
        self.changeButton.selected = NO;
        self.takePhotoButton.selected = NO;
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(didClickChangeCamera)]) {
            [_delegate didClickChangeCamera];
        }
        
    }
}

/// 进度设置-暂时不实现
- (void)setupFilmingProgress:(CGFloat)progress {
    
}

@end
