//
//  LZUploadImageView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZUploadImageView.h"

@implementation LZUploadImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.imageView];
        [self addSubview:self.deleteButton];
        self.clipsToBounds = YES;
        [self setNeedsUpdateConstraints];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}


- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:IMAGE(@"del_image") forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(toDeleteImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    WEAKSELF
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf).offset(UIAdaptiveRate(10));
        make.right.bottom.equalTo(weakSelf);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf);
        make.width.equalTo(@(UIAdaptiveRate(20)));
        make.height.equalTo(@(UIAdaptiveRate(20)));
    }];
}

#pragma mark - Setter

- (void)setImage:(UIImage *)image {
    _image = image;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    if (_image)
    {
        self.imageView.image = _image;
    }
    else
    {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    }
}

#pragma mark - 按钮点击事件

- (void)toDeleteImage:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(uploadImageViewDeleteImageUrl:)])
    {
        [_delegate uploadImageViewDeleteImageUrl:self.imageUrl];
    }
}

- (void)toTap {
    if (_delegate && [_delegate respondsToSelector:@selector(tapUploadImageView:)])
    {
        [_delegate tapUploadImageView:self];
    }
}


@end
