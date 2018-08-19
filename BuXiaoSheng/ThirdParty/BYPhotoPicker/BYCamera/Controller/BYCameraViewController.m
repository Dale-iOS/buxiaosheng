//
//  BYCameraViewController.m
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

//

#import "BYCameraViewController.h"
#import "BYTakePhotoVideoTool.h"
#import "BYCameraBottomTool.h"
#import "BYTimer.h"

@interface BYCameraViewController ()<BYTakePhotoVideoToolDelegate,BYCameraBottomToolDelegate>
/// 是否是摄像
@property (nonatomic,assign)BOOL isFilming;
/// 拍照／拍摄工具
@property (nonatomic,strong) BYTakePhotoVideoTool *tool;
/// 拍照的到的图片
@property (nonatomic,strong)UIImage *takeImage;
/// 拍照的预览
@property (nonatomic,strong)UIImageView *previewPhotoView;

@property (nonatomic,strong)UILabel *warmLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,assign)NSInteger videoTime;
@property (nonatomic,assign)BOOL isCancle;
@end



@implementation BYCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setup];
}

- (void)setup {
    
    self.isFilming = (self.CameraType == BYCameraViewTypeFilmingVideo);
    self.view.backgroundColor = [UIColor clearColor];
    BYTakePhotoVideoTool *tool = [[BYTakePhotoVideoTool alloc]initWithSuperView:self.view type:self.isFilming?BYTakePhotoVideoTypeForVideo:BYTakePhotoVideoTypeForPhoto];
    tool.delegate = self;
    self.tool = tool;
    
    //点击调教
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled = YES;
    
    //previewPhotoView
    self.previewPhotoView = [[UIImageView alloc]init];
    [self.view addSubview:self.previewPhotoView];
    self.previewPhotoView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.previewPhotoView.hidden = YES;
    
    //bottomTool
    BYCameraBottomTool *bottomTool = [[BYCameraBottomTool alloc]initWithFrame:CGRectMake(0, APPHeight - 80, APPWidth, 60) isFilming:self.isFilming];
    bottomTool.delegate = self;
    [self.view addSubview:bottomTool];
    
    if (self.isFilming) {
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((APPWidth - 90)/2, 22, 90, 32)];
        self.timeLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.textColor = [UIColor whiteColor];
        self.timeLabel.font = FONT(14);
        self.timeLabel.KYConnerRediu(16);
        [self.view addSubview:self.timeLabel];
        self.timeLabel.text = @"00:00";
        self.timeLabel.hidden = YES;
        
        UIView *point = [[UIView alloc]initWithFrame:CGRectMake(18, (self.timeLabel.height - 4)/2, 4, 4)];
        [self.timeLabel addSubview:point];
        point.backgroundColor = [UIColor redColor];
        point.KYConnerRediu(2);
        self.videoTime = 0;
    }
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tool startRunning];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.tool stopRunning];
     self.navigationController.navigationBar.hidden = NO; 
    [[BYTimer sharedBYTimer] clearTimer];
}

/// 调焦功能
- (void)tapClick:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self.view];
    [self.tool focusAtPoint:point];
}


-(void)clickBack {
    
    _isCancle = YES;
    if (self.navigationController) {
         [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (void)timeRuning:(NSUInteger )time {
    self.videoTime = time - 2;
    if (self.videoTime >= 0) {
        self.timeLabel.hidden = NO;
    }
    if (time>= 15 + 2) {
        [self.tool stopFilming];
    }
    NSString *timeStr = [self getNewTimeFromDurationSecond:self.videoTime];
    self.timeLabel.text = timeStr;
}
#pragma mark - BYCameraBottomToolDelegate
/// 点击取消
- (void)didClickCancle {
   
    [self clickBack];
}
/// 点击切换镜头
- (void)didClickChangeCamera {
     [self.tool changeDevicePosition];
}
/// 点击保存图片
- (void)didClickSavePhoto {
    [self.tool saveImage:self.takeImage];
}
/// 点击停止拍摄
- (void)didClickStopFilming {
    [self.tool stopFilming];
}
/// 点击删除照片
- (void)didClickDeletePhoto {
    self.takeImage = nil;
    self.previewPhotoView.hidden = YES;
}
/// 点击拍照／摄像
- (void)didClickCamare {
    if (self.isFilming) {
        [self.tool startFilming];
//
//        WeakSelf;
//        [BYTimer sharedBYTimer].timerRunBlock = ^(NSUInteger time) {
//            [weakSelf timeRuning:time];
//        };
    }else{
        [self.tool takePhoto];
    }
}
#pragma mark - BYTakePhotoVideoToolDelegate

/// 点击拍照
- (void)didClickTakePhoto:(UIImage *)photo  {
    self.takeImage = photo;
    self.previewPhotoView.hidden = NO;
    self.previewPhotoView.image = photo;
}
/// 点击保存照片
- (void)didClickSavePhoto:(PHAsset *)asset {
    !_completionHandler?:_completionHandler(asset);
    
   [self clickBack];
}
/// 点击定制拍摄
- (void)didClickStopFilming:(NSURL *)videoUrl {
    
    if (_isCancle) return;
    !_completionVideoHandler?:_completionVideoHandler(videoUrl);
    [self clickBack];
}

/// 点击开始拍摄开始计时
- (void)didClickStartFilming {
    
}
#pragma mark - private

/// 获取视频的时长
- (NSString *)getNewTimeFromDurationSecond:(NSInteger)duration {
    
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
