//
//  LLOutboundSeletedVC.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//  侧栏选择仓库

#import "LLOutboundSeletedVC.h"
#import "LLOutbounceSeletedLeftCell.h"
#import "LLOutbounceSeletedHeaderView.h"
#import "LLOutbounceSeletedRightCell.h"
@interface LLOutboundSeletedVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UITableView * leftTableView;

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) NSArray <LLOutboundlistModel *> * leftListModel;

@property (nonatomic,strong) NSArray <LLOutboundRightModel *> * rightModels;

@end

@implementation LLOutboundSeletedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData {
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"productId":self.itemModel.productId,
                             @"productColorId":self.itemModel.productColorId
                             };
    [BXSHttp requestPOSTWithAppURL:@"product/house_list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        if ([baseModel.data count] == 0) {
            
            [self dismissViewControllerAnimated:YES completion:^{}];
            return;
        }
        self.leftListModel = [LLOutboundlistModel LLMJParse:baseModel.data];
        self.leftListModel.firstObject.seleted = true;
        [self.leftTableView reloadData];
        [self tableView:self.leftTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } failure:^(NSError *error) {
        
    }];
}

-(void)setupUI {
    //    UIView * totalView = [UIView new];
    //    [self.view addSubview:totalView];
    //    totalView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.equalTo(self.view);
    //        make.top.equalTo(self.view).offset(20);
    //        make.height.mas_equalTo(45);
    //    }];
    //    UILabel * totalLable = [UILabel new];
    //    [totalView addSubview:totalLable];
    //    totalLable.text = [NSString stringWithFormat:@"总条数:%@",self.itemModel.number];
    //    totalLable.textColor = [UIColor darkGrayColor];
    //    totalLable.font = [UIFont systemFontOfSize:16];
    //    [totalLable mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(totalView).offset(20);
    //        make.centerY.equalTo(totalView);
    //    }];
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.leftTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.leftTableView];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    [self.leftTableView registerClass:[LLOutbounceSeletedLeftCell class] forCellReuseIdentifier:@"LLOutbounceSeletedLeftCell"];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
        make.width.mas_equalTo(100);
    }];
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LLOutbounceSeletedRightCell class] forCellWithReuseIdentifier:@"LLOutbounceSeletedRightCell"];
    [self.collectionView registerClass:[LLOutbounceSeletedHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLOutbounceSeletedHeaderView"];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(self.leftTableView.mas_top);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.leftTableView.mas_bottom);
    }];
    
    UIButton * bottomBtn = [UIButton new];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn setTitle:@"确 定" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    bottomBtn.backgroundColor = LZAppBlueColor;
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.leftTableView.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftListModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LLOutbounceSeletedLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLOutbounceSeletedLeftCell"];
    cell.model = self.leftListModel[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.leftListModel enumerateObjectsUsingBlock:^(LLOutboundlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.seleted = false;
        if (indexPath.row == idx) {
            obj.seleted = true;
        }
    }];
    NSDictionary * param = @{
                             @"companyId":[BXSUser currentUser].companyId,
                             @"houseId":self.leftListModel[indexPath.row].houseId,
                             @"productColorId":self.itemModel.productColorId,
                             @"productId":self.itemModel.productId,
                             };
    [BXSHttp requestGETWithAppURL:@"product/house_val.do" param: param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            [LLHudTools showWithMessage:baseModel.msg];
            return ;
        }
        self.rightModels = [LLOutboundRightModel LLMJParse:baseModel.data];
        [self.rightModels enumerateObjectsUsingBlock:^(LLOutboundRightModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.leftModel = self.leftListModel[indexPath.row];
        }];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.rightModels.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rightModels[section].itemList.count;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    LLOutbounceSeletedHeaderView *  reusableHeaerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableHeaerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLOutbounceSeletedHeaderView" forIndexPath:indexPath];
        WEAKSELF
        reusableHeaerView.block = ^(LLOutbounceSeletedHeaderView *headerView) {
            headerView.model.seleted = !headerView.model.seleted;
            [weakSelf.collectionView reloadData];
        };
        
    }
    reusableHeaerView.model = self.rightModels[indexPath.section];
    return reusableHeaerView;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLOutbounceSeletedRightCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLOutbounceSeletedRightCell" forIndexPath:indexPath];
    cell.model = self.rightModels[indexPath.section].itemList[indexPath.row];
    cell.totalCount.hidden = !self.rightModels[indexPath.section].seleted;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.frame)-100, 45);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.rightModels[indexPath.section].seleted ? CGSizeMake(60, 30) : CGSizeMake(0, 0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 12, 5, 12);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.rightModels[indexPath.section].itemList[indexPath.row].seleted = ! self.rightModels[indexPath.section].itemList[indexPath.row].seleted;
    [collectionView reloadData];
}
-(void)bottomBtnClick {
    
    //seleteds存放LLOutboundRightDetailModel 用来判断是否选择产品
    NSMutableArray <LLOutboundRightDetailModel *> * seleteds = [NSMutableArray array];
#warning 直接把self.rightModels传回上个页面
    //    [self.rightModels enumerateObjectsUsingBlock:^(LLOutboundRightModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        [obj.itemList enumerateObjectsUsingBlock:^(LLOutboundRightDetailModel * _Nonnull itemObj, NSUInteger idx, BOOL * _Nonnull stop) {
    //            if (itemObj.seleted) {
    //                [seleteds addObject:obj];
    //            }
    //        }];
    //    }];
    
    for (LLOutboundRightModel *rightModel in self.rightModels) {
        
        for (LLOutboundRightDetailModel *detailModel in rightModel.itemList) {
            detailModel.houseName = rightModel.leftModel.houseName;
            if (detailModel.seleted) {
                [seleteds addObject:detailModel];
            }
            
        }
        
    }
    if (!seleteds.count) {
        [LLHudTools showWithMessage:@"请选择产品"];
        return;
    }
    self.block(self.rightModels.mutableCopy,self.itemModel);
    [self dismissViewControllerAnimated:true completion:nil];
    
    
}





@end
