//
//  MPUploadMomentImagesCell.h
//  TemplateTest
//
//  Created by ios on 2018/1/31.
//  Copyright © 2018年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPUploadImageView.h"

typedef void(^AddImageBlock)(void);

@interface MPUploadMomentImagesCell : UIView

@property (nonatomic, weak) UIScrollView *sv;
/**
 * 存放的是MPUploadImageView对象
 */
@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) UIButton *addBtn;

/**
 *  添加MPUploadImageView视图对象
 *
 *  @param imageview MPUploadImageView对象
 */
- (void)addImageView:(MPUploadImageView *)imageview;

/**
 *  移除指定图片链接所在的图片视图对象
 *
 *  @param url 当前要移除的视图的图片链接
 */
- (void)removeImageViewByUrl:(NSString *)url;

/**
 *  更改指定图片链接所在视图的图片链接,不影响图片视图的个数和其他属性值
 *
 *  @param originUrl 原始的图片链接
 *  @param nowUrl    最新的图片链接
 */
- (void)changeImageViewImageurlWithOriginUrl:(NSString *)originUrl NowUrl:(NSString *)nowUrl;

- (void)updateImageViewsConstraints;


@end
