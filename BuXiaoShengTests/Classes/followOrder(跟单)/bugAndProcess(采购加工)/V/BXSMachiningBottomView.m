//
//  BXSMachiningBottomView.m
//  BuXiaoShengTests
//
//  Created by 家朋 on 2018/6/27.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BXSMachiningBottomView.h"

@implementation BXSMachiningBottomView

{
    UILabel *_upCountLable;
    UILabel *_downCountLable;
    
}
+ (instancetype)bottomView {
    return [[self alloc]init];
}


- (instancetype)init {
    if (self = [super init]) {
        
        [self setup];
    }
    return self;
}

-(void)setup {
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50.f);
    CGFloat leftMargin = 15.f;
    CGFloat topMargin = 5.f;
    CGFloat bottomButtonWidth = LLScale_WIDTH(340);
    
    //_upCountLable
    _upCountLable = [UILabel new];
    [self addSubview:_upCountLable];
    _upCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _upCountLable.font = [UIFont systemFontOfSize:14];
    _upCountLable.frame = CGRectMake(leftMargin, topMargin, SCREEN_WIDTH - bottomButtonWidth - leftMargin , self.height/2 - topMargin);
    
    //_downCountLable
    _downCountLable = [UILabel new];
    [self addSubview:_downCountLable];
    _downCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _downCountLable.font = [UIFont systemFontOfSize:14];
    _downCountLable.frame = CGRectMake(leftMargin, _upCountLable.bottom, _upCountLable.width, _upCountLable.height);
    
    //determineBtn
    UIButton * determineBtn = [UIButton new];
    [determineBtn setTitle:@"确  定" forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [determineBtn setBackgroundColor:[UIColor colorWithHexString:@"#3d9bfa"]];
    [self addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.mas_equalTo(LLScale_WIDTH(340));
    }];
    
    [determineBtn addTarget:self action:@selector(clickBottom) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Click
- (void)clickBottom {
    !_clickBottomTrue?:_clickBottomTrue();
}
/// 设置需求量／总数量数据
- (void)setupCount:(NSString *)upCount
       bottomCount:(NSString *)bottomCount {
    
    _upCountLable.text = upCount;
    _downCountLable.text = bottomCount;
    [self setNeedsDisplay];
    
}
///总数量数据<调用用这个方法那么只有一个总数量／隐藏总需求量>
- (void)setupCoun:(NSString *)upCount{
    _upCountLable.hidden = YES;
    _downCountLable.frame = CGRectMake(15, 0, SCREEN_WIDTH - LLScale_WIDTH(340) - 15, self.height);
    _downCountLable.text = upCount;
}

@end
