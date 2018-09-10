//
//  LZGoodsDetailCell.m
//  BuXiaoSheng
//
//  Created by ap on 2018/7/2.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZGoodsDetailCell.h"

@implementation LZGoodsDetailCell
{
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
    
}

- (void)setup
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentTF];
    [self.contentView addSubview:self.rightArrowImageVIew];
    [self.contentView addSubview:self.lineView];
    
    self.titleLabel.sd_layout
    //    .topSpaceToView(self, 1)
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .heightRatioToView(self.contentView,1)
    .widthIs(100);
    
    self.contentTF.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.titleLabel, 50)
    .heightRatioToView(self.contentView, 1)
    .widthIs(LZHScale_WIDTH(270));
    
    self.rightArrowImageVIew.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(8)
    .heightIs(14);
    
    
    self.lineView.sd_layout
    .bottomSpaceToView(self.contentView, 0)
    .widthRatioToView(self.contentView, 1)
    .leftSpaceToView(self.contentView, 0)
    .heightIs(1);
    
}

#pragma mark ----- lazy loding -----
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = FONT(14);
        label.textColor = CD_Text33;
        //        label.backgroundColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:(_titleLabel = label)];
    }
    return _titleLabel;
}

- (UITextField *)contentTF
{
    if (!_contentTF) {
        
        UITextField *tf = [[UITextField alloc]init];
        tf.textColor = CD_Text33;
        tf.font = FONT(14);
        //        tf.backgroundColor = [UIColor redColor];
        tf.textAlignment = NSTextAlignmentLeft;
        //        tf.delegate = self;
        //        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.contentView addSubview:(_contentTF = tf)];
    }
    return _contentTF;
}


- (UIImageView *)rightArrowImageVIew
{
    if (!_rightArrowImageVIew) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.hidden = YES;
        imageView.image = IMAGE(@"rightarrow");
        [self.contentView addSubview:(_rightArrowImageVIew = imageView)];
    }
    return _rightArrowImageVIew;
}


- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = LZHBackgroundColor;
        [self.contentView addSubview:(_lineView = view)];
    }
    return _lineView;
}


- (void)setModel:(ItemList *)model
{
    _model = model;
    _titleLabel.text = _model.key;
    _contentTF.text = _model.value;
    _contentTF.placeholder = _model.placeholder;
    if (_model.isSelect) {  /// 只用一个 状态就可以判断 是否 是选择 还是 编辑
        _rightArrowImageVIew.hidden = NO;
        _contentTF.userInteractionEnabled = NO;
        if ([_model.key containsString:@"标签数量"] ) {
            _rightArrowImageVIew.hidden = YES;
        }
        
        if ([_model.key containsString:@"结算数量"]) {
            _contentTF.userInteractionEnabled = NO;
            _rightArrowImageVIew.hidden = YES;
            
        }
    }
    else{
        _contentTF.userInteractionEnabled = YES;
        _rightArrowImageVIew.hidden = YES;
        
    }
    if (_model.isEditor) {
        _contentTF.enabled = YES;
    }else{
        _contentTF.enabled = NO;
    }
    
    if (_model.isContentColorRed) {
        _contentTF.textColor = [UIColor colorWithHexString:@"#fa3d3d"];
    }else{
        _contentTF.textColor = [UIColor blackColor];
        
    }
    
    if ([_model.key containsString:@"数量"]) {
        _contentTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    
}

@end
