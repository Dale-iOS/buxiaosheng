//
//  RecipeViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/5.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  配方表页面

#import "RecipeViewController.h"
#import "AddRecipeViewController.h"
#import "AddDyeRecipeViewController.h"

#import "DyeRecipeView.h"
#import "WeaveRecipeView.h"
#import "LZChooseRecipeVC.h"

@interface RecipeViewController ()<UIScrollViewDelegate>

///分段选择器背景
@property (nonatomic, strong) UIView *SegmentedBgView;
@property (nonatomic, strong) UISegmentedControl *SegmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

///织布配方表
@property (nonatomic, strong)WeaveRecipeView *weaveRecipeView;
///染色配方表
@property (nonatomic, strong)DyeRecipeView *dyeRecipeView;
@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.titleView = [Utility navTitleView:@"配方表"];
    
    self.navigationItem.rightBarButtonItem = [Utility navButton:self action:@selector(navigationAddClick) image:IMAGE(@"add1")];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, APPHeight -LLNavViewHeight)];
//    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.contentSize = CGSizeMake(APPWidth *2, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];

    self.SegmentedBgView = [[UIView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight, APPWidth, 40)];
    self.SegmentedBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.SegmentedBgView];
    
    self.SegmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"织布",@"染色"]];
    self.SegmentedControl.selectedSegmentIndex = 0;
    self.SegmentedControl.tintColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.SegmentedControl addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    [self.SegmentedBgView addSubview:self.SegmentedControl];
    
    self.SegmentedControl.sd_layout
    .centerYEqualToView(self.SegmentedBgView)
    .centerXEqualToView(self.SegmentedBgView)
    .widthIs(180)
    .heightIs(30);
    
    
    self.weaveRecipeView = [[WeaveRecipeView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, self.scrollView.height)];
    [self.scrollView addSubview:self.weaveRecipeView];
    
    self.dyeRecipeView = [[DyeRecipeView alloc]initWithFrame:CGRectMake(APPWidth, 0, APPWidth, self.scrollView.height)];
    [self.scrollView addSubview:self.dyeRecipeView];

}


#pragma mark ------- 点击事件 --------
- (void)navigationAddClick
{
//    if (self.SegmentedControl.selectedSegmentIndex == 0) {
//        AddRecipeViewController *vc = [[AddRecipeViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if (self.SegmentedControl.selectedSegmentIndex == 1)
//    {
//        AddDyeRecipeViewController *vc = [[AddDyeRecipeViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }

    if (self.SegmentedControl.selectedSegmentIndex == 0) {
        //织布
        LZChooseRecipeVC *vc = [[LZChooseRecipeVC alloc]init];
        vc.chooseType = ChooseTypeFromDye;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.SegmentedControl.selectedSegmentIndex == 1)
    {
        //染色
        LZChooseRecipeVC *vc = [[LZChooseRecipeVC alloc]init];
        vc.chooseType = ChooseTypeFromWeaVe;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger index = offSetX / SCREEN_WIDTH;
    self.SegmentedControl.selectedSegmentIndex = index;
 
}


- (void)segClick:(UISegmentedControl *)sgc
{
     [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * sgc.selectedSegmentIndex, 0) animated:true];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
