//
//  LLWarehouseSlideCollectionCell.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseSlideCollectionCell.h"
#import "LLWarehouseSideModel.h"
@interface LLWarehouseSlideCollectionCell()
@property(nonatomic,strong)UILabel *titleLable;
@end
@implementation LLWarehouseSlideCollectionCell
-(void)setModel:(LLWarehouseSideRigthRowModel *)model {
    _model = model;
    self.titleLable.text = model.value;
    if (model.seleted) {
        self.contentView.layer.borderColor = [UIColor blueColor].CGColor;
    }else {
        self.contentView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.masksToBounds = true;
        self.contentView.layer.cornerRadius = 8;
        self.contentView.layer.borderWidth = 1;
        self.titleLable = [UILabel new];
        [self.contentView addSubview:self.titleLable];
        self.titleLable.textColor = [UIColor darkGrayColor];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}
@end
