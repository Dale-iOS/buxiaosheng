//
//  BYPhotoSelect.m
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//  需求：视频和图片不能同时选择，但是图片可以选择多张，视频最多选择一个

#import "BYPhotoSelect.h"

#import <Photos/PHPhotoLibrary.h>
#import <Photos/Photos.h>
#import "BYPhotoSelectCell.h"
#import "BYPhotoModel.h"
#import "BYPhotoSelectPreveiwVC.h"

@interface BYPhotoSelect ()

@property (nonatomic,strong)NSMutableArray *allAssets;
@property (nonatomic,strong)UIButton *rightButton;
@property (nonatomic,assign)BOOL containsVideo;
@property (nonatomic,assign)BOOL containsPhoto;
/// 已经选择的个数
@property (nonatomic,assign)NSUInteger selectVideoCount;
@property (nonatomic,assign)NSUInteger selectPhotoCount;
@property (nonatomic,strong)NSMutableArray *selecModels;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UILabel *authorizationLb;
@property (nonatomic,strong)UIButton *authorizationButton;

@end

@implementation BYPhotoSelect
#pragma mark - 构造方法
- (instancetype)initWithConfig:(BYPhotoSelectConfig *)config {
    if (self = [super init]) {
        _config = config;
        self.videoMaxTime = 1000;//暂时不限制
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupNav];
    [self setCollection];
    [self requestAuthorizationStatus];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    //[self reloadData];
}

- (void)setup {
    
    self.title = @"相册选择";
    self.selectVideoCount = 0;
    self.selectPhotoCount = 0;
}
- (void)setupNav {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    button.titleLabel.font = FONT(12);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.enabled = NO;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickDone) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = button;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
}
/// 设置Collection
- (void)setCollection {
    
    CGFloat margin = 2.0f;
    NSUInteger col = 3;
    CGFloat itemWH = (APPWidth - margin*(col-1))/col;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    [self setColoctionBy:layout];
    [self.mainCollection registerClass:[BYPhotoSelectCell class] forCellWithReuseIdentifier:@"cell"];
}

