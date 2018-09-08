//
//  ToolsCollectionVC.m
//  UICollectionViewss
//
//  Created by 幸福的尾巴 on 2018/8/30.
//  Copyright © 2018年 幸福的尾巴. All rights reserved.
//

#import "ToolsCollectionVC.h"
#import "CellImageCollVi.h"
#import "LZSetImagePickerController.h"
#import "TZImagePreviewController.h"
@interface ToolsCollectionVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) NSMutableArray *urlOldImage;//来自网络的图片 可已做删除操作
@property (nonatomic, strong) NSMutableArray *selectImage;//选择本地的image 用来上传的
@property (nonatomic, strong) NSMutableArray *requestImageUrlStr;//传输时本地存在的url(即,原始的url)

@end

@implementation ToolsCollectionVC
- (void)viewDidLoad {
    [super viewDidLoad];
	_selectedPhotos = [NSMutableArray array];
	_selectImage = [NSMutableArray array];
	_requestImageUrlStr = [NSMutableArray array];
}
/**
 设置 UICollectionView

 @param pFrame pFrame
 */
- (void)setupMainCollectionViewWithFrame:(CGRect)pFrame{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	self.mainCollectionView = [[UICollectionView alloc] initWithFrame:pFrame collectionViewLayout:layout];
	self.mainCollectionView.backgroundColor = [UIColor clearColor];
	[self.mainCollectionView registerClass:[CellImageCollVi class] forCellWithReuseIdentifier:@"cellId"];
	self.mainCollectionView.delegate = self;
	self.mainCollectionView.dataSource = self;
}
#pragma mark - CollectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	NSInteger tCount;
	if (_downloadImageUrlList == nil) {
		tCount = self.maxCountTF.integerValue;
	}else{
		tCount = 5;
	}
	if (_selectedPhotos.count >= tCount) {
		return _selectedPhotos.count;
	}
	return _selectedPhotos.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	CellImageCollVi *cell = (CellImageCollVi *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor clearColor];
	cell.deleteBtn.hidden = YES;
	if (indexPath.item == _selectedPhotos.count) {
		cell.imageView.image = [UIImage imageNamed:@"add_image"];
	} else {
		id photo = _selectedPhotos[indexPath.item];
		if ([photo isKindOfClass:[UIImage class]]) {
			cell.imageView.image = photo;
			cell.deleteBtn.hidden = NO;
		} else if ([photo isKindOfClass:[NSURL class]]) {
//			[self configImageView:cell.imageView URL:(NSURL *)photo completion:nil];
			[cell.imageView sd_setImageWithURL:(NSURL *)photo placeholderImage:[UIImage imageNamed:@"add_image"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
				cell.deleteBtn.hidden = NO;
			}];
		} else if ([photo isKindOfClass:[PHAsset class]]) {
			[[TZImageManager manager] getPhotoWithAsset:photo photoWidth:100 completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
				cell.imageView.image = photo;
			}];
			cell.deleteBtn.hidden = NO;
		}

	}
	cell.deleteBtn.tag = indexPath.item;
	[cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
	return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	NSLog(@"--%@",indexPath);
	if (indexPath.item == _selectedPhotos.count) {
		BOOL showSheet = YES;
		if (showSheet) {
			NSString *takePhotoTitle = @"拍照";
			UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
			UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				[self takePhoto];
			}];
			[alertVc addAction:takePhotoAction];
			UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
				[self pushTZImagePickerController];
			}];
			[alertVc addAction:imagePickerAction];
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
			[alertVc addAction:cancelAction];
			UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
			UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
			if (popover) {
				popover.sourceView = cell;
				popover.sourceRect = cell.bounds;
				popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
			}
			[self presentViewController:alertVc animated:YES completion:nil];
		} else {
			[self pushTZImagePickerController];
		}
	} else {
		//预览照片
		TZImagePreviewController *previewVc = [[TZImagePreviewController alloc] initWithPhotos:self.selectedPhotos currentIndex:indexPath.row tzImagePickerVc:[self createTZImagePickerController]];
		WEAKSELF
		//预览页 返回
		[previewVc setBackButtonClickBlock:^(BOOL isSelectOriginalPhoto) {
//            self.isSelectOriginalPhoto = isSelectOriginalPhoto;
		}];
		[previewVc setSetImageWithURLBlock:^(NSURL *URL, UIImageView *imageView, void (^completion)(void)) {
			[self configImageView:imageView URL:URL completion:completion];
		}];
		//预览页 完成
		[previewVc setDoneButtonClickBlock:^(NSArray *photos, BOOL isSelectOriginalPhoto) {
			if (weakSelf.downloadImageUrlList) {
				[self doneButtonClickComePreviewPhoto:photos];
			}else{
				self.maxCountTF = @"1";
			}
//            self.isSelectOriginalPhoto = isSelectOriginalPhoto;
			self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
			//设置选择的本地图片
			NSLog(@"预览页 完成 isSelectOriginalPhoto:%d photos.count:%zd", isSelectOriginalPhoto, photos.count);
			[weakSelf.mainCollectionView reloadData];
		}];
		[self presentViewController:previewVc animated:YES completion:nil];
	}
}

