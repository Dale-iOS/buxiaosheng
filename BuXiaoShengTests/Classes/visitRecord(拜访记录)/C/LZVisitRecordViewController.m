//
//  LZVisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录页面

#import "LZVisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitRecordListVC.h"
#import "LZPickerView.h"
#import "UITextField+PopOver.h"

//图片:
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"
#import "TZAssetCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "LZSetImagePickerController.h"
#define Max_Photos 1 //最大选择照片总数
#define Max_LinePhotos 4 //选择图片页面每一行最大数

@interface LZVisitRecordViewController ()<LZHTableViewDelegate,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
    NSString *_imageStr;
}
@property (weak, nonatomic) LZHTableView *mainTabelView;
@property (strong, nonatomic) NSMutableArray *datasource;
///拜访对象
@property (nonatomic, strong) TextInputCell *objectCell;
///拜访方式
@property (nonatomic, strong) TextInputCell *wayCell;
///主要事宜
@property (nonatomic, strong) TextInputCell *mainCell;
///拜访结果
@property (nonatomic, strong) TextInputTextView *resultView;
///备注
@property (nonatomic, strong) TextInputTextView *remarkView;
///上传图片的标题
@property(nonatomic,strong) UILabel *textLbl;
///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;
@property(nonatomic,strong)NSString *typeStr;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) CLLocation *location;

//客户数组
@property(nonatomic,strong)NSMutableArray *customerList;
@property(nonatomic,strong)NSMutableArray *customerNameAry;
@property(nonatomic,strong)NSMutableArray *customerPhoneAry;
@property(nonatomic,strong)NSMutableArray *customerIdAry;
//@property (nonatomic, copy)NSString *customerIdStr;///选中的客户id
@end

@implementation LZVisitRecordViewController
@synthesize mainTabelView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self setupCustomerList];
}

- (void)setupUI{
    
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenClick) image:IMAGE(@"new_lists")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据初始化
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    _typeAry = [NSArray arrayWithObjects:@"当面拜访",@"电话拜访",@"聊天软件拜访",@"其他方式拜访",nil];
    
    [self configCollectionView];
    
    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self.view addSubview:self.mainTabelView];
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    self.commitBtn = [UIButton new];
    self.commitBtn.frame = CGRectMake(0, APPHeight -45, APPWidth, 45);
    self.commitBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.commitBtn];
}

- (LZHTableView *)mainTabelView
{
    if (!mainTabelView) {
        
        LZHTableView *tableView = [[LZHTableView alloc]initWithFrame:CGRectMake(0, 64, APPWidth, APPHeight -44-64)];
        tableView.tableView.allowsSelection = YES;
        tableView.backgroundColor = LZHBackgroundColor;
        [self.view addSubview:(mainTabelView = tableView)];
    }
    return mainTabelView;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //拜访对象
    _objectCell = [[TextInputCell alloc]init];
    _objectCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _objectCell.userInteractionEnabled = YES;
    _objectCell.titleLabel.text = @"拜访对象";
    _objectCell.contentTF.placeholder = @"请输入拜访对象";
    
    
    //拜访记录
    _wayCell = [[TextInputCell alloc]init];
    _wayCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _wayCell.userInteractionEnabled = YES;
    _wayCell.rightArrowImageVIew.hidden = NO;
    _wayCell.titleLabel.text = @"拜访方式";
    _wayCell.contentTF.placeholder = @"请选择拜访方式";
    _wayCell.contentTF.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWayClick)];
    [_wayCell addGestureRecognizer:tap];
    
    //主要事宜
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
    //拜访结果
    _resultView = [[TextInputTextView alloc]init];
    _resultView.frame = CGRectMake(0, 0, APPWidth, 80);
    //    self.resultView.userInteractionEnabled = YES;
    _resultView.textView.delegate = self;
    _resultView.titleLabel.text = @"拜访结果";
    _resultView.textView.placeholder = @"请输入拜访结果";
    
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_objectCell,_wayCell,_mainCell,_resultView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
    
}

- (void)setSectionTwo{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _remarkView = [[TextInputTextView alloc]init];
    _remarkView.frame = CGRectMake(0, 0, APPWidth, 80);
    _remarkView.textView.delegate = self;
    
    _remarkView.titleLabel.text = @"备注";
    _remarkView.textView.placeholder = @"请输入告知仓库事项";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_remarkView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setSectionThree{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    _textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, APPWidth -15*2, 40)];
    _textLbl.textColor = CD_Text33;
    _textLbl.font = FONT(14);
    _textLbl.text = @"图片";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[_textLbl,self.collectionView];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

