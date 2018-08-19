//
//  BYPhotoAddView.m
//  JDemo
//
//  Created by BangYou on 2018/1/22.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYPhotoAddView.h"
#import "UIButton+EdgeInsets.h"

//#import "UIImage+ImageCompress.h"

@class BYPhotoAddViewCell;

@interface BYPhotoAddView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UILongPressGestureRecognizer *longpress;
@end

@implementation BYPhotoAddView
{
    BOOL _getOneButton;
    
    CGPoint _startPoint;
    CGPoint _endPoint;
    UICollectionViewCell *_selectView;
    
    CGRect _startRect;
    CGRect _toRect;
    BOOL _cantReloadModel;
    
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    _maxCount = 4;
    _maxVideoCount = 1;
    _photoModelArray = [NSMutableArray arrayWithCapacity:_maxCount];
    self.backgroundColor = [UIColor whiteColor];
    [self getAddPhotoModel];
    
    
    NSUInteger col = 5;
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.minimumLineSpacing = CellMargin;
    flowlayout.minimumInteritemSpacing = CellMargin;
    flowlayout.itemSize = CGSizeMake((APPWidth - (col+1)*CellMargin)/col, (APPWidth - (col+1)*CellMargin)/col);
    flowlayout.sectionInset =  UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowlayout];
    [_collectionView registerClass:[BYPhotoAddViewCell class] forCellWithReuseIdentifier:[BYPhotoAddViewCell cellID]];
    [self addSubview:_collectionView];
    _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView reloadData];
    
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longpress.delegate = self;
    self.longpress = longpress;
    [_collectionView addGestureRecognizer:longpress];
}


- (void)reloadData {
    
    [self setPhotoModelArray:self.photoModelArray];
}

-(void)reloadCollction {
    [self.collectionView reloadData];
}

-(BOOL)isHadAddIcon {
    
    for (BYPhotoModel *model in _photoModelArray) {
        if (model.isAdd) {
            return YES;
        }
    }
    return NO;
}
-(BYPhotoModelType)selectType {
    for (BYPhotoModel *model in _photoModelArray) {
        if (!model.isAdd) {
            return model.modelType;
        }
    }
    // 默认就是图片好了
    return BYPhotoModelTypeImage;
}
-(void)setPhotoModelArray:(NSMutableArray<BYPhotoModel *> *)photoModelArray {
    
    _photoModelArray = photoModelArray;
    // 如果是空的 add
    if (photoModelArray && photoModelArray.count == 0) {
        
        [self getAddPhotoModel];
    }else{
        
        BYPhotoModel *photoModel = photoModelArray[0];
        if (photoModel.modelType == BYPhotoModelTypeImage && photoModelArray.count<_maxCount) {
            
            // 如果是图片
            if (!self.isHadAddIcon) {
                [self getAddPhotoModel];
            }
            
        }else if (photoModel.modelType == BYPhotoModelTypeVideo && photoModelArray.count<_maxVideoCount){
            // 可以选择多个视频
            if (!self.isHadAddIcon) {
                [self getAddPhotoModel];
            }
            
        }
    }
    self.height = (photoModelArray.count/4 + 1) *((APPWidth - 5*CellMargin)/4)  + CellMargin;
    [_collectionView reloadData];
}

/// 添加 + 号的那个按钮
- (void)getAddPhotoModel {
    BYPhotoModel *photoModel = [BYPhotoModel new];
    photoModel.isAdd = YES;
    [_photoModelArray  addObject:photoModel];
}

#pragma mark - Click
- (void)didClickDelectModel:(BYPhotoModel *)delectModel {
    [_photoModelArray removeObject:delectModel];
    NSUInteger maxCount = _maxCount == 0?_maxVideoCount:_maxCount;
    if (_photoModelArray.count < maxCount && [_photoModelArray lastObject].isAdd == NO) {
        [self getAddPhotoModel];
    }
    [_collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(didDelectPhotoModel)]) {
        [_delegate didDelectPhotoModel];
    }
}