/**
 点击down后从新设置选择的最大数量

 @param pPhotos pPhotos
 */
- (void)doneButtonClickComePreviewPhoto:(NSArray *)pPhotos{
	//有图片被移除了
	if (pPhotos.count < self.selectedPhotos.count) {
		NSMutableArray * tNewPhotoUrl = [NSMutableArray array];
		NSMutableArray * tOldPhotoUrl = [NSMutableArray array];

		for (id tNewUrl in pPhotos) {
			if ([tNewUrl isKindOfClass:[NSURL class]]) {
				[tNewPhotoUrl addObject:tNewUrl];
			}
		}
		for (id tOldUrl in self.selectedPhotos) {
			if ([tOldUrl isKindOfClass:[NSURL class]]) {
				[tOldPhotoUrl addObject:tOldUrl];
			}
		}
		//减少的是url
		if (tNewPhotoUrl.count < tOldPhotoUrl.count) {
			NSInteger tCount = tOldPhotoUrl.count - tNewPhotoUrl.count;
			NSInteger tNewCount = self.maxCountTF.integerValue + tCount;
			self.maxCountTF = [NSString stringWithFormat:@"%zd",tNewCount];
		}
	}
}
#pragma mark - CollectionViewLayout
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	return CGSizeMake(60, 60);//可以根据屏幕大大小去设置
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
	return UIEdgeInsetsMake(10, 10, 1, 1);//可以根据屏幕大大小去设置
}
//设置每个item水平间距
// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
	return 5;
}
//设置每个item垂直间距
// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	return 5;
}

#pragma mark - UIImagePickerController
/**
 进入拍照
*/
- (void)takePhoto {
	WEAKSELF;
	[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
		if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
			[weakSelf pushImagePickerController];

		}else{
			//[JLHelperManager UIAlertWithStr:@"请在系统设置中开启相册授权" WithTitle:@"相册授权未开启" WithVC:self block:nil];
			dispatch_async(dispatch_get_main_queue(), ^{
				[LZSetImagePickerController showAlertStyle:UIAlertControllerStyleAlert
											  withTitleStr:@"无法使用相机"
											withMessageStr:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
										  withBtn1TitleStr:@"设置" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"取消" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:nil withBtn3ActionStyle:UIAlertActionStyleDefault withCTarget:weakSelf withButtonClickIndex:^(NSInteger Index) {
											  if (Index == 1) {
												  // 去设置界面，开启相机访问权限
												  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
											  }
										  }];
			});
		}
	}];
}
/**
 开启摄像头
 */
- (void)pushImagePickerController {
	UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
	if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
		self.imagePickerVc.sourceType = sourceType;
		NSMutableArray *mediaTypes = [NSMutableArray array];
		if (mediaTypes.count) {
			_imagePickerVc.mediaTypes = mediaTypes;
		}
		_imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
		[self presentViewController:_imagePickerVc animated:YES completion:nil];
	} else {
		NSLog(@"模拟器中无法打开照相机,请在真机中使用");
	}
}
/**
拍完照片会进来

 @param picker picker
 @param info info
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	NSString *type = [info objectForKey:UIImagePickerControllerMediaType];

	TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];

	[tzImagePickerVc showProgressHUD];
	if ([type isEqualToString:@"public.image"]) {
		UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
		//保存图片，获取到asset
		[[TZImageManager manager] savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error) {
			if (error) {
				[tzImagePickerVc hideProgressHUD];
				NSLog(@"图片保存失败 %@",error);
			}else{
				[self successGitImage:image WithTZImagePickerVc:tzImagePickerVc];
			}
		}];
	}
}
//拍完照片会进来- 刷新
- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
	[_selectedPhotos addObject:asset];
	[_mainCollectionView reloadData];
}
//拍摄照片 - 点击了取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	if ([picker isKindOfClass:[UIImagePickerController class]]) {
		[picker dismissViewControllerAnimated:YES completion:nil];
	}
}
#pragma mark - TZImagePickerController
/**
 开启系统相册
 */
