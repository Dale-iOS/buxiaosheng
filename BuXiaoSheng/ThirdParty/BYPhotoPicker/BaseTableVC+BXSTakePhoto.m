//
//  BaseTableVC+BXSTakePhoto.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BaseTableVC+BXSTakePhoto.h"
#import "TZImagePickerController.h"
#import "BYPhotoAddView.h"
#import "BYPhotoSelectPreveiwVC.h"
#import "BYPhotoSelect.h"
#import "YLActionSheet.h"
#import "BYCameraViewController.h"


#import <objc/runtime.h>

#define ADDTAGER = 1000

@interface BaseTableVC ()<TZImagePickerControllerDelegate,BYPhotoAddViewDelegate,BYPhotoSelectDelegate>


@property (strong,nonatomic)BYPhotoAddView *addView;
@end
@implementation BaseTableVC (BXSTakePhoto)


#pragma mark -- set ---

-(void)setAddView:(BYPhotoAddView *)addView {
    objc_setAssociatedObject(self, @selector(addView), addView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BYPhotoAddView *)addView {
    return objc_getAssociatedObject(self, _cmd);
}





/// 把添加图片的按钮放在table的footer中 选中后的图片是 selectImage
- (void)setTableFooterTakePhoto {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 140)];
    
    UIView *bacView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, APPWidth, 100)];
    [footer addSubview:bacView];
    bacView.backgroundColor = [UIColor whiteColor];
    
    UILabel *photoLable = [UILabel labelWithColor:CD_Text33 font:FONT(15)];
    photoLable.frame = CGRectMake(15, 10, 120, 15);
    photoLable.text = @"图片";
    [bacView addSubview:photoLable];
    
    CGFloat addWH = 60.f;
    
    //
    BYPhotoAddView *addView = [[BYPhotoAddView alloc]initWithFrame:CGRectMake(0, photoLable.bottom + (bacView.height - photoLable.bottom - addWH)/2, APPWidth, ((APPWidth-6*10)/5 + 30))];
    addView.delegate = self;
    addView.maxCount = 5;
    addView.maxVideoCount = 0;
    self.addView = addView;
    [bacView addSubview:addView];
    
    
    bacView.height = addView.bottom;
    footer.height = bacView.bottom + 20;
    self.mainTable.tableFooterView = footer;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"


#pragma mark ---- TZImagePickerControllerDelegate ----
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    if (photos.count > 0) {
        if (self.addView.isHadAddIcon) {
            [self.addView.photoModelArray removeLastObject];
        }
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.addView.photoModelArray];
        for (PHAsset *asset in assets) {
            BYPhotoModel *model = [[BYPhotoModel alloc]initWithAsset:asset];
            [array addObject:model];
        }
        
        self.addView.photoModelArray = array;
        
    }
}
- (void)didSelectPhotoModel:(NSArray <BYPhotoModel *>*)phtotoArray {
    [self.addView.photoModelArray removeAllObjects];
    NSMutableArray  *array = [NSMutableArray arrayWithArray:phtotoArray];
    self.addView.photoModelArray = array;
    
}
#pragma mark - Click

- (NSArray *)getPhotos {
    NSMutableArray *allSelectArray = [self.addView.photoModelArray mutableCopy];
    if (self.addView.isHadAddIcon) {
        [allSelectArray removeLastObject];
    }
    
    return allSelectArray;
}

- (void)takePhoto {
    
    BYCameraViewController *VC = [[BYCameraViewController alloc]init];
    VC.CameraType = BYCameraViewTypeTakePhoto;
    [self presentViewController:VC animated:YES completion:^{
        
    }];
    // [self.navigationController pushViewController:VC animated:YES];
    WEAKSELF;
    VC.completionHandler = ^(PHAsset *asset) {
        
        [weakSelf.addView.photoModelArray removeLastObject];
        
        __block  BYPhotoModel *photoModel = [[BYPhotoModel alloc]initWithAsset:asset completion:^{}];
        
        [photoModel loadThumImage:^{
            NSMutableArray  *array = [NSMutableArray arrayWithArray:weakSelf.addView.photoModelArray];
            [array addObject:photoModel];
            weakSelf.addView.photoModelArray = array;
        }];
    };
   
}

/// 从相册选择
- (void)selectFromAlbum {
    
    BYPhotoSelectConfig *config = [[BYPhotoSelectConfig alloc]initWithMaxPhoto:5 maxVideo:0];
    BYPhotoSelect *photo = [[BYPhotoSelect alloc]initWithConfig:config];
    photo.delegate = self;
    
    if (self.addView.selectType == BYPhotoModelTypeVideo) {
        photo.onlySelectVideo = YES;
    }else{
        
    }
    photo.selectPhotos = [self.addView.photoModelArray copy];
    NSLog(@"%@",[NSDate date]);
    [self.navigationController pushViewController:photo animated:YES];
}

#pragma mark ---- BYPhotoAddViewDelegate ----
/// 添加图片
- (void)clickAddButton {
    
    
    NSArray *imageArr = @[@"相机",@"图片 copy 2"];
    NSArray *titlesArr = @[@"拍摄图片",@"从手机相册选择"];
    YLActionSheet *sheet = [[YLActionSheet alloc]initWithT:nil withDelegate:nil actionTitles:titlesArr, nil];
    sheet.imageArr = imageArr;
    
    WEAKSELF;
    sheet.clickSheetBlock = ^(NSUInteger atIndex) {
        if (atIndex == 0) {
            [weakSelf takePhoto];
        }else if (atIndex == 1){
            [weakSelf selectFromAlbum];
        }
    };
    [sheet showInView:self.view];
    
//    TZImagePickerController *picker = [[TZImagePickerController  alloc]initWithMaxImagesCount:5 - self.selectImages.count delegate:self];
//    picker.allowTakeVideo = NO;
//    picker.sortAscendingByModificationDate = YES;
//    [self presentViewController:picker animated:YES completion:^{
//
//    }];
}
- (void)clickSubviewAtIndex:(NSUInteger)index {
    
    BYPhotoModel *model = self.addView.photoModelArray[index];
    BYPhotoSelectPreveiwVC *VC = [[BYPhotoSelectPreveiwVC alloc]initWithPhoto:model];
    [self presentViewController:VC animated:YES completion:^{
        
    }];
}
- (void)didDelectPhotoModel {
    
 
}

#pragma clang diagnostic pop



@end
