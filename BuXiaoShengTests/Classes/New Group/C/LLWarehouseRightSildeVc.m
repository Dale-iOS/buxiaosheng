//
//  LLWarehouseRightSildeVc.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseRightSildeVc.h"
#import "LLWarehouseSlideHeaderReusableView.h"
#import "LLWarehouseSlideCollectionCell.h"
#import "LLWarehouseSlideLeftCell.h"
#import "LZInventoryDetailModel.h"
@interface LLWarehouseRightSildeVc ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UITableView * leftTableView;
@property(nonatomic ,strong)UICollectionView * rightCollectionView;
@end

@implementation LLWarehouseRightSildeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupUI {
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(120);
    }];
    [self.view addSubview:self.rightCollectionView];
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.right.bottom.equalTo(self.view);
    }];
}

-(void)setupData {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    param[@"houseId"] = self.model.id;
    param[@"productId"] = self.model.productId;
    [BXSHttp requestGETWithAppURL:@"house_stock/house_color_list.do" param:param success:^(id response) {
        
    } failure:^(NSError *error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLWarehouseSlideLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLWarehouseSlideLeftCell"];
    return cell;
   
   
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LLWarehouseSlideHeaderReusableView *  reusableHeaerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableHeaerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLWarehouseSlideHeaderReusableView" forIndexPath:indexPath];
        
    }
   // reusableHeaerView.model = self.rightModels[indexPath.section];
    return reusableHeaerView;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLWarehouseSlideCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLWarehouseSlideCollectionCell" forIndexPath:indexPath];
//    cell.model = self.rightModels[indexPath.section].itemList[indexPath.row];
//    cell.totalCount.hidden = !self.rightModels[indexPath.section].seleted;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.frame)-100, 45);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //return self.rightModels[indexPath.section].seleted ? CGSizeMake(60, 30) : CGSizeMake(0, 0);
    return CGSizeMake(0, 0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 12, 5, 12);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.rightModels[indexPath.section].itemList[indexPath.row].seleted = ! self.rightModels[indexPath.section].itemList[indexPath.row].seleted;
//    [collectionView reloadData];
}

/// MARK: ---- 懒加载
-(UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[LLWarehouseSlideLeftCell class] forCellReuseIdentifier:@"LLWarehouseSlideLeftCell"];
    }
    return _leftTableView;
}
-(UICollectionView *)rightCollectionView {
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        [_rightCollectionView registerClass:[LLWarehouseSlideCollectionCell class] forCellWithReuseIdentifier:@"LLWarehouseSlideCollectionCell"];
        [_rightCollectionView registerClass:[LLWarehouseSlideHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLWarehouseSlideCollectionCell"];
    }
    return _rightCollectionView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
