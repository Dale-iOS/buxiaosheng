//
//  BYPhotoSelectPreveiwVC.m
//  JDemo
//
//  Created by BangYou on 2018/1/19.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYPhotoSelectPreveiwVC.h"

#import "BYPhotoModel.h"
@class BYPhotoSelectPreveiwCell;
@interface BYPhotoSelectPreveiwVC ()<UICollectionViewDataSource>

@property (nonatomic,strong)NSArray *selectPhotos;
@property (nonatomic,assign)NSUInteger atIndex;
@property (nonatomic,strong)BYPhotoModel *photo;
/// 只看一张（未选中的）
@property (nonatomic,assign)BOOL isOne;
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation BYPhotoSelectPreveiwVC


- (instancetype)initWithPhotos:(NSArray<BYPhotoModel*>*) selectPhotos
                       atIndex:(NSUInteger)atIdnex {
    if (self = [super init]) {
        self.selectPhotos = selectPhotos;
        self.atIndex = atIdnex;
        self.isOne = NO;
    }
    return self;
}

- (instancetype)initWithPhoto:(BYPhotoModel *)photo {
    if (self = [super init]) {
        self.photo = photo;
        self.isOne = YES;
        self.selectPhotos = @[photo];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTopbar];
    [self setupCollection];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/// 设置顶部 44
- (void)setupTopbar {
    
    //topView
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, APPWidth, 44)];
    [self.view addSubview:topView];
    
    //cancleButton
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, 50, 44)];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = FONT(14);
    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancleButton];
    
    //下表显示器
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = FONT(15);
    self.titleLabel = titleLabel;
    [topView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake((APPWidth - 120)/2, 0, 120, 44);
    if (self.isOne) {
        titleLabel.hidden = YES;
    }else{
        titleLabel.text = [NSString stringWithFormat:@"%d/%ld",1,self.selectPhotos.count];
    }
    
    
}
- (void)setupCollection {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(APPWidth, APPHeight - 64);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    [self setColoctionBy:layout];
    self.mainCollection.dataSource = self;
    [self.mainCollection registerClass:[BYPhotoSelectPreveiwCell class] forCellWithReuseIdentifier:[BYPhotoSelectPreveiwCell cellID]];
    self.mainCollection.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    self.mainCollection.pagingEnabled = YES;
    self.mainCollection.showsHorizontalScrollIndicator = NO;
    
    WEAKSELF;
    for (int i=0; i<self.selectPhotos.count;i++) {
        __block  BYPhotoModel *model = [self.selectPhotos objectAtIndex:i];
        [BYPhotoTool getOriginPhotoImageWithAsset:model.asset completion:^(UIImage *originImage, NSDictionary *info) {
            model.originPhotoImage = originImage;
            
            [weakSelf.mainCollection reloadData];
        }];
    }
    //  [self.mainCollection reloadData];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.selectPhotos.count?self.selectPhotos.count:1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BYPhotoSelectPreveiwCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BYPhotoSelectPreveiwCell cellID] forIndexPath:indexPath];
    BYPhotoModel *model = self.selectPhotos.count?[self.selectPhotos objectAtIndex:indexPath.row]:self.photo;
    cell.imageView.image = model.originPhotoImage?model.originPhotoImage:model.thumPhotoImage;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x/APPWidth;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.selectPhotos.count];
}

@end

@implementation BYPhotoSelectPreveiwCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageView];
        _imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}
@end

