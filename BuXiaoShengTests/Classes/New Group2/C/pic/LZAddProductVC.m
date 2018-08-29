//
//  LZAddProductVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/8/29.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZAddProductVC.h"
#import "MPPictureBrowseViewController.h"
#import "TZImagePickerController.h"
#import "LZHTableView.h"
#import "MPUploadMomentImagesCell.h"
#import "NSArray+Utils.h"

@interface LZAddProductVC ()<LZHTableViewDelegate,TZImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, MPUploadImageViewDelegate,UIAlertViewDelegate, MPPictureBrowseViewControllerDelegate,UIActionSheetDelegate>
{
    BOOL isHavePhotos;///是否已经上传图片
}
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,weak)LZHTableView *mainTV;
@property (nonatomic,strong) MPUploadMomentImagesCell *imagesCell;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@property (nonatomic,strong)NSMutableArray *imagesArray;
@property (nonatomic,assign)BOOL isWaitEditImageUpload;
@property (nonatomic,assign)BOOL isWaitCreatImageUpload;
@end

@implementation LZAddProductVC
@synthesize mainTV;
@synthesize imagesCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(toRelease)];
    
    self.dataSource = [NSMutableArray array];
    
    
    [self.view addSubview:self.mainTV];
    
    [self initialSectionOne];
    
    self.mainTV.dataSoure = self.dataSource;
    self.mainTV.delegate = self;
    
}

#pragma mark ------------- 初始化控件 -----------

- (LZHTableView *)mainTV {
    if (mainTV == nil)
    {
        //JPTableView *table = [[JPTableView alloc] initWithFrame:CGRectMake(0,0, APPWidth, CONTENT_HEIGHT - UIAdaptiveRate(64))];
        LZHTableView *table = [[LZHTableView alloc] initWithFrame:CGRectMake(0,0, APPWidth, CONTENT_HEIGHT)];
        [self.view addSubview:(mainTV = table)];
    }
    return mainTV;
}

- (MPUploadMomentImagesCell *)imagesCell {
    
    
    float itemWidth=(APPWidth-5*5)/4;
    float itemHeight=itemWidth+5+5;
    if (!imagesCell) {
        //imagesCell = [[MPUploadMomentImagesCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 110)];
        imagesCell = [[MPUploadMomentImagesCell alloc]initWithFrame:CGRectMake(0, 0, APPWidth, itemHeight)];
        imagesCell.backgroundColor = [UIColor whiteColor];
        [imagesCell.addBtn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return imagesCell;
}





- (void)initialSectionOne {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPWidth,10)];
    headerView.backgroundColor = [UIColor clearColor];
    LZHTableViewItem *item = [[LZHTableViewItem alloc] init];
    item.sectionRows = @[self.imagesCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.dataSource addObject:item];
}


#pragma mark ------------- 按钮点击事件 -----------

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toRelease {
    
    
    
    
}



#pragma mark ----------------------------------- 选择图片上传 ---------------------

- (void)showAction {
    
    UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actSheet.delegate = self;
    [actSheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        /**
         *  拍照
         */
//        AppDelegate *appDel = SHARED_APP_DELEGATE;
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.videoQuality = UIImagePickerControllerQualityType640x480;
        self.imagePicker.delegate = self;
//        [appDel.window.rootViewController presentViewController:self.imagePicker animated:YES completion:NULL];
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        
    }
    else if (buttonIndex == 1)
    {
        NSInteger max = 9 - self.imagesCell.imageViews.count;
        if (max <= 0)
        {
//            [Utility showToastWithMessage:@"最多可选9张图片"];
            return ;
        }
        TZImagePickerController *tzIPC = [[TZImagePickerController alloc] initWithMaxImagesCount:max delegate:self];
        [self presentViewController:tzIPC animated:YES completion:NULL];
    }
    else
    {
//        NSAssert(@"", nil);
    }
}

