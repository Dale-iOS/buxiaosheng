//
//  BYAlertHeadView.m
//  BangYou
//
//  Created by BangYou on 2017/9/28.
//  Copyright © 2017年 李麒. All rights reserved.
//


#import "BYAlertHeadView.h"

@implementation BYAlertHeadView
{
    UILabel *_titleLabel;
}
+ (instancetype)alertHeaderTitle:(NSString *)title {
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, APPWidth, 52) title:title];
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        
        _title = title;
        [self setup];
    }
    return self;
    
}
- (void)setup {
  
    self.backgroundColor = [UIColor whiteColor]; 
    UIImageView *backImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:backImgV];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, self.height)];
    [self addSubview:_titleLabel];
    _titleLabel.textColor = Text33;
    _titleLabel.font = FONT(15);
    _titleLabel.text = _title?_title:@"";
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:Text33 forState:UIControlStateNormal];
    cancleButton.titleLabel.font = FONT(15);
    CGFloat btnW = 40;
    cancleButton.frame = CGRectMake(APPWidth - 55, (self.height - btnW)/2, btnW, btnW);
    [self addSubview:cancleButton];
    
    [cancleButton addTarget:self action:@selector(clickCancle) forControlEvents:UIControlEventTouchUpInside];
    
    LineView *line = [LineView lineViewOfHeight:1];
    [self addSubview:line];
    line.top = self.height - 1;
    
    
}
- (void)clickCancle {
    
    if (_clickCancleBlock) {
        _clickCancleBlock();
    }
}

-(void)setTitle:(NSString *)title {
    
}
@end
