//
//  ETZoomScrollView.h
//  ScrollViewWithZoom
//

#import <UIKit/UIKit.h>

@protocol ETZoomScrollViewDelegate <NSObject>
@optional
- (void)handleSingleTap;

@end

@interface ETZoomScrollView : UIScrollView <UIScrollViewDelegate>
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
@property (nonatomic, assign) id<ETZoomScrollViewDelegate> tDelegate;

//- (void)reloadFrame:(float)originX;
- (void)removeAllGesture;

@end
