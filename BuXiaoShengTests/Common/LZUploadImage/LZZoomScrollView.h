//
//  LZZoomScrollView.h
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LZZoomScrollViewDelegate <NSObject>
@optional
- (void)handleSingleTap;

@end

@interface LZZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
    UITapGestureRecognizer *singleTapGesture;
    UITapGestureRecognizer *doubleTapGesture;
    UITapGestureRecognizer *ownerGesture;
    UIView *flagView;
}


/**
 显示图片视图
 */
@property (nonatomic, retain) UIImageView *imageView;

/**
 自身的索引
 */
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) id<LZZoomScrollViewDelegate> tDelegate;

//- (void)reloadFrame:(float)originX;
- (void)removeAllGesture;
@end
