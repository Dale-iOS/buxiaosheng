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
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /10, 10);
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 85, APPWidth, 200) collectionViewLayout:flow];
    
    [self.collectView registerClass:[FinancialCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    //    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    FinancialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    
    if (indexPath.row == 0) {
        
        cell.iconImageView.image = IMAGE(@"dyeing");
        cell.titileLabel.text = @"织造染色";
    }
    else if (indexPath.row == 1)
    {
        cell.iconImageView.image = IMAGE(@"process");
        cell.titileLabel.text = @"采购加工";
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        
        //织造染色
        DyeingViewController *vc = [[DyeingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        //采购加工
        ProcessViewController *vc = [[ProcessViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(APPWidth /5, 10);
}

//设置每个item的边距 上下左右
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