/// 这个是全县请求
- (void)requestAuthorizationStatus {
    
    /// TODO 使用kVC监听权限的改变～  一旦权限放开那么马上重新获取内容的
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(observeAuthrizationStatusChange:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    // 获取当前应用对照片的访问授权状态
    PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
    // 如果没有获取访问授权，或者访问授权状态已经被明确禁止，则显示提示语，引导用户开启授权
    if (authorizationStatus == PHAuthorizationStatusRestricted || authorizationStatus == PHAuthorizationStatusDenied) {
        [self setupAuthorizationLb];
     }else{
        [self getAllPhotos];
    }
}

- (void)setupAuthorizationLb {
 
    if (self.authorizationLb ) {
        [self.view bringSubviewToFront:self.authorizationLb];
        return;
    }
    
    NSDictionary *mainInfoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appNNN = [mainInfoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *tipTextWhenNoPhotosAuthorization = [NSString stringWithFormat:@"请在设备的\"设置-隐私-照片\"选项中，允许%@访问你的手机相册", appNNN];
    
    // 展示提示语
    self.authorizationLb = [[UILabel alloc]initWithFrame:CGRectMake(30, APPHeight * 0.35, APPWidth - 60, 50)];
    self.authorizationLb.text = tipTextWhenNoPhotosAuthorization;
    self.authorizationLb.textAlignment = NSTextAlignmentCenter;
    self.authorizationLb.numberOfLines = 0;
    [self.view addSubview:self.authorizationLb];
    // 去设置
    [self.authorizationLb addHanderBlock:^(UIView *sender) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    NSLog(@"请选择允许!");
    
}
/// 监听相册权限的变化
- (void)observeAuthrizationStatusChange:(NSTimer *)timer {
   
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        
        [timer invalidate];
        [self.timer invalidate];
        self.timer = nil;
        [self.authorizationLb removeFromSuperview];
        [self getAllPhotos];
    }else {
        [self setupAuthorizationLb];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

/// 得到全部的相册
- (void)getAllPhotos {
    
    // 获取系统相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    self.allAssets = [NSMutableArray array];
    
 
    // 在主线程中执行的
    WEAKSELF;
    self.mainCollection.alpha = 0.0f;
    [smartAlbums enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
     
        if ([collection.localizedTitle isEqualToString:@"All Photos"] || [collection.localizedTitle isEqualToString:@"所有照片"]|| [collection.localizedTitle isEqualToString:@"相机胶卷"]||[collection.localizedTitle isEqualToString:@"Camera Roll"]) {
            
                //是否按创建时间排序
                PHFetchOptions *photoOption = [[PHFetchOptions alloc] init];
                photoOption.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
                photoOption.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld OR mediaType == %ld", PHAssetMediaTypeImage,PHAssetMediaTypeVideo];
                // 获取照片集合
                PHFetchResult *photoResult = [PHAsset fetchAssetsInAssetCollection:collection options:photoOption];
                for (int i=0;i<photoResult.count;i++) {
                   
                    PHAsset *asset = photoResult[i];
                    BYPhotoModel *model = [[BYPhotoModel alloc]initWithAsset:asset];
                    [weakSelf.allAssets addObject:model];
               }
        }
    }];
    
    [self handleAllAssets];
}

- (void)handleAllAssets {
    
    // 表示选中的模型
    [self.selecModels removeAllObjects];
    // 表示选中的模型
    for (int i = 0 ; i<self.selectPhotos.count; i++) {
        BYPhotoModel *selectModel = self.selectPhotos[i];
        if (selectModel.isAdd) break;
        
        for (int i=0;i<self.allAssets.count;i++) {
            BYPhotoModel *aModel = self.allAssets[i];
            if ([aModel.assetId isEqualToString:selectModel.assetId]) {
                
                aModel.isSelect = YES;
                if (aModel.modelType == BYPhotoModelTypeImage) {
                    [self.selecModels addObject:aModel];
                }else{
                    [self.allAssets removeObject:aModel];
                    i--;
                }
            }
        }
        
        if (i==0) {
            self.containsPhoto =  (selectModel.asset.mediaType == PHAssetMediaTypeImage);
            self.containsVideo = !self.containsPhoto;
            self.selectPhotoCount = (self.containsPhoto?self.selecModels.count:0);
            self.selectVideoCount = (self.containsVideo?self.selecModels.count:0);
        }
    }
    
    // 显示
    NSString *selectTitle = [NSString stringWithFormat:@"确定(%lu)",self.selecModels.count];
    [self.rightButton setTitle:selectTitle forState:UIControlStateNormal];
    [self performSelector:@selector(showCollection) withObject:nil afterDelay:0.5];
    [self reloadData];
}

- (void)reloadData {
    
    [self.mainCollection reloadData];
   
}
- (void)showCollection {
     self.mainCollection.alpha = 1.0f;
}

#pragma mark - Click

- (void)clickDone {
    if (self.selecModels.count == 0) {
        [LLHudTools showWithMessage:@"请选择!"];
    
        return;
    }
    BYPhotoModel *model = self.selecModels.firstObject;
    [self.navigationController popViewControllerAnimated:NO];
    if (model.modelType == BYPhotoModelTypeVideo) {
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectVideoModel:)]) {
          
            [_delegate didSelectVideoModel:model];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectPhotoModel:)]) {
            [_delegate didSelectPhotoModel:[self.selecModels mutableCopy]];
        }
    }
}
- (void)clickCellSelect:(BYPhotoModel *)model {
    
    if (!model.isSelect) {
        if (self.containsVideo && model.asset.mediaType == PHAssetMediaTypeImage) {
            // 包含图片 不能选择视频 TODO
            [LLHudTools showWithMessage:@"请选择!"];
            return;
        }

        if (self.containsPhoto && model.asset.mediaType == PHAssetMediaTypeVideo) {
            // 包含视频 不能选择图片 TODO
            [LLHudTools showWithMessage:@"视频和图片不能同时选择!"];
            return;
        }
        
        if (_config.maxPhotoCount == 0  && model.asset.mediaType == PHAssetMediaTypeImage) {
           [LLHudTools showWithMessage:@"只能选择视频!"];
            return;
        }
        
        if (_config.maxVideoCount == 0 && model.asset.mediaType == PHAssetMediaTypeVideo) {
            [LLHudTools showWithMessage:@"只能选择图片!"];
            return;
        }
        
        if (self.containsVideo  && self.selecModels.count >= 1) {
           [LLHudTools showWithMessage:@"视频每次最多选择1个!"];
            return;
        }
        if (self.containsPhoto  && self.selecModels.count >= self.config.maxPhotoCount) {
       
            
                 [LLHudTools showWithMessage: [NSString stringWithFormat:@"图片最多选择%ld个!",self.config.maxPhotoCount]];
            return;
        }
   
        if (model.asset.mediaType == PHAssetMediaTypeVideo && model.videoTime < 5) {
            // 时间太短 
            [LLHudTools showWithMessage:@"视频时间不能少于5秒!"];
            return;
        }
    }
    
    
    model.isSelect =!model.isSelect;
    if (model.isSelect) {
        [self.selecModels addObject:model];
    }else{
        [self.selecModels removeObject:model];
    }
    // 判断是否包含视频／图片
    if (self.selecModels.count > 0) {
        BYPhotoModel *selectModel = self.selecModels.firstObject;
        self.containsPhoto = (selectModel.asset.mediaType == PHAssetMediaTypeImage);
        self.containsVideo = !self.containsPhoto;
        
    }else{
        self.containsPhoto = self.containsVideo = NO;
    }
    // 计算选择的个数
    self.selectPhotoCount = (self.containsPhoto?self.selecModels.count:0);
    self.selectVideoCount = (self.containsVideo?self.selecModels.count:0);
 
    NSString *selectTitle = [NSString stringWithFormat:@"确定(%lu)",self.selecModels.count];
    [self.rightButton setTitle:selectTitle forState:UIControlStateNormal];
    int row = (int)[self.allAssets indexOfObject:model];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.mainCollection reloadItemsAtIndexPaths:@[path]];
}

