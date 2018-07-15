//
//  BigGoodsFootView.m
//  BuXiaoSheng
//
//  Created by ap on 2018/7/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "BigGoodsFootView.h"

@implementation BigGoodsFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //新增按钮
        self.backgroundColor = [UIColor whiteColor];
        UIButton *addBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        addBtn.backgroundColor = [UIColor whiteColor];
        [addBtn setBackgroundImage:IMAGE(@"addbtn") forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addBtnOnClickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        addBtn.frame = CGRectMake((SCREEN_WIDTH -92)/2, 15, 92, 30);
      
    }
    return self;
}




- (void)addBtnOnClickAction
{
    if (_didClickCompltBlock) {
        _didClickCompltBlock();
    }
}

@end