- (void)pushTZImagePickerController {
	TZImagePickerController *imagePickerVc = [self createTZImagePickerController];
	WEAKSELF
#pragma mark - 选择完相册的图片会到下面的block内
	[imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
		NSMutableArray * tSelectedPhotos = [self.selectedPhotos mutableCopy];
		for (int i = 0; i < tSelectedPhotos.count; i ++) {
			id photo = tSelectedPhotos[i];
			if ([photo isKindOfClass:[PHAsset class]]) {
				[self.selectedPhotos removeObject:photo];
			}
		}
		[weakSelf.selectedPhotos addObjectsFromArray:assets];
//        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
		[weakSelf.mainCollectionView reloadData];
		// 1.打印图片名字
		[weakSelf printAssetsName:assets];
	}];
	[self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - TZImagePickerControllerDelegate
//选择完系统的照片后会进来
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
}
// 选择系统的照片- 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
}
#pragma mark - Click Event
/**
 删除图片

 @param sender se
 */
- (void)deleteBtnClik:(UIButton *)sender {
	if ([self collectionView:self.mainCollectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
		[ self deleteUrlOldImage:sender];
		[_selectedPhotos removeObjectAtIndex:sender.tag];
		[self.mainCollectionView reloadData];
		return;
	}
	[ self deleteUrlOldImage:sender];
	[_selectedPhotos removeObjectAtIndex:sender.tag];
	[_mainCollectionView performBatchUpdates:^{
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
		[self.mainCollectionView deleteItemsAtIndexPaths:@[indexPath]];
	} completion:^(BOOL finished) {
		[self.mainCollectionView reloadData];

	}];
}
/**
 删除图片时如果来着于网络的图则要修改可以选择的最大数量

 @param sender 选择的item
 */
- (void)deleteUrlOldImage:(UIButton *)sender{
	if (_downloadImageUrlList) {
		if (sender.tag < _urlOldImage.count) {
			[_urlOldImage removeObjectAtIndex:sender.tag];
			NSInteger tCount = self.maxCountTF.integerValue;
			++ tCount;
			self.maxCountTF = [NSString stringWithFormat:@"%zd",tCount];
		}
	}
}
#pragma mark --- 选择图片 ---
#pragma mark --- 懒加载---
- (UIImagePickerController *)imagePickerVc{
	if (_imagePickerVc == nil) {
		_imagePickerVc = [LZSetImagePickerController initWithImagePickerVc:_imagePickerVc withUIviewCTarget:self];
	}
	return _imagePickerVc;
}
- (NSMutableArray *)selectedPhotos{
	if (!_selectedPhotos) {
		_selectedPhotos = [NSMutableArray array];
	}
	return _selectedPhotos;
}
#pragma mark - Private
/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
	NSString *fileName;
	for (id asset in assets) {
		if ([asset isKindOfClass:[PHAsset class]]) {
			PHAsset *phAsset = (PHAsset *)asset;
			fileName = [phAsset valueForKey:@"filename"];
		}
		NSLog(@"图片名字:%@",fileName);
	}
}
/**
 	传入图片的url
 @param downloadImageUrlList url,url,url
 */
