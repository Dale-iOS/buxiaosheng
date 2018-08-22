//
//  LZSetImagePickerController.m
//  BuXiaoSheng
//
//  Created by 幸福的尾巴 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZSetImagePickerController.h"

@implementation LZSetImagePickerController
/**
 实例化 UIImagePickerController

 @param pImagePickerVc 需要的UIImagePickerController
 @param pVC 控制器
 @return 已经实例化的UIImagePickerController
 */
+ (UIImagePickerController *)initWithImagePickerVc:(UIImagePickerController *)pImagePickerVc withUIviewCTarget:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)pVC{
	pImagePickerVc = [[UIImagePickerController alloc]init];
	pImagePickerVc.delegate = pVC;
	// set appearance / 改变相册选择页的导航栏外观
	pImagePickerVc.navigationBar.barTintColor = pVC.navigationController.navigationBar.barTintColor;
	pImagePickerVc.navigationBar.tintColor = pVC.navigationController.navigationBar.tintColor;
	UIBarButtonItem *tzBarItem, *BarItem;
	tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
	BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
	NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
	[BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
	return pImagePickerVc;
}
/**
 设置基本的TZImagePickerController参数

 @param pImagePickerVc TZImagePickerController
 */
+ (void)setImagePickerVc:(TZImagePickerController *)pImagePickerVc{

	pImagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
	pImagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
	pImagePickerVc.videoMaximumDuration = 10; // 视频最大拍摄时间
	[pImagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
		imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
	}];
	pImagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
	pImagePickerVc.showPhotoCannotSelectLayer = YES;
	pImagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
	[pImagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
		[doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	}];
	// 3. 设置是否可以选择视频/图片/原图
	pImagePickerVc.allowPickingVideo = NO;
	pImagePickerVc.allowPickingImage = YES;
	pImagePickerVc.allowPickingOriginalPhoto = YES;
	pImagePickerVc.allowPickingGif = NO;
	pImagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频

	// 4. 照片排列按修改时间升序
	pImagePickerVc.sortAscendingByModificationDate = YES;

	/// 5. 单选模式,maxImagesCount为1时才生效
	pImagePickerVc.showSelectBtn = NO;
	pImagePickerVc.allowCrop = NO;
	pImagePickerVc.needCircleCrop = NO;
}
/**
 弹出提示

 @param pAlertControllerStyle alt的类型
 @param pTitle 提示str
 @param pMessage 副标题提示str
 @param pBtn1Title btn1的标题str
 @param pBtn1ActionStyle btn1的样式
 @param pBtn2Title btn2的标题str
 @param pBtn2ActionStyle btn2的样式
 @param pBtn3Title btn3的标题str
 @param pBtn3ActionStyle btn3的样式
 @param pCTarget 控制器
 @param buttonClickIndex 点击了第几个btn
 */
+ (void)showAlertStyle:(UIAlertControllerStyle )pAlertControllerStyle
		  withTitleStr:(NSString *)pTitle
		withMessageStr:(NSString *)pMessage
	  withBtn1TitleStr:(NSString *)pBtn1Title
   withBtn1ActionStyle:(UIAlertActionStyle)pBtn1ActionStyle
	  withBtn2TitleStr:(NSString *)pBtn2Title
   withBtn2ActionStyle:(UIAlertActionStyle)pBtn2ActionStyle
	  withBtn3TitleStr:(NSString *)pBtn3Title
   withBtn3ActionStyle:(UIAlertActionStyle)pBtn3ActionStyle
		   withCTarget:(UIViewController *)pCTarget
  withButtonClickIndex:(void (^)(NSInteger Index))buttonClickIndex{

	UIAlertController * tAlertController = [UIAlertController alertControllerWithTitle:pTitle message:pMessage preferredStyle:pAlertControllerStyle];
	UIAlertAction *tBtn1 ,*tBtn2, *tBtn3;
	if (pBtn1Title != nil) {
		tBtn1 = [UIAlertAction actionWithTitle:pBtn1Title style:pBtn1ActionStyle handler:^(UIAlertAction * _Nonnull action) {
			buttonClickIndex(1);
		}];
		[tAlertController addAction:tBtn1];
	}

	if (pBtn1Title != nil) {
		tBtn2 = [UIAlertAction actionWithTitle:pBtn2Title style:pBtn2ActionStyle handler:^(UIAlertAction * _Nonnull action) {
			buttonClickIndex(2);
		}];
		[tAlertController addAction:tBtn2];
	}

	if (pBtn3Title != nil) {
		tBtn3 = [UIAlertAction actionWithTitle:pBtn3Title style:pBtn3ActionStyle handler:^(UIAlertAction * _Nonnull action) {
			buttonClickIndex(3);
		}];
		[tAlertController addAction:tBtn3];
	}

	[pCTarget presentViewController:tAlertController animated:YES completion:nil];
}

@end
