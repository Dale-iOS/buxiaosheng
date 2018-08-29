//
//  MPUploadImageView.h
//  TemplateTest
//
//  Created by caijingpeng on 16/5/15.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPUploadImageView;

@protocol MPUploadImageViewDelegate <NSObject>

@optional

/**
 * 删除图片按钮点击事件
 *
 *  @param url 当前删除的图片链接
 */
- (void)uploadImageViewDeleteImageUrl:(NSString *)url;

/**
 *  图片点击事件
 *
 *  @param view 当前点击的图片所在的视图
 */
- (void)tapUploadImageView:(MPUploadImageView *)view;

@end

@interface MPUploadImageView : UIView

/**
 *  图片上的删除按钮
 */
@property (nonatomic, strong) UIButton *deleteButton;
/**
 *  图片链接
 */
@property (nonatomic, strong) NSString *imageUrl;
/**
 *  图片
 */
@property (nonatomic, strong) UIImage  *image;
/**
 *  显示图片的视图
 */
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id<MPUploadImageViewDelegate> delegate;


@end

