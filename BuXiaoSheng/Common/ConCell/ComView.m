//
//  ComView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "ComView.h"

@implementation ComView

/// 展开|收起 
+ (UIButton *)foldingBtnWithSupView:(UIView *)supView
{
    UIButton*_foldingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [supView addSubview:_foldingBtn];
    [_foldingBtn setTitle:@"展开    " forState:UIControlStateNormal];
    [_foldingBtn setTitle:@"收起    " forState:UIControlStateSelected];
    _foldingBtn.titleLabel.font = FONT(12);
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateNormal];
    [_foldingBtn setTitleColor:[UIColor colorWithHexString:@"#3d9bfa"] forState:UIControlStateSelected];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_close"] forState:UIControlStateNormal];
    [_foldingBtn setImage:[UIImage imageNamed:@"dyeing_show"] forState:UIControlStateSelected];
    
    [_foldingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(supView).offset(-15);
        make.centerY.equalTo(supView);
        // make.width.mas_equalTo(100);
    }];
    [_foldingBtn layoutIfNeeded];
    _foldingBtn.titleEdgeInsets = UIEdgeInsetsMake(0,  -(_foldingBtn.titleLabel.frame.origin.x), 0, 0);
    _foldingBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width), 0, -(_foldingBtn.frame.size.width - _foldingBtn.imageView.frame.origin.x - _foldingBtn.imageView.frame.size.width));

    return _foldingBtn;
}

@end
