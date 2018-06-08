//
//  VisitRecordViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/16.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  拜访记录页面

#import "VisitRecordViewController.h"
#import "LZHTableView.h"
#import "TextInputCell.h"
#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"
#import "LZVisitRecordVC.h"
#import "LZPickerView.h"
#import "LZUploadMomentImagesCell.h"
#import "TZImagePickerController.h"
#import "LZPictureBrowseVC.h"
#import "NSArray+Utils.h"
#import <Photos/Photos.h>
@interface VisitRecordViewController ()<LZHTableViewDelegate,UITextViewDelegate,TZImagePickerControllerDelegate,LZUploadImageViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LZPictureBrowseVCDelegate,UIActionSheetDelegate>

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
@property(nonatomic,strong)LZUploadMomentImagesCell *imageCell;
///提交按钮
@property (nonatomic, strong) UIButton *commitBtn;
@property(nonatomic,strong)NSArray *typeAry;
@property(nonatomic,strong)NSString *typeStr;
@property (nonatomic,strong)UIImagePickerController *imagePicker;
@end

@implementation VisitRecordViewController
@synthesize mainTabelView,imageCell;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [Utility navTitleView:@"拜访记录"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(screenClick) image:IMAGE(@"list")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
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

- (LZUploadMomentImagesCell *)imageCell{
    
    float itemWidth=(APPWidth-5*5)/4;
    float itemHeight=itemWidth+5+5;
    if (imageCell == nil) {
        //imagesCell = [[MPUploadMomentImagesCell alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        imageCell = [[LZUploadMomentImagesCell alloc]initWithFrame:CGRectMake(0, 1, APPWidth, itemHeight)];
        imageCell.backgroundColor = [UIColor whiteColor];
        [imageCell.addBtn addTarget:self action:@selector(showAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return imageCell;
}

- (void)setSectionOne
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 10)];
    headerView.backgroundColor = LZHBackgroundColor;
    
    //拜访记录
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
    
    _mainCell = [[TextInputCell alloc]init];
    _mainCell.frame = CGRectMake(0, 0, APPWidth, 50);
    _mainCell.userInteractionEnabled = YES;
    _mainCell.titleLabel.text = @"主要事宜";
    _mainCell.contentTF.placeholder = @"请输入主要事宜";
    
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

- (void)setSectionTwo
{
    
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
    
    UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, APPWidth -15*2, 28)];
    textLbl.textColor = CD_Text33;
    textLbl.font = FONT(14);
    textLbl.text = @"图片";
    
    LZHTableViewItem *item = [[LZHTableViewItem alloc]init];
    item.sectionRows = @[textLbl,self.imageCell];
    item.canSelected = NO;
    item.sectionView = headerView;
    [self.datasource addObject:item];
}

- (void)setupUI
{
    _typeAry = [NSArray arrayWithObjects:@"当面拜访",@"电话拜访",@"聊天软件拜访",@"其他方式拜访",nil];
    
    self.datasource = [NSMutableArray array];
    self.mainTabelView.delegate = self;
    [self.view addSubview:self.mainTabelView];
    
    [self setSectionOne];
    [self setSectionTwo];
    [self setSectionThree];
    
    self.mainTabelView.dataSoure = self.datasource;
    
    self.commitBtn = [UIButton new];
    self.commitBtn.frame = CGRectMake(0, APPHeight -44, APPWidth, 44);
    self.commitBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.commitBtn addTarget:self action:@selector(commitBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
    self.commitBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.commitBtn];
}


#pragma mark ------ 点击事件 --------
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
                             @"img":@"",
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

