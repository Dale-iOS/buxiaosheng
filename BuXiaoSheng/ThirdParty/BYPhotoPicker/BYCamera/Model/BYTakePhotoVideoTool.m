//
//  BYTakePhotoVideoTool.m
//  CustomeCamera
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYTakePhotoVideoTool.h"
#import "XCFileManager.h"



@interface BYTakePhotoVideoTool ()<AVCaptureFileOutputRecordingDelegate,PHPhotoLibraryChangeObserver,AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>



///AVCaptureSession:它从物理设备得到数据流（比如摄像头和麦克风），输出到一个或多个目的地，它可以通过会话预设值(session preset)，来控制捕捉数据的格式和质量
@property (nonatomic, strong) AVCaptureSession *iSession;
///设备
@property (nonatomic, strong) AVCaptureDevice *iDevice;
///输入
@property (nonatomic, strong) AVCaptureDeviceInput *iInput;
///照片输出
@property (nonatomic, strong) AVCaptureStillImageOutput *iOutput;
///视频输出（输出文件太大---以后使用AVAssetWriter代替）
@property (nonatomic, strong) AVCaptureMovieFileOutput *iMovieOutput;

///预览层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *iPreviewLayer;
/// 得到具体的all phtotos 相册的数据
@property (nonatomic,strong)PHFetchResult *collectonResuts;
///点击调焦出现的icon
@property (strong, nonatomic) UIImageView *focusIcon;
@property (nonatomic,assign)BOOL saveSuccess;
@property (nonatomic,assign)BOOL isSaveVideo;

#pragma mark - 升级版本3.3.5
/// 3.3.5使用AVAssetWriter代替AVCaptureMovieFileOutput
@property (nonatomic,strong)AVAssetWriter *assetWriter;
@property (nonatomic,strong)AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic,strong)AVAssetWriterInput *assetWriterAudioInput;

@end

@implementation BYTakePhotoVideoTool

/// 懒加载音频输出的设置
-(AVAssetWriterInput *)assetWriterAudioInput {
    
    if (!_assetWriterAudioInput) {
        // 音频设置
         NSDictionary *audioCompressionSettings = @{ AVEncoderBitRatePerChannelKey : @(28000),
                                           AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                                           AVNumberOfChannelsKey : @(1),
                                           AVSampleRateKey : @(22050) };
        _assetWriterAudioInput =  [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioCompressionSettings];
        
        _assetWriterAudioInput.expectsMediaDataInRealTime = YES;
        
        // 添加到AVAssetWriter
        if ([self.assetWriter canAddInput:_assetWriterAudioInput]) {
            [self.assetWriter addInput:_assetWriterAudioInput];
        }
    }
    return _assetWriterAudioInput;
}

/// 懒加载视频输出的设置
-(AVAssetWriterInput *)assetWriterVideoInput {
    
    if (!_assetWriterVideoInput) {
        
        NSInteger numPixels = APPWidth *APPHeight;
        CGFloat bitPerpixel = 6.0f;
        // 比特设置
        NSInteger bits = numPixels*bitPerpixel;
        // 码率和帧率设置
        NSDictionary *compressionProperties = @{ AVVideoAverageBitRateKey : @(bits),
                                                 AVVideoExpectedSourceFrameRateKey : @(15),
                                                 AVVideoMaxKeyFrameIntervalKey : @(15),
                                                 AVVideoProfileLevelKey : AVVideoProfileLevelH264BaselineAutoLevel };
        
        
        //视频属性
        NSDictionary *videoCompressionSettings = @{ AVVideoCodecKey : AVVideoCodecH264,
                                                    AVVideoScalingModeKey : AVVideoScalingModeResizeAspectFill,
                                                    AVVideoWidthKey : @(APPHeight * 2),
                                                    AVVideoHeightKey : @(APPWidth * 2),
                                                    AVVideoCompressionPropertiesKey : compressionProperties };
        
        
        _assetWriterVideoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoCompressionSettings];
        //expectsMediaDataInRealTime 必须设为yes，需要从capture session 实时获取数据
        _assetWriterVideoInput.expectsMediaDataInRealTime = YES;
        _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
        if ([self.assetWriter canAddInput:_assetWriterVideoInput]) {
            [self.assetWriter addInput:_assetWriterVideoInput];
        }
    }
    return _assetWriterVideoInput;
}
-(AVAssetWriter *)assetWriter {
    
    if (!_assetWriter) {
        
        NSString *path = [NSString stringWithFormat:@"%@/BangyouVideo/Bangyou_Video.mp4",[XCFileManager cachesDir]];
        [XCFileManager createFileAtPath:path overwrite:YES];
        _assetWriter = [AVAssetWriter assetWriterWithURL:[NSURL URLWithString:path] fileType:AVFileTypeMPEG4 error:nil];
    }
    return _assetWriter;
}

-(UIImageView *)focusIcon {
    
    if (!_focusIcon) {
        _focusIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_ Focusing"]];
        _focusIcon.frame = CGRectMake(0, 0, self.focusIcon.image.size.width, self.focusIcon.image.size.height);
        _focusIcon.hidden = YES;
        [self.iSuperView addSubview:self.focusIcon];
    }
    return _focusIcon;
}

