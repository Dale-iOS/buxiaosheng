//
//  LLWelcomeVC.m
//  JLCWorkForApple
//
//  Created by 周尊贤 on 2018/3/1.
//  Copyright © 2018年 周尊贤. All rights reserved.
//

#import "LLWelcomeVC.h"
#import "LLWelcomeCollectionViewCell.h"
#import "HomeViewController.h"
@interface LLWelcomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSArray <NSString*>* imageArr;
@end

@implementation LLWelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageArr = @[@"welcome_1",@"welcome_2",@"welcome_3"];
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = true;
    collectionView.bounces = false;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [collectionView registerClass:[LLWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"LLWelcomeCollectionViewCell"];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLWelcomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLWelcomeCollectionViewCell" forIndexPath:indexPath];
    cell.iconImageStr = self.imageArr[indexPath.row];
    return  cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.imageArr.count-1) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [HomeViewController new];
        
    }
    
    
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
