//
//  LZUploadImageView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

@class LZUploadImageView;
#import <UIKit/UIKit.h>

@protocol LZUploadImageViewDelegate <NSObject>
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
- (void)tapUploadImageView:(LZUploadImageView *)view;

@end

@interface LZUploadImageView : UIView

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
@property (nonatomic, weak) id<LZUploadImageViewDelegate> delegate;

@end
