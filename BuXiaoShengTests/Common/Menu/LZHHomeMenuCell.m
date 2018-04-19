//
//  LZHHomeMenuCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZHHomeMenuCell.h"
#import "LZHMenuBtnView.h"

@interface LZHHomeMenuCell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *firstBgView;
@property (nonatomic, strong) UIView *secondBgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation LZHHomeMenuCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


+ (instancetype)cellWithTableView:(UITableView *)tableView menuArray:(NSArray *)menuArray;
{
    static NSString *menuID = @"menu";
    LZHHomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuID];
    if (cell == nil) {
        cell = [[LZHHomeMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuID menuArray:menuArray];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSArray *)menuArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _firstBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 160)];
        _secondBgView = [[UIView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, 160)];
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 180)];
        scrollView.delegate = self;
        //设置scrollView的滚动大小
        scrollView.contentSize = CGSizeMake(2*APPWidth, 180);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView addSubview:_firstBgView];
        [scrollView addSubview:_secondBgView];
        [self addSubview:scrollView];
        
        //创建8个
        for (int i = 0; i < 16; i++) {
            if (i < 4) {
                CGRect frame = CGRectMake(i*APPWidth/4, 0, APPWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                LZHMenuBtnView *btnView = [[LZHMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_firstBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
                
            }else if(i<8){
                CGRect frame = CGRectMake((i-4)*APPWidth/4, 80, APPWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                LZHMenuBtnView *btnView = [[LZHMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_firstBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else if(i < 12){
                CGRect frame = CGRectMake((i-8)*APPWidth/4, 0, APPWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                LZHMenuBtnView *btnView = [[LZHMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_secondBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }else{
                CGRect frame = CGRectMake((i-12)*APPWidth/4, 80, APPWidth/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imageStr = [menuArray[i] objectForKey:@"image"];
                LZHMenuBtnView *btnView = [[LZHMenuBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
                btnView.tag = 10+i;
                [_secondBgView addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                [btnView addGestureRecognizer:tap];
            }
        }
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(APPWidth/2-20, 160, 0, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        [self addSubview:_pageControl];
        
    }
    return  self;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW =  scrollView.frame.size.width;
    //算出水平移的距离
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}

//在这个地方搞一个代理通知控制器哪个按钮被点了 作出应以的处理
-(void)OnTapBtnView:(UITapGestureRecognizer*)sender{
    //    JFLog(@"%ld", (long)sender.view.tag);
    if ([self.delegate respondsToSelector:@selector(homeMenuCellClick:)]) {
        [self.delegate homeMenuCellClick:(NSInteger)sender.view.tag];
    }
}

@end