-(AVCaptureDevice *)iDevice {
    
    if (!_iDevice) {
        NSArray *deviceArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice *device in deviceArray) {
            if (device.position == AVCaptureDevicePositionBack) {
                _iDevice = device;
            }
        }
        
        //添加摄像头设备 
        if ([_iDevice lockForConfiguration:nil]) {
            //闪光灯
            if ([_iDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
                [_iDevice setFlashMode:AVCaptureFlashModeAuto];
            }
            // 设置对焦模式
            if ([_iDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
                [_iDevice setFocusMode:AVCaptureFocusModeAutoFocus];
            }
            if ([_iDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                [_iDevice setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            }
            [_iDevice unlockForConfiguration];
        }

    }
    return _iDevice;
}
/// 输入
-(AVCaptureDeviceInput *)iInput {
    
    if (!_iInput) {
     
        _iInput = [[AVCaptureDeviceInput alloc]initWithDevice:self.iDevice error:nil];
      
    }
    return _iInput;
}

- (AVCaptureStillImageOutput *)iOutput {
    
    if (!_iOutput) {
        _iOutput = [[AVCaptureStillImageOutput alloc]init];
        NSDictionary *setDic = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey, nil];
        _iOutput.outputSettings = setDic;
    }
    return _iOutput;
}

-(AVCaptureMovieFileOutput *)iMovieOutput {
    
    if (!_iMovieOutput) {
    
        _iMovieOutput = [[AVCaptureMovieFileOutput alloc]init];

    }
    return _iMovieOutput;
}

-(AVCaptureSession *)iSession {
    
    if (!_iSession) {
        _iSession = [[AVCaptureSession alloc]init];
        _iSession.sessionPreset = AVCaptureSessionPresetHigh;
        //添加音频设备
        AVCaptureDevice *audioDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
        AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
        if ([_iSession canAddInput:audioInput]) {
            [_iSession addInput:audioInput];
        }
        
        if ([_iSession canAddOutput:self.iOutput]) {
            [_iSession addOutput:self.iOutput];
        }
        if ([_iSession canAddInput:self.iInput]) {
            [_iSession addInput:self.iInput];
        }
    }
    return _iSession;
}

-(AVCaptureVideoPreviewLayer *)iPreviewLayer {
    
    if (!_iPreviewLayer) {
        _iPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.iSession];
        [_iPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        _iPreviewLayer.frame = [UIScreen mainScreen].bounds;
        [self.iSuperView.layer insertSublayer:_iPreviewLayer atIndex:0];
        [self.iSession startRunning];
    }
    return _iPreviewLayer;
}


- (instancetype)initWithSuperView:(UIView *)iSuperView
                             type:(BYTakePhotoVideoType )type {
    if (self = [super init]) {
        
        _iSuperView = iSuperView;
       _type = type;
        self.saveSuccess = NO;
        self.isSaveVideo = NO;
        
        // 监听相册变化
        PHPhotoLibrary *lib = [PHPhotoLibrary sharedPhotoLibrary];
        [lib  registerChangeObserver:self];
        
        // 初始化数据
        [self iDevice];
        [self iInput];
        [self iSession];
        [self iPreviewLayer];
        
        if (type == BYTakePhotoVideoTypeForPhoto) {
            // 调制成拍照模式
            [self iOutput];
            [self.iSession beginConfiguration];
            if ([self.iSession canAddOutput:self.iOutput]) {
                [self.iSession addOutput:self.iOutput];
            } else{
                [self.iSession addOutput:self.iMovieOutput];
            }
            [self.iSession commitConfiguration];
        }else{
            
            // 设置成摄像模式
            [self iMovieOutput];
            [self.iSession beginConfiguration]; 
            
            if ([self.iSession canAddOutput:self.iMovieOutput]) {
                [self.iSession addOutput:self.iMovieOutput];
                //设置视频防抖
                AVCaptureConnection *connection = [self.iMovieOutput connectionWithMediaType:AVMediaTypeVideo];
                if ([connection isVideoStabilizationSupported]) {
                    connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeCinematic;
                }
                
            }
            
            [self.iSession commitConfiguration];
            
        }
    }
    return self;
}



- (instancetype)init {
    // 不使用断言好了
    NSLog(@" 请使用(initWithSuperView:)方法初始化");
    return nil;
}


/// 设备打开
- (void)startRunning {
    if (self.iSession) {
        [self.iSession startRunning];
    }
}
/// 设备关闭
- (void)stopRunning {
    if (self.iSession) {
        [self.iSession stopRunning];
    }
}
/// 拍照
- (void)takePhoto {
   
    AVCaptureConnection *connection = [self.iOutput connectionWithMediaType:AVMediaTypeVideo];
    if (!connection) {
      
    } else{
        [self.iOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
          
            if (_delegate && [_delegate respondsToSelector:@selector(didClickTakePhoto:)]) {
                [_delegate didClickTakePhoto:image];
            }
        }];
    }
    
}
/// 保存图片到相册
- (void)saveImage:(UIImage *)photo {
    
    UIImageWriteToSavedPhotosAlbum(photo, self, @selector(photo:didFinishSavingWithError:contextInfo:), nil);
}
/// 开始拍摄
- (void)startFilming {

    if (![self.iMovieOutput isRecording]) {
        [NSThread sleepForTimeInterval:0.2];
        NSURL *url = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"]];
        [self.iMovieOutput startRecordingToOutputFileURL:url recordingDelegate:self];
        // 开始计时
       // [[BYTimer sharedBYTimer] timerBegin];
        if (_delegate && [_delegate respondsToSelector:@selector(didClickStartFilming)]) {
            [_delegate didClickStartFilming];
        }
    NSLog(@"开始拍摄");
    }
}
/// 停止拍摄
- (void)stopFilming {
    /// TODO
    
    if ([self.iMovieOutput isRecording]) {
        [self.iMovieOutput stopRecording];
        // [[BYTimer sharedBYTimer] timerPuase];
        NSLog(@"停止拍摄 ");
    }
}

/// 更换设备的前后摄像头
- (void)changeDevicePosition {
    
    NSArray *deviceArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *newDevice;
    AVCaptureDeviceInput *newInput;
    
    if (self.iDevice.position == AVCaptureDevicePositionBack) {
        for (AVCaptureDevice *device in deviceArray) {
            if (device.position == AVCaptureDevicePositionFront) {
                newDevice = device;
            }
        }
    } else {
        for (AVCaptureDevice *device in deviceArray) {
            if (device.position == AVCaptureDevicePositionBack) {
                newDevice = device;
            }
        }
    }
    
    newInput = [AVCaptureDeviceInput deviceInputWithDevice:newDevice error:nil];
    if (newInput!=nil) {
        
        [self.iSession beginConfiguration];
        [self.iSession removeInput:self.iInput];
        if ([self.iSession canAddInput:newInput]) {
            [self.iSession addInput:newInput];
            self.iDevice = newDevice;
            self.iInput = newInput;
        } else{
            [self.iSession addInput:self.iInput];
        }
        
        [self.iSession commitConfiguration];
    }
}

/// 调焦
- (void)focusAtPoint:(CGPoint)point {
    CGSize size = self.iSuperView.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    
    if ([self.iDevice lockForConfiguration:&error]) {
        
        if ([self.iDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.iDevice setFocusPointOfInterest:focusPoint];
            [self.iDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        //曝光模式和曝光点
        if ([self.iDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.iDevice setExposurePointOfInterest:focusPoint];
            [self.iDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        [self.iDevice unlockForConfiguration];
        
        self.focusIcon.center = point;
        self.focusIcon.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.focusIcon.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.focusIcon.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                self.focusIcon.hidden = YES;
            }];
        }];
        
    }
}

#pragma mark - AVCaptureFileOutputRecordingDelegate
-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    //保存视频到相册
    if (!error) {
        UISaveVideoAtPathToSavedPhotosAlbum([outputFileURL path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        
            [NSThread sleepForTimeInterval:0.2];
            if (_delegate && [_delegate respondsToSelector:@selector(didClickStopFilming:)]) {
                [_delegate didClickStopFilming:outputFileURL];
            }
     //  dispatch_sync(dispatch_get_main_queue(), ^{ });
    }
}

#pragma mark - 保存数据
//保存图片完成之后的回调
- (void)photo:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    
    if (error) {
        NSLog(@"图片保存失败");
    }
    else {
        self.saveSuccess = YES;
        NSLog(@"图片保存成功");
    }
}
//保存视频完成之后的回调
- (void)video:(UIImage*)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo {
    
    if (error) {
        NSLog(@"视频保存失败");
    }
    else {
        self.saveSuccess = NO;
        NSLog(@"视频保存成功");
    }
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    
    if (self.saveSuccess){
        self.saveSuccess = NO;
        [NSThread sleepForTimeInterval:0.2];
        dispatch_sync(dispatch_get_main_queue(), ^{
           
            PHAsset *asset = [self.collectonResuts lastObject];
            if (_delegate && asset) {
                if (_delegate && [_delegate respondsToSelector:@selector(didClickTakePhoto:)]) {
                    [_delegate didClickSavePhoto:asset];
                }
                [[PHPhotoLibrary sharedPhotoLibrary]unregisterChangeObserver:self];
               
            }
        });
    }
    NSLog(@"相册有变化哦 😯");
}

-(PHFetchResult *)collectonResuts {
    
    if (!_collectonResuts) {
        
        PHFetchResult *smartAlbums =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        [smartAlbums enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([collection.localizedTitle isEqualToString:@"All Photos"] || [collection.localizedTitle isEqualToString:@"所有照片"]|| [collection.localizedTitle isEqualToString:@"相机胶卷"]||[collection.localizedTitle isEqualToString:@"Camera Roll"]) {
                // 是否按创建时间排序
                PHFetchOptions *photoOption = [[PHFetchOptions alloc] init];
                photoOption.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
                photoOption.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
                // 获取照片集合
                _collectonResuts = [PHAsset fetchAssetsInAssetCollection:collection options:photoOption];
            }
        }];
        
    }
    return _collectonResuts;
}


@end