/// MARK: ---- 上传头像
-(void)submitUserPhoto:(UIImage *)pictureimage;
{
    
    NSData *pictureData = UIImageJPEGRepresentation(pictureimage, 0.5);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

    [LLHudTools showLoadingMessage:LLLoadingMessage];
    
    NSDictionary * param = @{@"file":pictureData};
    [BXSHttp requestGETWithAppURL:@"file/imageUpload.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
       
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
//    NSString * uploadURL = [NSString stringWithFormat:@"%@%@",BXSBaseURL,@"file/imageUpload.do"];
//    [manager POST:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFileData:pictureData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"上传反馈 %@",responseObject);
//        LLBaseModel * baseModel = [LLBaseModel LLMJParse:responseObject];
//        if ([baseModel.code integerValue]!=200) {
//            [LLHudTools showWithMessage:baseModel.msg];
//            return ;
//        }
//         [LLHudTools showWithMessage:@"上传成功"];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [LLHudTools dismiss];
//        BXS_Alert(@"上传失败,请重试!");
//
//    }];
}

- (void)tapUploadImageView:(LZUploadImageView *)view {
    NSArray *uploadImagesArr = [NSArray array];
    
    //        uploadImagesArr = [self.imagesCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    
    //苗木入库
    uploadImagesArr = [self.imageCell.imageViews  arrayWithObjectProperty:@"image"];
    
    
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
    
    LZPictureBrowseVC *vc = [[LZPictureBrowseVC alloc] init];
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
    NSArray *uploadImagesArr = [self.imageCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    if (imageIndex>=uploadImagesArr.count)
    {
        return;
    }
    [self uploadImageViewDeleteImageUrl:uploadImagesArr[imageIndex]];
    
    
    
}

-(void)changeImageCellHeight{
    
    float itemWidth=(APPWidth-5*5)/4;
    float itemHeight=itemWidth+5+5;
    
    NSArray *imageNamesArr     = [imageCell.imageViews arrayWithObjectProperty:@"imageUrl"];
    if(imageNamesArr!=nil && imageNamesArr.count<4){
        
        CGRect frame=imageCell.frame;
        frame.size.height=itemHeight+5;
        imageCell.frame=frame;
        
    }else if(imageNamesArr!=nil && imageNamesArr.count>=4 && imageNamesArr.count<8){
        
        CGRect frame=imageCell.frame;
        frame.size.height=itemHeight*2+5;
        imageCell.frame=frame;
        
    }else if(imageNamesArr!=nil && imageNamesArr.count>=8){
        CGRect frame=imageCell.frame;
        frame.size.height=itemHeight*3+5;
        imageCell.frame=frame;
    }
    [self.mainTabelView reloadData];
    
}

#pragma mark ----- 选择图片上传 -----

- (void)showAction {
    
    UIActionSheet *actSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actSheet.delegate = self;
    [actSheet showInView:self.view];
    
//    [contentCell.contentView resignFirstResponder];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0)
    {
        
        /**
         *  拍照
         */
//        AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.videoQuality = UIImagePickerControllerQualityType640x480;
        self.imagePicker.delegate = self;
        [self.navigationController presentViewController:self.imagePicker animated:YES completion:NULL];
//        [appDel.window.rootViewController presentViewController:self.imagePicker animated:YES completion:NULL];
    }
    else if (buttonIndex == 1)
    {
        NSInteger max = 9 - self.imageCell.imageViews.count;
        if (max <= 0)
        {

            [LLHudTools showWithMessage:@"最多可选1张图片"];
            return ;
        }
        TZImagePickerController *tzIPC = [[TZImagePickerController alloc] initWithMaxImagesCount:max delegate:self];
        [self presentViewController:tzIPC animated:YES completion:NULL];
        
        
        
    }
    else
    {
        NSAssert(@"", nil);
    }
}

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
    
//    //判断图片数组是否已经有图片
//    if (array.count > 0) {
//        isHavePhotos = YES;
//    }else{
//        isHavePhotos = NO;
//    }
    
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
        LZUploadImageView *imageview = [[LZUploadImageView alloc] init];
        imageview.image    = image;
        imageview.imageUrl = [NSString stringWithFormat:@"%lu",(unsigned long)idx];
        imageview.delegate = weakSelf;
        [weakSelf.imageCell addImageView:imageview];
        
        [weakSelf submitUserPhoto:image];
        
    }];
//    [Utility hideMBProgress:self.view];
    
    [self changeImageCellHeight];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        /**
         *  后网络请求拿到图片的网络链接，并更换对应视图的图片链接
         */
//        [weakSelf uploadImages:images];
    });
}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapWayClick{
    LZPickerView *pickerView =[[LZPickerView alloc] initWithComponentDataArray:_typeAry titleDataArray:nil];
    
    pickerView.getPickerValue = ^(NSString *compoentString, NSString *titileString) {
//        weakSelf.principalCell.contentTF.text = compoentString;
        NSInteger row = [titileString integerValue];
//        weakSelf.priceipalId = weakSelf.principalIdAry[row];
        self.wayCell.contentTF.text = compoentString;
        _typeStr = [NSString stringWithFormat:@"%zd",row];
    };
    
    [self.view addSubview:pickerView];
}

//跳转到拜访记录列表
- (void)screenClick{
    LZVisitRecordVC *vc = [[LZVisitRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
