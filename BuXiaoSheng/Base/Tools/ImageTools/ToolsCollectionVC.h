//
//  ToolsCollectionVC.h
//  UICollectionViewss
//
//  Created by 幸福的尾巴 on 2018/8/30.
//  Copyright © 2018年 幸福的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolsCollectionVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *mainCollectionView;
@property(nonatomic,strong)UIViewController *cTarget;
/**
 从服务的回来的url地址,用来下载用的 url,url,url
 */
@property(nonatomic,copy)NSString * downloadImageUrlList;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;//选择的图片
@property (nonatomic,copy)  NSString *maxCountTF;  // 照片最大可选张数，设置为1即为单选模式
@property (nonatomic,copy)  NSString *columnNumberTF;//相册内每行展示照片张数
@property (nonatomic,copy)NSString * imageStr; //最终上传的url的str url,url,url.....

/**
 设置 UICollectionView

 @param pFrame pFrame
 */
- (void)setupMainCollectionViewWithFrame:(CGRect)pFrame;
#pragma mark --- 传输图片 ---
//接口名称 图片上传 写个blick回调 上传成功后将url返回去 就ok了
- (void)uploadDatePhotosWithUrlStr:(void (^)(NSString * urlStr))pUrl;
@end
