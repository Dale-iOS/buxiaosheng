//
//  ChooseLabelsVC.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/5/17.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ChooseLabelsVC.h"
#import "ChooseLablesCell.h"
#import "ChooseLablesCollectionReusableView.h"

@interface ChooseLabelsVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *muArray;
@end

@implementation ChooseLabelsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect = self.view.frame;
    
    switch (_drawerType) {
        case DrawerDefaultLeft:
            [self.view.superview sendSubviewToBack:self.view];
            break;
        case DrawerTypeMaskLeft:
            rect.size.width = kCWSCREENWIDTH * 0.75;
            break;
        default:
            break;
    }
    
    self.view.frame = rect;
}

- (void)setupUI
{
    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, APPWidth, 30)];
    selectLabel.backgroundColor = LZHBackgroundColor;
    selectLabel.text = @"  选择标签";
    selectLabel.textColor = CD_Text99;
    selectLabel.font = FONT(12);
    selectLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:selectLabel];
    
    //假数据
    self.muArray = [[NSMutableArray alloc]init];
    for (int i = 0; i <4; i++) {
        [self.muArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, selectLabel.bottom, APPWidth, 500) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[ChooseLablesCell class] forCellWithReuseIdentifier:@"ChooseLablesCellId"];
    
    self.collectionView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
     [self.collectionView registerClass:[ChooseLablesCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    
//    UILabel *selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, APPWidth, 30)];
//    selectLabel.backgroundColor = LZHBackgroundColor;
//    selectLabel.text = @"  选择标签";
//    selectLabel.textColor = CD_Text99;
//    selectLabel.font = FONT(12);
//    selectLabel.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:selectLabel];
    
    self.nextBtn = [UIButton new];
    self.nextBtn.frame = CGRectMake(0, APPHeight -44, APPWidth *3/4, 44);
    self.nextBtn.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:155.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
    [self.nextBtn setTitle:@"确 认" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
}

#pragma  mark --- uicollectionView代理 ----
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.muArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseLablesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseLablesCellId" forIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusabel = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        
//        UICollectionReusableView *view = [collectionView dequeueReusableCellWithReuseIdentifier:UICollectionElementKindSectionFooter forIndexPath:@"footer" ]
        ChooseLablesCollectionReusableView *view  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];
//        view.titleLbl.text = [[NSString alloc]initWithString:@"尾部试图 %ld",indexPath.section];
//        view.titleLbl.text = [[NSString alloc] initWithFormat:@"尾部视图%ld",indexPath.section];
        reusabel = view;
    }
    return reusabel;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击确定后执行的操作；
    }]];
    [self presentViewController:alert animated:true completion:^{
        //显示提示框后执行的事件；
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(APPWidth *0.14, 29);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 10, 20);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//尾部试图
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(300, 20);
}

//获取标签聊表
-(void)setupData {
    NSDictionary * param = @{@"companyId":[BXSUser currentUser].companyId
                             };
    [BXSHttp requestGETWithAppURL:@"customer_label/list.do" param:param success:^(id response) {
        LLBaseModel * baseModel = [LLBaseModel LLMJParse:response];
        if ([baseModel.code integerValue]!=200) {
            BXS_Alert(baseModel.msg);
            return ;
        }
        
        
    } failure:^(NSError *error) {
        BXS_Alert(LLLoadErrorMessage);
    }];
    
}

- (void)nextBtnClick
{
    [self.muArray addObject:@"999"];
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
