//
//  MPPictureBrowseViewController.h
//  TemplateTest
//
//  Created by caijingpeng on 16/5/22.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPPictureBrowseViewControllerDelegate <NSObject>

@optional

- (void)didDeletePicture:(NSString *)imageUrl;


/**
 根据当前查看的图片视图的索引删除当前查看的图片视图
 
 @param imageIndex 当前查看的图片视图的索引
 */
- (void)deleteImageWithImageIndex:(NSInteger)imageIndex;

@end


/**
 图片浏览界面
 */
@interface MPPictureBrowseViewController : BaseViewController
{
    //最原始的数据:不变更
    NSMutableArray *sourceArr;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;

/**
 展示的图片数组
 */
@property (nonatomic, strong) NSMutableArray *showImagesArr;

/**
 当前展示的图片索引
 */
@property (nonatomic, assign) NSInteger showIndex;
@property (nonatomic, assign) id<MPPictureBrowseViewControllerDelegate> delegate;

@end

