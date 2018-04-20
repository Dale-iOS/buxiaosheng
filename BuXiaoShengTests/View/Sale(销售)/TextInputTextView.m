//
//  TextInputTextView.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/4/13.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "TextInputTextView.h"
#import "UITextView+Placeholder.h"

@interface TextInputTextView()<UITextViewDelegate>
@end

@implementation TextInputTextView
@synthesize titleLabel,textView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!titleLabel) {
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(15, 15, 90, 15);
        label.font = FONT(14);
        label.textColor = CD_Text33;
        [self addSubview:(titleLabel = label)];
    }
    return titleLabel;
}

- (UITextView *)textView
{
    if (!textView) {
        
        UITextView *textV = [[UITextView alloc]init];
        textV.frame = CGRectMake(120, 7, APPWidth -120 -15, 60);
        textV.font = FONT(14);
        textV.placeholderColor = CD_textCC;
        [self addSubview:(textView = textV)];
    }
    return textView;
}


@end