//跳转到拜访记录列表
- (void)screenClick{
    LZVisitRecordListVC *vc = [[LZVisitRecordListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tapWayClick{
	[self.view endEditing:YES];
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_typeAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
        NSInteger row = [titileString integerValue];
        self.wayCell.contentTF.text = compoentString;
        _typeStr = [NSString stringWithFormat:@"%zd",row];
    };
    
    [self.view addSubview:pickerView];
}


#pragma mark ---- 网络请求 ----
//功能用到客户列表
- (void)setupCustomerList{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId};
    [BXSHttp requestGETWithAppURL:@"customer/customer_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _customerList = baseModel.data;
        _customerNameAry = [NSMutableArray array];
        _customerIdAry = [NSMutableArray array];
        _customerPhoneAry = [NSMutableArray array];
        for (int i = 0 ; i <_customerList.count; i++) {
            [_customerNameAry addObject:_customerList[i][@"name"]];
            [_customerIdAry addObject:_customerList[i][@"id"]];
            [_customerPhoneAry addObject:_customerList[i][@"mobile"]];
        }
        WEAKSELF;
        self.objectCell.contentTF.delegate = self;
        self.objectCell.contentTF.scrollView = (UIScrollView *)self.view;
        self.objectCell.contentTF.positionType = ZJPositionBottomThree;
        [self.objectCell.contentTF popOverSource:_customerNameAry index:^(NSInteger index) {
            weakSelf.objectCell.contentTF.text = _customerNameAry[index];
//            _customerIdStr = _customerIdAry[index];
        }];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

//接口名称 图片上传
- (void)uploadPhotos:(NSArray *)selectArray{
    [LLHudTools showLoadingMessage:@"图片上传中~"];
    NSDictionary * param = @{@"file":@"0"};
    [BXSHttp requestPOSTPhotosWithArray:selectArray param:param AppURL:@"file/imageUpload.do" Key:@"file" success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        NSDictionary *tempDic = baseModel.data;
        _imageStr = tempDic[@"path"];
        [LLHudTools dismiss];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//接口名称 添加拜访记录
//提交点击按钮
- (void)commitBtnOnClickAction
{
    if ([BXSTools stringIsNullOrEmpty:self.objectCell.contentTF.text]) {
        BXS_Alert(@"请输入拜访对象名称");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.mainCell.contentTF.text]) {
        BXS_Alert(@"请输入主要事宜");
        return;
    }
    if ([BXSTools stringIsNullOrEmpty:self.resultView.textView.text]) {
        BXS_Alert(@"请输入拜访结果");
        return;
    }
    
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"img":_imageStr ,
                             @"matters":self.mainCell.contentTF.text,
                             @"name":self.objectCell.contentTF.text,
                             @"remark":self.remarkView.textView.text,
                             @"result":self.resultView.textView.text,
                             @"type":_typeStr
                             };
    [BXSHttp requestGETWithAppURL:@"record/add.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        [LLHudTools showWithMessage:baseModel.msg];
        if ([baseModel.code integerValue] != 200) {
            return ;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark --- 选择图片 ---
- (UIImagePickerController *)imagePickerVc{
    if (_imagePickerVc == nil) {
		_imagePickerVc = [LZSetImagePickerController initWithImagePickerVc:_imagePickerVc withUIviewCTarget:self];
    }
    return _imagePickerVc;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) collectionViewLayout:_layout];
//    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(1, 10, 1, 1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 4 - _margin -20;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumInteritemSpacing = 1;
    _layout.minimumLineSpacing = 1;
    [self.collectionView setCollectionViewLayout:_layout];
	//禁止滚动, 直接滚动到底部
	self.collectionView.scrollEnabled = NO;
	[self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + 10) animated:NO];
	[self.collectionView reloadData];
}

#pragma mark UICollectionView
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 10, 1, 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count >= Max_Photos) {
        return _selectedPhotos.count;
    }
    
    //根据cell的数量，更改collectionView的frame
    CGFloat tempH = _itemWH +10;
	self.collectionView.frame = CGRectMake(0, 0, APPWidth, tempH);
    [self.mainTabelView reloadData];
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.item == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"add_image"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.item];
        cell.asset = _selectedAssets[indexPath.item];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _selectedPhotos.count) {
		[LZSetImagePickerController showAlertStyle:UIAlertControllerStyleActionSheet
									  withTitleStr:nil withMessageStr:nil
		withBtn1TitleStr:@"拍照" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"去相册选择" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:@"取消" withBtn3ActionStyle:UIAlertActionStyleCancel
		    withCTarget:self withButtonClickIndex:^(NSInteger Index) {
				if (Index == 1) {
					[self takePhoto];
				}else if (Index == 2){
					[self pushTZImagePickerController];
				}
		}];
    } else { //预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.item];
        imagePickerVc.maxImagesCount = Max_Photos;
        imagePickerVc.allowPickingGif = NO;
        imagePickerVc.allowPickingOriginalPhoto = YES;
        imagePickerVc.allowPickingMultipleVideo = NO;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self->_selectedPhotos = [NSMutableArray arrayWithArray:photos];
            self->_selectedAssets = [NSMutableArray arrayWithArray:assets];
            self->_isSelectOriginalPhoto = isSelectOriginalPhoto;
            [self->_collectionView reloadData];
            self->_collectionView.contentSize = CGSizeMake(0, ((self->_selectedPhotos.count + 2) / 3 ) * (self->_margin + self->_itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:Max_Photos columnNumber:Max_LinePhotos delegate:self pushPhotoPickerVc:YES];
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
	imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
	imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
	[LZSetImagePickerController setImagePickerVc:imagePickerVc];
	// 设置竖屏下的裁剪尺寸
	NSInteger left = 30;
	NSInteger widthHeight = self.view.tz_width - 2 * left;
	NSInteger top = (self.view.tz_height - widthHeight) / 2;
	imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
	imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;

	// 设置是否显示图片序号
	imagePickerVc.showSelectedIndex = NO;
	#pragma mark - 到这里为止
	// 你可以通过block或者代理，来得到用户选择的照片.
	[imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
	}];
	[self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControlle
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
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
//        // 无相机权限 做一个友好的提示
//        [LZSetImagePickerController showAlertStyle:UIAlertControllerStyleAlert
//                                      withTitleStr:@"无法使用相机"
//                                    withMessageStr:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
//                withBtn1TitleStr:@"设置" withBtn1ActionStyle:UIAlertActionStyleDefault withBtn2TitleStr:@"取消" withBtn2ActionStyle:UIAlertActionStyleDestructive withBtn3TitleStr:nil withBtn3ActionStyle:UIAlertActionStyleDefault withCTarget:self withButtonClickIndex:^(NSInteger Index) {
//            if (Index == 1) {
//                // 去设置界面，开启相机访问权限
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            }
//        }];
//    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
//        //防止用户首次拍照拒绝授权时相机页黑屏
//            //[self takePhoto];
//        // 拍照之前还需要检查相册权限
//    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
//        BXS_Alert(@"无法访问相册\r\n请在iPhone的""设置-隐私-相册""中允许访问相册");
//    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
//        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
//           // [self takePhoto];
//        }];
//    } else {
//        [self pushImagePickerController];
//    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
		_imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:NO completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];

	_selectedPhotos = [NSMutableArray arrayWithArray:@[image]];
	[self uploadPhotos:_selectedPhotos];

    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSLog(@"location:%@",phAsset.location);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - TZImagePickerControllerDelegate
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
	[_collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
    [_collectionView reloadData];
    // 1.打印图片名字
    [self printAssetsName:assets];
    // 2.图片位置信息
	for (PHAsset *phAsset in assets) {
		NSLog(@"location:%@",phAsset.location);
	}
    [self uploadPhotos:_selectedPhotos];
}
#pragma mark - Click Event
//图片删除按钮
- (void)deleteBtnClik:(UIButton *)sender {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [_selectedAssets removeObjectAtIndex:sender.tag];
		[self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height + 10) animated:NO];
        [self.collectionView reloadData];
        return;
    }
    
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
		[_collectionView setContentOffset:CGPointMake(0, _collectionView.contentSize.height - _collectionView.frame.size.height + 10) animated:NO];
        [self->_collectionView reloadData];
    }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
//// 决定相册显示与否
//- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
//    return YES;
//}
//// 决定asset显示与否
//- (BOOL)isAssetCanSelect:(id)asset {
//    return YES;
//}