- (void)checkIsHaveUploadFaieldImage {
    /**
     *  避免出现链接有误的照片上传
     */
    NSArray *imageNamesArr     = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    [imageNamesArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length <=1)
        {
            if (idx>=self.imagesCell.imageViews.count)
            {
                return;
            }
            MPUploadImageView *temp = self.imagesCell.imageViews[idx];
//            [self postImageWithImage:temp.image Index:idx];
        }
    }];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil)
    {
        /**
         *  先展示
         */
        [self showImageViewWithArray:@[image]];
    }
}

/*
 - (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos {
 NSMutableArray *array = [NSMutableArray array];
 for (int i = 0; i < photos.count; i++)
 {
 UIImage *image = photos[i];
 if (image != nil)
 {
 [array addObject:image];
 }
 }
 //先展示
 
 [self showImageViewWithArray:array];
 }
 */


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < photos.count; i++)
    {
        UIImage *image = photos[i];
        if (image != nil)
        {
            [array addObject:image];
        }
    }
    
    //判断图片数组是否已经有图片
    if (array.count > 0) {
        isHavePhotos = YES;
    }else{
        isHavePhotos = NO;
    }
    
    //先展示
    [self showImageViewWithArray:array];
}

- (void)showImageViewWithArray:(NSArray *)images {
    /**
     *  网络正常情况下才去展示
     */
//    if (![Utility isConnectionAvailable])
//    {
//        [Utility showToastWithMessage:@"网络未连接"];
//        return;
//    }
    /**
     * 添加图片视图
     */
//    [Utility showMBProgress:self.view message:@"上传中"];
    WEAKSELF
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
        MPUploadImageView *imageview = [[MPUploadImageView alloc] init];
        imageview.image    = image;
        imageview.imageUrl = [NSString stringWithFormat:@"%lu",(unsigned long)idx];
        imageview.delegate = weakSelf;
        [weakSelf.imagesCell addImageView:imageview];
    }];
//    [Utility hideMBProgress:self.view];
    
    [self changeImageCellHeight];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        /**
         *  后网络请求拿到图片的网络链接，并更换对应视图的图片链接
         */
        [weakSelf uploadImages:images];
    });
}

- (void)uploadImages:(NSArray *)images {
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self postImageWithImage:image Index:idx];
    }];
}

//- (void)postImageWithImage:(UIImage *)image Index:(NSUInteger)index {
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    NSData *imageData = [UIImage compressMyImage:image size:300];
//
//    [param setPObject:imageData forKey:@"img"];
//    WEAKSELF
//    [manager POSTImage:kUpdateImage parameters:param queue:nil success:^(id responseObject) {
//        NSString *imageUrl = [responseObject stringObjectForKey:@"data"];
//        [weakSelf.imagesCell changeImageViewImageurlWithOriginUrl:[NSString stringWithFormat:@"%lu",(unsigned long)index] NowUrl:imageUrl];
//        //        [weakSelf postImgSuccess];
//    } failure:^(NSString *error) {
//        /**
//         *  如果某一张图片上传失败，继续上传
//         */
//        [weakSelf postImageWithImage:image Index:index];
//    }];
//}

//- (void)postImgSuccess
//{
//    if (self.isWaitEditImageUpload && [self canDoNextStep]) {
//        [self saveEdit];
//    } else if (self.isWaitCreatImageUpload && [self canDoNextStep]) {
//        [self confirmTree:self.status];
//    }
//}

- (BOOL)canDoNextStep
{
    NSArray *imageNamesArr     = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    NSInteger i = 0;
    for (NSString * obj in imageNamesArr) {
        if (obj.length !=1){
            i++;
            if (i == [imageNamesArr count]) {
                return YES;
            }
        }
    };
    return NO;
}

#pragma mark - MPUploadImageViewDelegate 上传的图片点击事件

- (void)uploadImageViewDeleteImageUrl:(NSString *)url {
    
    
    [self.imagesCell removeImageViewByUrl:url];
    [self.imagesArray removeObject:url];
    
    [self changeImageCellHeight];
    
    
}

