//
//  CellView.m
//  BuXiaoSheng
//
//  Created by 家朋 on 2018/7/6.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "CellView.h"

@implementation CellView

{
    UILabel *_leftLable;
    UIButton *_rightButton;
    
}

- (instancetype)initWithFrame:(CGRect)frame
                         item:(ConItem *)item {
    if (self = [super initWithFrame:frame]) {
  
       

        [self setup];
        [self setContentWithItem:item];
        
    }
    return self;
}


- (void)setup {
   
    _rightButton = [UIButton new];
    [_rightButton addTarget:self action:@selector(clickCell) forControlEvents:UIControlEventTouchUpInside];
    
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setImage:IMAGE(@"auditManger_arrow") forState:0];
    _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.left.equalTo(self);
    }];
    
    
    _leftLable = [UILabel new];
    [self addSubview:_leftLable];
    _leftLable.textColor = CD_Text33;
    _leftLable.font = [UIFont systemFontOfSize:15];
    
    [_leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.mas_offset(120);
    }];
    

    _midTF = [UITextField new];
    [self addSubview:_midTF ];
    _midTF.textColor = CD_Text33;
    _midTF.font = [UIFont systemFontOfSize:15];
    [_midTF  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLable.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.bottom.top.equalTo(self);
        make.right.equalTo(self).offset(-40);
    }];
    
   
}

- (void)setContentWithItem:(ConItem*)item {
  
    _item = item;
    _leftLable.text = item.title;
    _midTF.placeholder = item.kpText;
    _midTF.text = item.contenText;
    _midTF.enabled = item.conType == ConTypeB;
    _rightButton.hidden = !(item.conType == ConTypeA);
    if (item.conType == ConTypeA) {
        [self bringSubviewToFront:_rightButton];
    }
    _leftLable.textColor  = item.titleColor?item.titleColor:[UIColor blackColor];
    
}
- (void)clickCell {
    
    !_clickCellBlock?:_clickCellBlock();
}
-(void)setK_titlewWidth:(CGFloat)k_titlewWidth {
    [_leftLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(k_titlewWidth);
    }];
}

@end
