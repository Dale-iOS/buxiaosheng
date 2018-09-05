//
//  LLWarehouseDetaiSlideRemakeVc.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/4.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseDetaiSlideRemakeVc.h"
#import "LLWarehouseSlideHeaderReusableView.h"
#import "LLWarehouseSlideCollectionCell.h"
#import "LLWarehouseSlideLeftCell.h"
#import "LLWarehouseSideModel.h"


@interface LLWarehouseDetaiSlideRemakeVc ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)UITableView * leftTableView;
@property(nonatomic ,strong)UICollectionView * rightCollectionView;
@property(nonatomic ,copy)NSArray <LLWarehouseSideModel*>* leftData;
@property(nonatomic ,copy)NSArray <LLWarehouseSideRigthSectionModel*>* rightData;

@end

@implementation LLWarehouseDetaiSlideRemakeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI {
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-45);
        make.width.mas_equalTo(120);
    }];
    [self.view addSubview:self.rightCollectionView];
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-45);
    }];
    UIButton * makeSureButton = [UIButton new];
    [self.view addSubview:makeSureButton];
    makeSureButton.backgroundColor = LZAppBlueColor;
    [makeSureButton addTarget:self action:@selector(makeSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    makeSureButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [makeSureButton setTitle:@"确 定" forState:UIControlStateNormal];
    [makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_offset(45);
    }];

    //[_bottomView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
}

-(void)setupData {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    param[@"productColorId"] = self.dictModel.productColorId;
    param[@"productId"] = self.dictModel.productId;
    param[@"stockId"] = self.dictModel.stockId;
    [BXSHttp requestGETWithAppURL:@"house_stock/match_house_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.leftData = [LLWarehouseSideModel LLMJParse:baseModel.data];
        self.leftData.firstObject.seleted = true;
        [self.leftTableView reloadData];
        [self tableView:self.leftTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.leftData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LLWarehouseSlideLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLWarehouseSlideLeftCell"];
    cell.model = self.leftData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"companyId"] = [BXSUser currentUser].companyId;
    param[@"houseId"] = self.leftData[indexPath.row].houseId;
    param[@"productColorId"] = self.dictModel.productColorId;
    param[@"productId"] = self.dictModel.productId;
    param[@"stockId"] = self.dictModel.stockId;
    [BXSHttp requestGETWithAppURL:@"house_stock/match_house_product_val.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.rightData = [LLWarehouseSideRigthSectionModel LLMJParse:baseModel.data];
        [self.rightCollectionView reloadData];
    } failure:^(NSError *error) {
        [LLHudTools showWithMessage:LLLoadErrorMessage];
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.rightData.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rightData[section].seleted ? self.rightData[section].itemList.count : 0;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LLWarehouseSlideHeaderReusableView *  reusableHeaerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableHeaerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLWarehouseSlideHeaderReusableView" forIndexPath:indexPath];

    }
    reusableHeaerView.collectionView = collectionView;
    reusableHeaerView.model = self.rightData[indexPath.section];
    return reusableHeaerView;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLWarehouseSlideCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLWarehouseSlideCollectionCell" forIndexPath:indexPath];
    cell.model = self.rightData[indexPath.section].itemList[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.frame)-100, 45);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return self.rightData[indexPath.section].seleted ? CGSizeMake(60, 30) : CGSizeMake(0, 0);

}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 12, 5, 12);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.rightData enumerateObjectsUsingBlock:^(LLWarehouseSideRigthSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemList enumerateObjectsUsingBlock:^(LLWarehouseSideRigthRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.seleted = false;
        }];
    }];
    self.rightData[indexPath.section].itemList[indexPath.row].seleted = true;
    [collectionView reloadData];
}
/// MARK: ---- 确定按钮的点击
-(void)makeSureButtonClick {
   __block LLWarehouseSideRigthRowModel * seletdModel;
    [self.rightData enumerateObjectsUsingBlock:^(LLWarehouseSideRigthSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemList enumerateObjectsUsingBlock:^(LLWarehouseSideRigthRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.seleted) {
                seletdModel = obj;
            }
        }];
    }];
    if (!seletdModel) {
        [LLHudTools showWithMessage:@"请选择一个你要合并的选项"];
        return;
    }
    [self dismissViewControllerAnimated:true completion:^{
        if ([self.delegate respondsToSelector:@selector(warehouseDetaiSlideDelegateWithSeletedModel:)]) {
            [self.delegate warehouseDetaiSlideDelegateWithSeletedModel:seletdModel];
        }
    }];
   
}

/// MARK: ---- 懒加载
-(UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        [_leftTableView registerClass:[LLWarehouseSlideLeftCell class] forCellReuseIdentifier:@"LLWarehouseSlideLeftCell"];
        _leftTableView.rowHeight = 45;
        _leftTableView.tableFooterView = [UIView new];
    }
    return _leftTableView;
}
-(UICollectionView *)rightCollectionView {
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _rightCollectionView.backgroundColor = [UIColor whiteColor];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        [_rightCollectionView registerClass:[LLWarehouseSlideCollectionCell class] forCellWithReuseIdentifier:@"LLWarehouseSlideCollectionCell"];
        [_rightCollectionView registerClass:[LLWarehouseSlideHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLWarehouseSlideHeaderReusableView"];
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
