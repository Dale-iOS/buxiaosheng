//
//  PagingTableViewCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "PagingTableViewCell.h"
#import "SGPagingView.h"
#import "NowYearViewController.h"
#import "NowQuarterViewController.h"
#import "NowMonthViewController.h"
#import "NowDayViewController.h"

@interface PagingTableViewCell()<SGPageTitleViewDelegate,SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;
@property (nonatomic, strong) UIView *bgMoreView;
@end
@implementation PagingTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat statusHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    CGFloat pageTitleViewY = 0;
    if (statusHeight == 20.0) {
        pageTitleViewY = 64;
    } else {
        pageTitleViewY = 88;
    }
    
    NSArray *titleArr = @[@"年", @"季度", @"月", @"日"];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    configure.titleSelectedColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //横杠颜色
    configure.indicatorColor = [UIColor colorWithRed:50.0f/255.0f green:149.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    //    configure.indicatorAdditionalWidth = 100; // 说明：指示器额外增加的宽度，不设置，指示器宽度为标题文字宽度；若设置无限大，则指示器宽度为按钮宽度
    
    /// pageTitleView
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 64, APPWidth, 44) delegate:self titleNames:titleArr configure:configure];
    //    self.pageTitleView.backgroundColor = [UIColor redColor];
    [self addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    
    
    NowYearViewController *allVC = [[NowYearViewController alloc]init];
    NowMonthViewController *watiOutVC = [[NowMonthViewController alloc]init];
    NowQuarterViewController *didOutVC = [[NowQuarterViewController alloc]init];
    NowDayViewController *shipmentVC = [[NowDayViewController alloc]init];

    NSArray *childArr = @[allVC, watiOutVC, didOutVC, shipmentVC   ];
    /// pageContentView
    CGFloat contentViewHeight = APPHeight - CGRectGetMaxY(_pageTitleView.frame);
//    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), APPWidth, contentViewHeight) parentVC:[self viewController] childVCs:childArr];
    
//    _pageContentView.delegatePageContentView = self;
//    [self addSubview:_pageContentView];
    
    self.bgMoreView = [[UIView alloc]init];
    self.bgMoreView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgMoreView];
    
    UILabel *moreLabel = [[UILabel alloc]init];
    moreLabel.text = @"查看详情";
    moreLabel.textColor = CD_Text99;
    moreLabel.font = FONT(13);
    [self.bgMoreView addSubview:moreLabel];
    
    UIImageView *rightarrowIMV = [[UIImageView alloc]init];;
    rightarrowIMV.image = IMAGE(@"rightarrow");
    [self.bgMoreView addSubview:rightarrowIMV];
    
    self.bgMoreView.sd_layout
//    .topSpaceToView(_pageContentView, 0)
    .bottomSpaceToView(self, 0)
    .leftEqualToView(self)
    .heightIs(40)
    .widthIs(APPWidth);
    
    moreLabel.sd_layout
    .leftSpaceToView(self.bgMoreView, 15)
    .centerYEqualToView(self.bgMoreView)
    .widthIs(60)
    .heightIs(14);
    
    rightarrowIMV.sd_layout
    .rightSpaceToView(self.bgMoreView, 15)
    .centerYEqualToView(self.bgMoreView)
    .widthIs(8)
    .heightIs(14);
    
    
}

#pragma mark ----- pageTitleViewdelegate -----
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
