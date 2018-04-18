//
//  HomeEntranceView.m
//  BuXiaoShengTests
//
//  Created by 罗镇浩 on 2018/4/11.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "HomeEntranceView.h"
#import "HomeEntranceCell.h"
#import "SaleViewController.h"
#import "SalesDemandViewController.h"
#import "FinancialViewController.h"



@interface HomeEntranceView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation HomeEntranceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //设置item的属性
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(APPWidth /3, 94);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 94) collectionViewLayout:flow];
    //复用
    [collectionView registerClass:[HomeEntranceCell class] forCellWithReuseIdentifier:@"cellid"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:collectionView];

}

//一组返回item数量
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    HomeEntranceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    
    switch (indexPath.row) {
        case 0:
        {
            cell.iconImageView.image = IMAGE(@"sale");
        }
            break;
        case 1:
        {
            cell.iconImageView.image = IMAGE(@"financial");
            cell.titileLabel.text = @"财务";
        }
            break;
        case 2:
        {
            cell.iconImageView.image = IMAGE(@"warehouse");
            cell.titileLabel.text = @"仓库";
        }
            break;
//        case 3:
//        {
//            cell.iconImageView.image = IMAGE(@"sale");
//        }
//            break;
        default:
            break;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了 %ld",(long)indexPath.row);
    if (indexPath.row == 0) {
        
        SaleViewController *vc = [[SaleViewController alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        FinancialViewController *vc = [[FinancialViewController alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
}

//设置itme大小
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((APPWidth -3*50) /2 +20, 60);
}

//设置每个item的边距
-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
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



//@synthesize imageView1,titile1,imageView2,titile2,imageView3,titile3;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//        [self addSubview:self.imageView1];
//        [self addSubview:self.titile1];
//        [self addSubview:self.imageView2];
//        [self addSubview:self.titile2];
//        [self addSubview:self.imageView3];
//        [self addSubview:self.titile3];
//
//        [self setNeedsUpdateConstraints];
//    }
//    return self;
//}
//
//#pragma mark ------- lazy loading ---------
//- (UIImageView *)imageView1
//{
//    if (!imageView1) {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = IMAGE(@"sale");
//
//        [self addSubview:(imageView1 = imageView)];
//    }
//    return imageView1;
//}
//
//- (UILabel *)titile1
//{
//    if (!titile1) {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"销售";
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:(titile1 = label)];
//    }
//    return titile1;
//}
//
//- (UIImageView *)imageView2
//{
//    if (!imageView2) {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = IMAGE(@"financial");
//        [self addSubview:(imageView2 = imageView)];
//    }
//    return imageView2;
//}
//
//- (UILabel *)titile2
//{
//    if (!titile2) {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"财务";
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:(titile2 = label)];
//    }
//    return titile2;
//}
//
//- (UIImageView *)imageView3
//{
//    if (!imageView3) {
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = IMAGE(@"warehouse");
//        [self addSubview:(imageView3 = imageView)];
//    }
//    return imageView3;
//}
//
//- (UILabel *)titile3
//{
//    if (!titile3) {
//        UILabel *label = [[UILabel alloc]init];
//        label.text = @"仓库";
//        label.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:(titile3 = label)];
//    }
//    return titile3;
//}
//
//- (void)updateConstraints
//{
//    [super updateConstraints];
//
//
//
//    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
//        make.left.equalTo(self).with.offset(UIAdaptiveRate(50));
//        make.width.equalTo(@(UIAdaptiveRate(50)));
//        make.height.equalTo(@(UIAdaptiveRate(50)));
//    }];
//
//    [self.titile1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        //    make.top.equalTo(self.imageView1.mas_bottom).width.offset(UIAdaptiveRate(-10));
//        //        make.left.equalTo(self.imageView1);
//        //        make.right.equalTo(self.imageView1);
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
//        make.left.equalTo(self).with.offset(UIAdaptiveRate(50));
//        make.width.equalTo(@(UIAdaptiveRate(50)));
//        make.height.equalTo(@(UIAdaptiveRate(26)));
//    }];
//
//    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
//        make.left.equalTo(self.imageView1.mas_right).with.offset(UIAdaptiveRate(80));
//        make.width.equalTo(@(UIAdaptiveRate(50)));
//        make.height.equalTo(@(UIAdaptiveRate(50)));
//    }];
//
//    [self.titile2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
//        make.left.equalTo(self.imageView2);
//        //        make.right.equalTo(self.imageView2);
//        //        make.left.equalTo(self).with.offset(UIAdaptiveRate(145));
//        //        make.centerY.equalTo(self.imageView2);
//        make.width.equalTo(@(50));
//        make.height.equalTo(@(UIAdaptiveRate(26)));
//    }];
//    //
//    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(25));
//        make.left.equalTo(self.imageView2.mas_right).with.offset(UIAdaptiveRate(80));
//        make.width.equalTo(@(UIAdaptiveRate(50)));
//        make.height.equalTo(@(UIAdaptiveRate(50)));
//    }];
//
//    [self.titile3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).with.offset(UIAdaptiveRate(80));
//        make.left.equalTo(self.imageView3);
//
//        make.width.equalTo(@(50));
//        make.height.equalTo(@(UIAdaptiveRate(26)));
//    }];
//
//
//}
//

@end

