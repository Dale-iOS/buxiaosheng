//
//  LLAddPermissionsVc.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/15.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAddPermissionsVc.h"
#import "LLAddNewPeoleRoleModel.h"
@interface LLAddPermissionsVc ()
@property (nonatomic,strong) NSArray <LLAddNewPeoleRoleModel *> * roles;
@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation LLAddPermissionsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [Utility navTitleView:@"选择添加权限"];
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId,
                             @"memberId":[BXSUser currentUser].userId
                             };
    [BXSHttp requestGETWithAppURL:@"member/company_usable_role.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        self.roles = [LLAddNewPeoleRoleModel LLMJParse:baseModel.data];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 15; //行间距
        layout.minimumInteritemSpacing = 10; //..列间距
        layout.itemSize = CGSizeMake(LLScale_WIDTH(130), LLScale_WIDTH(130));
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = false;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
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