- (void)tapUploadImageView:(MPUploadImageView *)view {
    NSArray *uploadImagesArr = [NSArray array];
    
    //        uploadImagesArr = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    
    //苗木入库
    uploadImagesArr = [self.imagesCell.imageViews arrayWithObjectProperty:@"image"];
    
    
    if (uploadImagesArr.count == 0)
    {
        return;
    }
    
    
    //当前点击的图片索引
    //        NSInteger tempIndex = [uploadImagesArr indexOfObject:view.imageUrl];
    //
    //        MPPictureBrowseViewController *vc = [[MPPictureBrowseViewController alloc] init];
    //        vc.imageUrl      = view.imageUrl;
    //        vc.showIndex     = tempIndex;
    //        vc.showImagesArr = [NSMutableArray arrayWithArray:uploadImagesArr];
    //        vc.delegate = self;
    //        [self.navigationController pushViewController:vc animated:YES];
    
    //        //当前点击的图片索引
    NSInteger tempIndex = [uploadImagesArr indexOfObject:view.imageView.image];
    
    MPPictureBrowseViewController *vc = [[MPPictureBrowseViewController alloc] init];
    vc.imageUrl      = view.imageUrl;
    vc.image         = view.imageView.image;
    vc.showIndex     = tempIndex;
    vc.showImagesArr = [NSMutableArray arrayWithArray:uploadImagesArr];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - MPPictureBrowseViewControllerDelegate

- (void)didDeletePicture:(NSString *)imageUrl {
    
    
    [self uploadImageViewDeleteImageUrl:imageUrl];
}

- (void)deleteImageWithImageIndex:(NSInteger)imageIndex {
    NSArray *uploadImagesArr = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    if (imageIndex>=uploadImagesArr.count)
    {
        return;
    }
    [self uploadImageViewDeleteImageUrl:uploadImagesArr[imageIndex]];
    
}

-(void)changeImageCellHeight{
    
    float itemWidth=(APPWidth-5*5)/4;
    float itemHeight=itemWidth+5+5;
    
    NSArray *imageNamesArr     = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    if(imageNamesArr!=nil && imageNamesArr.count<4){
        
        CGRect frame=imagesCell.frame;
        frame.size.height=itemHeight+5;
        imagesCell.frame=frame;
        
    }else if(imageNamesArr!=nil && imageNamesArr.count>=4 && imageNamesArr.count<8){
        
        CGRect frame=imagesCell.frame;
        frame.size.height=itemHeight*2+5;
        imagesCell.frame=frame;
        
    }else if(imageNamesArr!=nil && imageNamesArr.count>=8){
        CGRect frame=imagesCell.frame;
        frame.size.height=itemHeight*3+5;
        imagesCell.frame=frame;
    }
    [self.mainTV reloadData];
    
}

#pragma mark ----------  网络请求  ------------
- (void)querySendMoment {
    
    /**
     *  避免出现链接有误的照片上传
     */
    NSArray *imageNamesArr     = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    NSMutableArray *imageNames = [NSMutableArray array];
    
    for (NSString * obj in imageNamesArr) {
        if (obj.length !=1)
        {
            [imageNames addObject:obj];
        }
        else
        {
            _isWaitEditImageUpload = YES;
            WEAKSELF
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^{
                [weakSelf checkIsHaveUploadFaieldImage];
            });
            return;
        }
    }
    
    
    
//    HWHTTPRequestOperationManager *manager = [HWHTTPRequestOperationManager manager];
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//
//    [param setPObject:[imageNames componentsJoinedByString:@","] forKey:@"image_list"];
//
//
//    [manager POST:kSendMoment parameters:param queue:nil success:^(id response) {
//
//        //        NSLog(@"998 %@",response);
//
//    } failure:^(NSString *code, NSString *error) {
//        [Utility showToastWithMessage:error];
//    }];
    
    
}


- (void)dealloc {
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:kSelectTreeNameSuccessNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

