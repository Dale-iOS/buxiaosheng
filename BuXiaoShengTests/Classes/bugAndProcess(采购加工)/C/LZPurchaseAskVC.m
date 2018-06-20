//
//  LZPurchaseAskVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/19.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  采购询问页面

#import "LZPurchaseAskVC.h"
#import "LZPurchaseDetailModel.h"
#import "LZPurchaseAskCell.h"

@interface LZPurchaseAskVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)LZPurchaseDetailModel *model;
@property(nonatomic,strong)NSArray <LZPurchaseDetailItemListModel*> *lists;
@property(nonatomic,strong)UICollectionReusableView *headerView;
@property(nonatomic,strong)UIView *footerView;
@property(nonatomic,strong)UILabel *nameLbl;//品名

@end

@implementation LZPurchaseAskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)setupUI{
    self.navigationItem.titleView = [Utility navTitleView:@"采购询问"];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UICollectionReusableView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UICollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 30)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    return _headerView;
}

- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 30)];
        _footerView.backgroundColor = [UIColor orangeColor];
    }
    return _footerView;
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake(APPWidth *0.485, 44);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 1;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 1;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 5);//上左下右
        //定义头部高度
        flowLayout.headerReferenceSize = CGSizeMake(APPWidth, 80);
        //定义尾部高度
        flowLayout.footerReferenceSize = CGSizeMake(APPWidth, 150);

        //注册cell和ReusableView
        [_collectionView registerClass:[LZPurchaseAskCell class] forCellWithReuseIdentifier:@"LZPurchaseAskCellId"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeaderId"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooterId"];
        
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

#pragma mark ---- 网络请求 ----
- (void)setupData{
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"buyId":self.bugId};
    [BXSHttp requestGETWithAppURL:@"documentary/not_handle_detail.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue] != 200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        _model = [LZPurchaseDetailModel LLMJParse:baseModel.data];
        _lists = _model.itemList;
        [_collectionView reloadData];
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
}

#pragma mark ---- UICollectionView delegate ----
// 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _lists.count;
}

// 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"LZPurchaseAskCellId";
    LZPurchaseAskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    cell.model = _lists[indexPath.row];
    //按钮事件就不实现了……
    return cell;
}

//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionElementKindSectionHeaderId" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, APPWidth, 150)];
        }
        _nameLbl = [[UILabel alloc]init];
        _nameLbl.textColor = CD_Text33;
        _nameLbl.font = FONT(14);
        _nameLbl.backgroundColor = [UIColor whiteColor];
        _nameLbl.text = @"    品名：";
        [headerView addSubview:_nameLbl];
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.right.equalTo(headerView);
            make.height.mas_offset(45);
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        [headerView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(35);
            make.top.equalTo(_nameLbl.mas_bottom);
            make.left.and.right.equalTo(headerView);
        }];
        
        UILabel *leftColorLbl = [[UILabel alloc]init];
        leftColorLbl.textColor = CD_Text33;
        leftColorLbl.font = FONT(13);
        leftColorLbl.textAlignment = NSTextAlignmentCenter;
        leftColorLbl.text = @"颜色";
        [bottomView addSubview:leftColorLbl];
        [leftColorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(bottomView);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *leftNeedLbl = [[UILabel alloc]init];
        leftNeedLbl.textColor = CD_Text33;
        leftNeedLbl.font = FONT(13);
        leftNeedLbl.textAlignment = NSTextAlignmentCenter;
        leftNeedLbl.text = @"需求量";
        [bottomView addSubview:leftNeedLbl];
        [leftNeedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(leftColorLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *rightColorLbl = [[UILabel alloc]init];
        rightColorLbl.textColor = CD_Text33;
        rightColorLbl.font = FONT(13);
        rightColorLbl.textAlignment = NSTextAlignmentCenter;
        rightColorLbl.text = @"颜色";
        [bottomView addSubview:rightColorLbl];
        [rightColorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(leftNeedLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        UILabel *rightNeedLbl = [[UILabel alloc]init];
        rightNeedLbl.textColor = CD_Text33;
        rightNeedLbl.font = FONT(13);
        rightNeedLbl.textAlignment = NSTextAlignmentCenter;
        rightNeedLbl.text = @"需求量";
        [bottomView addSubview:rightNeedLbl];
        [rightNeedLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(bottomView);
            make.left.equalTo(rightColorLbl.mas_right);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
//        headerView.backgroundColor = [UIColor redColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionElementKindSectionFooterId" forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor orangeColor];
        
        return footerView;
    }
    
    return nil;
}

// UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",indexPath.item);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
