

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/** 数据模型协议 */
@protocol YANObjectProtocol <NSObject>
/**
 *  显示文本
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  显示图片，可以为NSURL,NSString,UIImage三种格式
 */
@property (nonatomic, strong) id itemImage;
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;

@end



/** 菜单单元格 */
@interface YANMenuItem : UICollectionViewCell
/**
 *  图片的尺寸，默认是(40,40)
 */
@property (nonatomic, assign) CGSize iconSize  UI_APPEARANCE_SELECTOR ;
/**
 *  图片与文本的距离，默认是 10
 */
@property (nonatomic, assign) CGFloat space UI_APPEARANCE_SELECTOR;
/**
 *  图片的圆角率，默认是20
 */
@property (nonatomic, assign) CGFloat iconCornerRadius UI_APPEARANCE_SELECTOR;
/**
 *  文本的字体颜色，默认是darkTextColor
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR ;
/**
 *  文本的字体大小，默认是14号系统字体
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

@end


@class YANScrollMenu;

/** 代理协议 */
@protocol YANScrollMenuDelegate <NSObject>
@optional
/**
 单元格尺寸，默认是(40,70)

 @param menu 菜单
 @return CGSize
 */
- (CGSize)itemSizeOfScrollMenu:(YANScrollMenu *)menu;
/**
 分区的页眉，默认不显示

 @param menu 菜单
 @param section 分区
 @return UIView
 */
- (UIView *)scrollMenu:(YANScrollMenu *)menu headerInSection:(NSUInteger)section;
/**
 页眉的高度，默认20

 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfHeaderInScrollMenu:(YANScrollMenu *)menu;
/**
 分页器的高度，默认15

 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfPageControlInScrollMenu:(YANScrollMenu *)menu;
/**
 当单元格数量改变时，是否自动更新Frame以适应。默认是NO

 @return BOOL
 */
- (BOOL)shouldAutomaticUpdateFrameInScrollMenu:(YANScrollMenu *)menu;
/**
 单元格点击回调

 @param menu 菜单
 @param indexPath 索引
 */
- (void)scrollMenu:(YANScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


/** 数据源协议 */
@protocol YANScrollMenuDataSource <NSObject>
/**
 每个分区单元格的数量

 @param menu 菜单
 @param section 分区
 @return NSUInteger
 */
- (NSUInteger)scrollMenu:(YANScrollMenu *)menu numberOfItemsInSection:(NSInteger)section;
/**
 分区的数量

 @param menu 菜单
 @return NSUInteger
 */
- (NSUInteger)numberOfSectionsInScrollMenu:(YANScrollMenu *)menu;
/**
 数据源

 @param scrollMenu 菜单
 @param indexPath 索引
 @return id<YANObjectProtocol>
 */
- (id<YANObjectProtocol>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath;

@end



/** 滑动菜单 */
@interface YANScrollMenu : UIView
/**
 *  分页控制器当前分页的颜色，默认是 darkTextColor;
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 *  分页控制器分页的颜色，默认是 groupTableViewBackgroundColor;
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 初始化方法

 @param frame CGRect
 @param aDelegate id
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame  delegate:(id)aDelegate;
/**
 刷新
 */
- (void)reloadData;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END


