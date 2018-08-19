//
//  BaseTableVC+BXSTakePhoto.h
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/8/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  ///相册选择 --多处用到写成分类避免冗余

#import "BaseTableVC.h" 

@interface BaseTableVC (BXSTakePhoto) 
 
/// BYPhotoModel 模型数组
- (NSArray *)getPhotos;

/// 把添加图片的按钮放在table的footer中 选中后的图片是 selectImage
- (void)setTableFooterTakePhoto;


/*
 注释：
 1 全部的图片在 selectImages --这个里面是BYPhotoModel对象
 2 小图就是 thumPhotoImage --{364, 256}
 3 太小可以自己用BYPhotoTool请求得到大图
 
 WEAKSELF;
 for (int i=0; i<self.selectPhotos.count;i++) {
 __block  BYPhotoModel *model = [self.selectPhotos objectAtIndex:i];
 [BYPhotoTool getOriginPhotoImageWithAsset:model.asset completion:^(UIImage *originImage, NSDictionary *info) {
 model.originPhotoImage = originImage;
 
 [weakSelf.mainCollection reloadData];
 }];
 }
 
 具体可以自己看 BYPhotoTool内部代码 -- 到时候有问题再QQ我吧 -472968966
 */
@end