-(void)setDownloadImageUrlList:(NSString *)downloadImageUrlList{
	if (downloadImageUrlList.length > 0) {
		_downloadImageUrlList = downloadImageUrlList;
		NSArray *tDownloadImageUrlList = [downloadImageUrlList componentsSeparatedByString:@","];
		_urlOldImage = [NSMutableArray arrayWithArray:tDownloadImageUrlList];
		NSInteger tCount = 5 - tDownloadImageUrlList.count;
		if ([self.maxCountTF isEqualToString:@"1"]) {
			NSLog(@"控制器内设置了图片最多允许选择一个,不允许带入url图片!");
			[LLHudTools showLoadingMessage:@"控制器内设置了图片最多允许选择一个,不允许带入url图片!"];
			_downloadImageUrlList = nil;
			return;
		}
		self.maxCountTF =  [NSString stringWithFormat:@"%zd",tCount];
		for (int j = 0; j<tDownloadImageUrlList.count ; j ++) {
			[self.selectedPhotos addObject:[NSURL URLWithString:tDownloadImageUrlList[j]]];
			NSLog(@"%@",self.selectedPhotos);
		}
		[self.mainCollectionView reloadData];
	}
}

/**
 下载图片

 @param imageView imageView
 @param URL URL description
 @param completion 返回self
 */
- (void)configImageView:(UIImageView *)imageView URL:(NSURL *)URL completion:(void (^)(void))completion{
		[imageView sd_setImageWithURL:URL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
			if (completion) {
				completion();
			}
		}];
}

/**
 @return TZImagePickerController
 */
- (TZImagePickerController *)createTZImagePickerController{
	//self.maxCountTF.integerValue 这个数量应该时时的变动才可以
	TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCountTF.integerValue columnNumber:self.columnNumberTF.integerValue delegate:self pushPhotoPickerVc:YES];
	if (self.maxCountTF.integerValue > 1) {
		// 1.设置目前已经选中的图片数组
		imagePickerVc.selectedAssets = [self selectedAssets]; // 目前已经选中的图片数组
	}
//    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
	imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
	imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
	imagePickerVc.allowPickingVideo = NO;// 设置是否可以选择视频
	imagePickerVc.sortAscendingByModificationDate = YES; // 照片排列按修改时间升序
//	imagePickerVc.showSelectedIndex = YES;// 设置是否显示图片序号
	imagePickerVc.showSelectBtn = NO;
	imagePickerVc.allowCrop = NO;//不允许剪裁
	imagePickerVc.needCircleCrop = NO;
	imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
//      imagePickerVc.allowPickingImage = self.allowPickingImageSwitch.isOn;//允许选择照片
      imagePickerVc.allowPickingOriginalPhoto = NO;//允许选择原图
	[imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
		imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
	}];

	imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
	imagePickerVc.showPhotoCannotSelectLayer = YES;
	imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
	[imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
		[doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}];
	return imagePickerVc;
}
/**
 得到本地的图片 Assets
 @return Assets list
 */
- (NSMutableArray *)selectedAssets{
	NSMutableArray * tSelectedAssetsList = [NSMutableArray array];
	for (int i = 0; i < self.selectedPhotos.count; i ++) {
		id tSelectedAssets = self.selectedPhotos[i];
		if ([tSelectedAssets isKindOfClass:[PHAsset class]]) {
			[tSelectedAssetsList addObject:tSelectedAssets];
		}
	}
	return tSelectedAssetsList;
}
/**
 拍摄照片成功后会进来这里

 @param pImage 拍照的图片
 @param pTZImagePickerVc TZ
 */
- (void)successGitImage:(UIImage *)pImage WithTZImagePickerVc:(TZImagePickerController *)pTZImagePickerVc{
	WEAKSELF
	[[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
		[[TZImageManager manager] getAssetsFromFetchResult:model.result completion:^(NSArray<TZAssetModel *> *models) {

			[pTZImagePickerVc hideProgressHUD];
			TZAssetModel *assetModel = [models firstObject];
			if (pTZImagePickerVc.sortAscendingByModificationDate) {
				assetModel = [models lastObject];
			}
			//弱引用,这样不会有引用的问题
			[weakSelf refreshCollectionViewWithAddedAsset:assetModel.asset image:pImage];

		}];
	}];
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}
#pragma mark --- 传输图片 ---
/**
关于图片上传
 1 判断是否有网络图片
 	1.1 存在网络图片的url
 		遍历self.selectedPhotos 格式为PHAsset的循环请求 得到多个 url逐个赋值给self.imageStr 然后将网络的url添加入self.imageStr
 	1.2 不存在网络图片
 		遍历self.selectedPhotos 格式为PHAsset的循环请求 得到多个 url逐个赋值给self.imageStr
 */
