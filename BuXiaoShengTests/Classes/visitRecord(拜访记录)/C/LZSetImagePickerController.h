//
//  LZSetImagePickerController.h
//  BuXiaoSheng
//
//  Created by 幸福的尾巴 on 2018/8/21.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"
@interface LZSetImagePickerController : NSObject

/**
 实例化 UIImagePickerController

 @param pImagePickerVc 需要的UIImagePickerController
 @param pVC 控制器
 @return 已经实例化的UIImagePickerController
 */
+ (UIImagePickerController *)initWithImagePickerVc:(UIImagePickerController *)pImagePickerVc withUIviewCTarget:(UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *)pVC;

/**
 设置基本的TZImagePickerController参数

 @param pImagePickerVc TZImagePickerController
 */
+ (void)setImagePickerVc:(TZImagePickerController *)pImagePickerVc;

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
  withButtonClickIndex:(void (^)(NSInteger Index))buttonClickIndex;
@end
