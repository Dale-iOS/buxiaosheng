//
//  SaleViewController.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "SaleViewController.h"
#import "HomeEntranceCell.h"
#import "SalesDemandViewController.h"
#import "OrderTrackingViewController.h"
#import "VisitRecordViewController.h"
#import "ClientManagerViewController.h"

@interface SaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"销售";
    self.navigationItem.titleView = [Utility navTitleView:@"销售"];
    self.navigationItem.leftBarButtonItem = [Utility navLeftBackBtn:self action:@selector(backMethod)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI
{
    //设置item的属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /4, 94);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, APPWidth, 100) collectionViewLayout:flow];
    //复用
    [collectionView registerClass:[HomeEntranceCell class] forCellWithReuseIdentifier:@"cellid"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:collectionView];
    
}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
//    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.iconImageView.image = IMAGE(@"sale");
//    cell.backgroundColor = [UIColor redColor];
    cell.iconImageView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        
        SalesDemandViewController *vc = [[SalesDemandViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        OrderTrackingViewController *vc = [[OrderTrackingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        VisitRecordViewController *vc = [[VisitRecordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        ClientManagerViewController *vc = [[ClientManagerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(APPWidth /4, 50);
}

//设置每个item的边距
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (void)backMethod {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