#pragma mark -  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allAssets.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BYPhotoSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    __block BYPhotoModel *model = [[self allAssets] objectAtIndex:indexPath.row];
    
    cell.photoModel = model;
    WEAKSELF;
    cell.clickSelectBlock = ^{
        [weakSelf clickCellSelect:model];
    };
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BYPhotoModel *model = [[self allAssets] objectAtIndex:indexPath.row];
    if (model.modelType == BYPhotoModelTypeImage) {
        if (model.isSelect) {
            NSUInteger index = [self.selecModels indexOfObject:model];
            BYPhotoSelectPreveiwVC *VC = [[BYPhotoSelectPreveiwVC alloc]initWithPhotos:self.selecModels atIndex:index];
            [self presentViewController:VC animated:YES completion:^{
                
            }];
        }else{
            BYPhotoSelectPreveiwVC *VC = [[BYPhotoSelectPreveiwVC alloc]initWithPhoto:model];
            [self presentViewController:VC animated:YES completion:^{
            }];
        }
    }else{
        // 视频播放器
//        BYVideoPreviewVC *VC = [[BYVideoPreviewVC alloc]init];
//        VC.videoUrl = model.videoURL;
//        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark -  UICollectionViewDelegate

-(NSMutableArray *)selecModels {
    
    if (!_selecModels) {
        _selecModels = [NSMutableArray array];
    }
    return _selecModels;
}

@end





@implementation BYPhotoSelectConfig


/**
 得到配置对象
 */
- (instancetype)initWithMaxPhoto:(NSUInteger)maxPhoto
                        maxVideo:(NSUInteger)maxVideo {
    if (self = [super init]) {
        
        _maxPhotoCount = maxPhoto;
        _maxVideoCount = maxVideo;
    }
    return self;
}
/**
 得到配置对象
 */
- (instancetype)initWithMaxPhoto:(NSUInteger)maxPhoto
                        maxVideo:(NSUInteger)maxVideo
                    maxVideoTime:(NSUInteger)maxTime {
    if (self = [super init]) {
        
        _maxPhotoCount = maxPhoto;
        _maxVideoCount = maxVideo;
        _videoMaxTime = maxTime;
    }
    return self;
}

@end