#pragma mark - longPress
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"开始哦");
        
        if (!indexPath) {
            return;
        }
        BOOL canMove = [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        if (!canMove) return;
        UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
        cell.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    else if (longPress.state == UIGestureRecognizerStateChanged){
        if ((indexPath.row ==_photoModelArray.count-1) && [self isHadAddIcon]) {
            [_collectionView cancelInteractiveMovement];
            return;
        }else{
            [_collectionView updateInteractiveMovementTargetPosition:point];
        }
        if (point.y <0 || point.y > _collectionView.height) {
            [_collectionView cancelInteractiveMovement];
        }
        
        // !_markCellMovingBlock?:_markCellMovingBlock(_longpress);
    }
    else if (longPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"取消哦");
        [_collectionView endInteractiveMovement];
        //[_collectionView reloadData];
        //!_markCellMoveLongPressBlock?:_markCellMoveLongPressBlock(NO);
        _selectView.transform = CGAffineTransformIdentity;
    }else{
        [_collectionView cancelInteractiveMovement];
    }
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.row ==_photoModelArray.count-1) && [self isHadAddIcon]) {
        return NO;
    }
    return YES;
}
//当移动结束的时候会调用这个方法。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    BYPhotoModel *item= _photoModelArray[sourceIndexPath.row];
    [_photoModelArray removeObjectAtIndex:sourceIndexPath.row];
    [_photoModelArray insertObject:item atIndex:destinationIndexPath.row];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoModelArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BYPhotoAddViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BYPhotoAddViewCell cellID] forIndexPath:indexPath];
    BYPhotoModel *model = [_photoModelArray objectAtIndex:indexPath.row];
    cell.photoModel = model;
    WEAKSELF;
    cell.clickCloseBlock = ^{
        [weakSelf didClickDelectModel:model];
    };
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // 处理点击的事件，通过代理
    BYPhotoModel *model = [_photoModelArray objectAtIndex:indexPath.row];
    if (model.isAdd && _delegate && [_delegate respondsToSelector:@selector(clickAddButton)]) {
        [_delegate clickAddButton];
    }
    if (!model.isAdd && _delegate && [_delegate respondsToSelector:@selector(clickSubviewAtIndex:)]) {
        [_delegate clickSubviewAtIndex:indexPath.row];
    }
}
@end

#pragma mark -
#pragma mark - Cell
@implementation BYPhotoAddViewCell
{
    UIImageView *_backImageView;
    UIView *_bottomTool;
    UIButton *_closeButton;
    UILabel *_timeLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup {
    
    
    _backImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_backImageView];
    _backImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    _backImageView.clipsToBounds = YES;
    
    //_closeButton
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"del_image"] forState:UIControlStateNormal];
    _closeButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    _closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_closeButton];
    _closeButton.sd_layout
    .rightSpaceToView(self.contentView, -4)
    .topSpaceToView(self.contentView, -4)
    .widthIs(30).heightIs(30);
    _closeButton.expandHitEdgeInsets = UIEdgeInsetsMake(0, 30, 10, 0);
    
    //_bottomTool
    _bottomTool = [UIView new];
    [self.contentView addSubview:_bottomTool];
    _bottomTool.sd_layout
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .heightIs(25);
    _bottomTool.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    
    //_timeLabel
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = FONT(10);
    [_bottomTool addSubview:_timeLabel];
    _timeLabel.sd_layout
    .rightSpaceToView(_bottomTool, 3)
    .bottomEqualToView(_bottomTool)
    .topEqualToView(_bottomTool);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:120];
    
    //videoIcon
    UIImageView *videoIcon = [[UIImageView alloc]init];
    videoIcon.image = [UIImage imageNamed:@"add_image"];
    videoIcon.contentMode = UIViewContentModeCenter;
    [_bottomTool addSubview:videoIcon];
    videoIcon.tintColor = [UIColor whiteColor];
    videoIcon.sd_layout
    .topEqualToView(_bottomTool)
    .leftEqualToView(_bottomTool)
    .bottomEqualToView(_bottomTool)
    .widthEqualToHeight();
    
    
}

- (void)setPhotoModel:(BYPhotoModel *)photoModel {
    
    _photoModel = photoModel;
    if (photoModel.isAdd) {
        _closeButton.hidden = YES;
        _bottomTool.hidden = YES;
        _backImageView.image = [UIImage imageNamed:@"add_image"];
        _backImageView.contentMode = UIViewContentModeScaleToFill;
        return;
    }
    
    _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [photoModel loadThumImage:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            _backImageView.image = photoModel.thumPhotoImage;
            if (photoModel.modelType == BYPhotoModelTypeVideo){
                // 视频
                _closeButton.hidden = NO;
                _bottomTool.hidden = NO;
                _timeLabel.text = photoModel.videoTimeStr;
                
            }else {
                // 图片
                _closeButton.hidden = NO;
                _bottomTool.hidden = YES;
            }
            
        });
    }];
    
    
}

#pragma mark - Click
- (void)clickCloseButton {
    !_clickCloseBlock?:_clickCloseBlock();
}

-(void)dealloc {
    NSLog(@"addView dealloc");
}
@end



