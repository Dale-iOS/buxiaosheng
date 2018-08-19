//
//  BYPhotoSelectCell.m
//  JDemo
//
//  Created by BangYou on 2018/1/17.
//  Copyright © 2018年 BangYou. All rights reserved.
//

#import "BYPhotoSelectCell.h"
#import "UIButton+Category.h"
 
@interface BYPhotoSelectCell ()

@property (nonatomic,strong)UIButton *selectButton;

@property (nonatomic,strong)UIView *maskView;

@property (nonatomic,strong)UIImageView *coverImageView;

@property (nonatomic,strong)UIView *bottomTool;

@property (nonatomic,strong)UILabel *timeLabel;

@end
@implementation BYPhotoSelectCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self coverImageView];
        [self maskView];
        [self selectButton];
        [self bottomTool];
    }
    return self;
}

-(void)setPhotoModel:(BYPhotoModel *)photoModel {
    _photoModel = photoModel;
    
    [photoModel loadThumImage:^{
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.coverImageView.image = photoModel.thumPhotoImage;
            if (photoModel.asset.mediaType == PHAssetMediaTypeVideo) {
                self.bottomTool.hidden = NO;
                self.timeLabel.text = photoModel.videoTimeStr;
            }else {
                self.bottomTool.hidden = YES;
            }
        });
    }];
    

    
    if (photoModel.isAdd) {
        self.coverImageView.contentMode = UIViewContentModeScaleToFill;
    }else{
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    self.selectButton.selected = photoModel.isSelect;
}



#pragma mark - Click
- (void)clickSelectButton {
    !_clickSelectBlock?:_clickSelectBlock();
}

#pragma mark - SET
-(UIImageView *)coverImageView {
    
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_coverImageView];
        _coverImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        _coverImageView.clipsToBounds = YES;
        _coverImageView.backgroundColor = [UIColor clearColor];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

-(UIButton *)selectButton {
    
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_photo_not_select18"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"BYCamera.bundle/icon_photo_select18"]
                       forState:UIControlStateSelected];
        _selectButton.imageView.sd_layout
        .rightSpaceToView(_selectButton, 10)
        .topSpaceToView(_selectButton, 10)
        .widthIs(18).heightIs(18);
//
        CGFloat btnWH = APPWidth/9.0;
        [_selectButton addTarget:self action:@selector(clickSelectButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectButton];
        _selectButton.sd_layout
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .widthIs(btnWH).heightIs(btnWH);
        
        //_selectButton.expandHitEdgeInsets = UIEdgeInsetsMake(10, 30, 30, 10);
    }
    return _selectButton;
}

-(UIView *)maskView {
    
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        [self.contentView addSubview:_maskView];
        _maskView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        _maskView.hidden = YES;
    }
    return _maskView;
}
-(UIView *)bottomTool {
    
    if (!_bottomTool) {
        
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
        videoIcon.image = [UIImage imageNamed:@"BYCamera.bundle/VideoSendIcon"];
        videoIcon.contentMode = UIViewContentModeCenter;
        [_bottomTool addSubview:videoIcon];
        videoIcon.tintColor = [UIColor whiteColor];
        videoIcon.sd_layout
        .topEqualToView(_bottomTool)
        .leftEqualToView(_bottomTool)
        .bottomEqualToView(_bottomTool)
        .widthEqualToHeight();
        
    }
    return _bottomTool;
}

@end
