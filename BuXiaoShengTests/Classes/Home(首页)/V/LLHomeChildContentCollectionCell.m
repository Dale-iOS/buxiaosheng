//
//  LLHomeChildContentCollectionCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/8/7.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLHomeChildContentCollectionCell.h"
#import "LLHomeChidVC.h"
@interface LLHomeChildContentCollectionCell()

@end

@implementation LLHomeChildContentCollectionCell
-(void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    _childVc.model = _model;
    _childVc.selectIndex = selectIndex;
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI {
    
    self.childVc = [LLHomeChidVC new];
    [self.contentView addSubview:self.childVc.view];
    [self.childVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
@end
