//
//  WithSingleViewControllerViewController.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  跟单页面

#import "WithSingleViewControllerViewController.h"
#import "FinancialCollectionViewCell.h"
#import "ProcessViewController.h"
#import "DyeingViewController.h"
#import "LZBugAndProcessUntreatedVC.h"
#import "JYEqualCellSpaceFlowLayout.h"

@interface WithSingleViewControllerViewController ()<UICollectionViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectView;
@end

@implementation WithSingleViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [Utility navTitleView:@"跟单"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setCollectionView];
}

#pragma mark -------- collectionView --------
- (void)setCollectionView
{
    JYEqualCellSpaceFlowLayout * flowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:5.0];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 90);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flow.minimumLineSpacing = APPWidth *0.05;
//    flow.sectionInset = UIEdgeInsetsMake(0, APPWidth *0.05, 0,APPWidth *0.05);//上左下右
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, LLNavViewHeight +20, APPWidth, 200) collectionViewLayout:flowLayout];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    //    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {

        cell.iconImageView.image = IMAGE(@"process");
        cell.titileLabel.text = @"采购加工";
        cell.titileLabel.font = FONT(12);
        
    }
    else if (indexPath.row == 1)
    {
        cell.iconImageView.image = IMAGE(@"dyeing");
        cell.titileLabel.text = @"织造染色";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
//
    if (indexPath.row == 0) {
        
        //采购加工
//        ProcessViewController *vc = [[ProcessViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        LZBugAndProcessUntreatedVC *vc = [[LZBugAndProcessUntreatedVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        
        //织造染色
        DyeingViewController *vc = [[DyeingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
