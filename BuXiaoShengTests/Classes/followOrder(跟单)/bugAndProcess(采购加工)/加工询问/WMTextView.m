//
//  WMTextView.m
//  WB2
//
//  Created by WM on 15/12/31.
//  Copyright © 2015年 王猛. All rights reserved.
//

#import "WMTextView.h"

@interface WMTextView ()

@property (nonatomic,strong) UILabel *placeHolderLabel;

@end

@implementation WMTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        UILabel *  label= [[UILabel alloc]init];
        label.textColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:205/255.0 alpha:1];
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}


- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    [self.placeHolderLabel sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeHolderLabel.x = 0;
    self.placeHolderLabel.y = 8;
}

@end