- (void)uploadDatePhotosWithUrlStr:(void (^)(NSString * urlStr))pUrl{
	[self setupRequestImageUrlStr];//将本地剩余的url存储
	NSMutableArray * tImageArray = [NSMutableArray array];
	for (id tAsset in self.selectedPhotos) {
		if ([tAsset isKindOfClass:[PHAsset class]]) {
			[tImageArray addObject:tAsset];
		}
	}
//如果用户仅仅删除了图片,没有新加入图片则不做图片请求
	if (!tImageArray.count) {
				NSString *tStrUrls = nil;
				if (self.requestImageUrlStr.count) {
					tStrUrls = [self.requestImageUrlStr componentsJoinedByString:@","];
				}
				if (pUrl) {
					//当tImageArray.count不存在的时候,这时候应该是本地没有选择相册,仅仅对本地的url做了更改,在提交失败后在一次回到这里应该提前清空本地的url的list,从新加入,这样可以杜绝提交失败后,从新对本地的url图片做删除操作后,再一次提交成功后,而不生效的问题
					[self.requestImageUrlStr removeAllObjects];
					pUrl(tStrUrls);
				}
		return;
	}

	//通过PHAsset获取image
	WEAKSELF
	for (PHAsset * tAsset in tImageArray) {
		[[TZImageManager manager]getOriginalPhotoWithAsset:tAsset completion:^(UIImage *photo, NSDictionary *info) {
            NSLog(@"是否为缩略图:%@-->张数:%zd",info[PHImageResultIsDegradedKey],tImageArray.count);
            if ([[info objectForKey:PHImageResultIsDegradedKey] boolValue] == 0) {
                [weakSelf.selectImage addObject:photo];
                NSLog(@"--数量:%zd--",weakSelf.selectImage.count);
            }
            NSLog(@"图片 -----+++++ :-%zd",weakSelf.selectImage.count);
			if (weakSelf.selectImage.count  == tImageArray.count) {
				//测试取出的图片是否是选择的image
				//[weakSelf testSelImage];
				//调用网络请求....
        
                [LLHudTools showLoadingMessage:@"图片上传中~"];
                NSDictionary * param = @{@"file":@"0"};
                NSMutableArray * imgsArray = [NSMutableArray array];
                [weakSelf.selectImage enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [BXSHttp requestPOSTPhotosWithArray:@[obj] param:param AppURL:@"file/imageUpload.do" Key:@"file" success:^(id response) {
                        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
                        if ([baseModel.code integerValue] != 200) {
                            [LLHudTools showWithMessage:baseModel.msg];
                            return ;
                        }
                        [imgsArray addObject:baseModel.data[@"path"]];
                        //图片全部上传成功
                        if (imgsArray.count == weakSelf.selectImage.count) {
                            if (weakSelf.requestImageUrlStr.count) {
                                [imgsArray addObjectsFromArray:[weakSelf.requestImageUrlStr copy]];
                            }
                            NSString *tStrUrl = [imgsArray componentsJoinedByString:@","];
                            [LLHudTools dismiss];
                            if (pUrl) {
                                //将相册的list清空,同时将本地的url清空,以防用户在提交失败后,从新选择图片,或者删除网络上的图片,再一次提交
                                [weakSelf.selectImage removeAllObjects];
                                [weakSelf.requestImageUrlStr removeAllObjects];
                                pUrl(tStrUrl);
                            }
                        }
                    } failure:^(NSError *error) {
                        NSLog(@"%@",error);
                    }];
                }];
			}
		}];
	}


}
/**
 测试取出的图片是否是选择的image
 */
- (void)testSelImage{
	WEAKSELF
	weakSelf.selectedPhotos =weakSelf.selectImage;
	[weakSelf.mainCollectionView reloadData];
}
/**
 传输时取出本地剩余的url 加入 requestImageUrlStr 内
 */
- (void)setupRequestImageUrlStr{
	for (id tPhoto in self.selectedPhotos) {
		if ([tPhoto isKindOfClass:[NSURL class]]) {
			[self.requestImageUrlStr addObject:tPhoto];
		}
	}
}
@end
