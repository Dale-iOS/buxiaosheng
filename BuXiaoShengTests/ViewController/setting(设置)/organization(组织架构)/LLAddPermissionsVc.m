//
//  LLAddPermissionsVc.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddPermissionsVc.h"
#import "LLAddNewPeoleRoleModel.h"
#import "LLAddPermissonSectionView.h"
#import "LLAddPermissonCollectionViewCell.h"
@interface LLAddPermissionsVc ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray <LLAddNewPeoleRoleModel *> * roles;
@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation LLAddPermissionsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"选择添加权限"];
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightBtn.titleLabel.font = FONT(15);
    [navRightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(selectornavRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo (30);
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-LLAddHeight);
        make.top.equalTo(self.view);
    }];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"memberId":self.model.id
                             };
    [BXSHttp requestGETWithAppURL:@"member/company_usable_role.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.roles = [LLAddNewPeoleRoleModel LLMJParse:baseModel.data];
        [self.exis_roles enumerateObjectsUsingBlock:^(LLAddNewPeoleRoleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.roles enumerateObjectsUsingBlock:^(LLAddNewPeoleRoleModel * _Nonnull currentObj, NSUInteger idx, BOOL * _Nonnull stop) {
                [currentObj.itemList enumerateObjectsUsingBlock:^(LLAddNewPeoleRoleModel * _Nonnull itemObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.id isEqualToString:itemObj.id]) {
                        currentObj.exis_role = true;
                    }
                }];
            }];
        }];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.roles.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.roles[section].itemList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(LLScale_WIDTH(130), LLScale_WIDTH(130));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);//分别为上、左、下、右
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){SCREEN_WIDTH,60};
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return (CGSize){0,22};
//}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LLAddPermissonSectionView * sectionView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLAddPermissonSectionView" forIndexPath:indexPath];
    
    sectionView.model = self.roles[indexPath.section];
    return sectionView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LLAddPermissonCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLAddPermissonCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.roles[indexPath.section].itemList[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.roles[indexPath.section].itemList[indexPath.row].exis_role = !self.roles[indexPath.section].itemList[indexPath.row].exis_role;
    [collectionView reloadData];
}

-(void)selectornavRightBtnClick {
    
    NSMutableArray * btnIds = [NSMutableArray array];
    [self.roles enumerateObjectsUsingBlock:^(LLAddNewPeoleRoleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.itemList enumerateObjectsUsingBlock:^(LLAddNewPeoleRoleModel * _Nonnull itemObj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (itemObj.exis_role) {
                [btnIds addObject:itemObj.id];
            }
           
        }];
    }];
    if (!btnIds.count) {
        [LLHudTools showWithMessage:@"请选择权限"];
        return;
    }
    NSMutableString * btnIdStrs = [NSMutableString string];
    [btnIds enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [btnIdStrs appendString:obj];
        }else {
           [btnIdStrs appendString:[NSString stringWithFormat:@",%@",obj]];
        }
    }];
    
//    接口名称 添加权限
    NSDictionary * param = @{@"bids":btnIdStrs,
                             @"companyId" :[BXSUser currentUser].companyId,
                             @"memberId" :self.model.id
                             };
    [BXSHttp requestPOSTWithAppURL:@"member/add_role_button.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        [LLHudTools showWithMessage:@"权限添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [self.navigationController popViewControllerAnimated:true];
        });
       
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}



-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
//        layout.minimumLineSpacing = 15; //行间距
//        layout.minimumInteritemSpacing = 10; //..列间距
//        layout.itemSize = CGSizeMake(LLScale_WIDTH(130), LLScale_WIDTH(130));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LLAddPermissonCollectionViewCell class] forCellWithReuseIdentifier:@"LLAddPermissonCollectionViewCell"];
        [_collectionView registerClass:[LLAddPermissonSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLAddPermissonSectionView"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
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
