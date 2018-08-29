//
//  MPPictureBrowseViewController.m
//  TemplateTest
//
//  Created by caijingpeng on 16/5/22.
//  Copyright © 2016年 caijingpeng.haowu. All rights reserved.
//

#import "MPPictureBrowseViewController.h"
#import "ETZoomScrollView.h"

@interface MPPictureBrowseViewController ()<UIScrollViewDelegate>
{
    UIScrollView *baseSV;
    UIPageControl *pageControl;
}

@end

@implementation MPPictureBrowseViewController

- (id)init {
    self = [super init];
    if (self) {
        sourceArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem  = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(toDelete:) image:IMAGE(@"DeleteIcon")];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:[UIColor blackColor] andSize:CGSizeMake(APPWidth, (IOS7Later ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[Utility imageWithColor:LZAppBlueColor andSize:CGSizeMake(APPWidth, (IOS7Later ? 64 : 44))] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 创建UI

- (void)setupUI {
    baseSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APPWidth,CONTENT_HEIGHT)];
    baseSV.backgroundColor = [UIColor clearColor];
    baseSV.contentSize = CGSizeMake(_showImagesArr.count *baseSV.width, baseSV.height);
    baseSV.pagingEnabled = YES;
    baseSV.showsHorizontalScrollIndicator = NO;
    baseSV.delegate = self;
    [self.view addSubview:baseSV];
    
    
    //创建显示图片的视图
    [_showImagesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ETZoomScrollView *zoomScrollView = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(baseSV.width*idx, 0, APPWidth, CONTENT_HEIGHT)];
        if ([obj isKindOfClass:[UIImage class]])
        {
            zoomScrollView.imageView.image   = (UIImage *)obj;
        }
        else
        {
            [zoomScrollView.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)obj] placeholderImage:nil];
        }
        zoomScrollView.index             = idx;
        [baseSV addSubview:zoomScrollView];
    }];
    
    //页数显示
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CONTENT_HEIGHT -40, APPWidth, 40)];
    pageControl.numberOfPages = _showImagesArr.count;
    pageControl.currentPage   = _showIndex;
    [self.view addSubview:pageControl];
    
    //滑动到指定的索引处
    [baseSV setContentOffset:CGPointMake(_showIndex*baseSV.width, 0) animated:NO];
    
    //最原始数据源
    [sourceArr addObjectsFromArray:_showImagesArr];
}

#pragma mark - 按钮点击事件

- (void)toDelete:(id)sender {
    //根据当前编辑的视图索引取出当前删除的视图:索引注意更新
    if (_showIndex>=_showImagesArr.count)
    {
        return;
    }
    //本地源数据需要更新
    [_showImagesArr removeObjectAtIndex:_showIndex];
    
    
    //告知上界面移除对应索引图片
    [_delegate deleteImageWithImageIndex:_showIndex];
    
    
    //更改索引标记值
    if (_showIndex == 0)
    {
        _showIndex = 0;
    }
    else if(_showIndex>=_showImagesArr.count)
    {
        _showIndex = _showIndex-1;
    }
    else
    {
        //不变
//        NSAssert(@"", nil);
    }
    
    
    //更改scrollView的contentSize
    baseSV.contentSize = CGSizeMake(_showImagesArr.count *baseSV.width, baseSV.height);
    
    
    //移除已经添加的图片显示视图
    [baseSV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ETZoomScrollView class]])
        {
            [obj removeFromSuperview];
        }
    }];
    
    
    //重新创建显示图片的视图
    [_showImagesArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ETZoomScrollView *zoomScrollView = [[ETZoomScrollView alloc] initWithFrame:CGRectMake(baseSV.width*idx, 0, APPWidth, CONTENT_HEIGHT)];
        if ([obj isKindOfClass:[UIImage class]])
        {
            zoomScrollView.imageView.image   = (UIImage *)obj;
        }
        else
        {
            [zoomScrollView.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)obj] placeholderImage:nil];
        }
        zoomScrollView.index             = idx;
        [baseSV addSubview:zoomScrollView];
    }];
    
    //判断当前删除的索引是否处在两头:最前面的删除显示后面的一个;最后面的显示其前面的一个;中间位置不变
    [baseSV setContentOffset:CGPointMake(_showIndex*baseSV.width, 0) animated:NO];
    pageControl.numberOfPages = _showImagesArr.count;
    pageControl.currentPage   = _showIndex;
    
    //当删除完最后一张回到上级界面
    if (_showImagesArr.count == 0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //更改当前滑动显示的视图索引
    int page = scrollView.contentOffset.x/baseSV.width;
    _showIndex = page;
    pageControl.currentPage = _showIndex;
}


@end

