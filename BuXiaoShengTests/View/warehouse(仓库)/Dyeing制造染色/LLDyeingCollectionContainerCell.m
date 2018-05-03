//
//  LLDyeingCollectionCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLDyeingCollectionContainerCell.h"

@interface LLDyeingCollectionCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@end
@implementation LLDyeingCollectionCell
{
    UILabel * _codeLable;
    UIButton * _addBtn;
    UICollectionView * _leftCollectionView;
    UICollectionView * _rightCollectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setupUI {
    _codeLable = [UILabel new];
    [self.contentView addSubview:_codeLable];
    _codeLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _codeLable.font = [UIFont systemFontOfSize:15];
    _codeLable.text = @"细 码";
    [_codeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    _addBtn = [UIButton new];
    [self.contentView addSubview:_addBtn];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"dyeing_add"] forState:UIControlStateNormal];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(15);
    }];
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 15;
    _leftCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [_leftCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _leftCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_leftCollectionView];
    _leftCollectionView.delegate = self;
    _leftCollectionView.dataSource = self;
    [_leftCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_addBtn.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds)/2);
    }];
    
    _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _rightCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_rightCollectionView];
    _rightCollectionView.delegate = self;
    _rightCollectionView.dataSource = self;
    [_rightCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [_rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.top.equalTo(_addBtn.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView).offset(25);
        make.width.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds)/2);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

@end
