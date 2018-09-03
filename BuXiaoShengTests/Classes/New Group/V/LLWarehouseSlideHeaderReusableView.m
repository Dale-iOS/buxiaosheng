//
//  LLWarehouseSlideHeaderReusableView.m
//  BuXiaoSheng
//
//  Created by lanlan on 2018/9/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLWarehouseSlideHeaderReusableView.h"
#import "LLWarehouseSideModel.h"
@interface LLWarehouseSlideHeaderReusableView()
@property(nonatomic ,strong)UILabel * titleLable;
@property(nonatomic ,strong)UIImageView * arrowIV;
@end
@implementation LLWarehouseSlideHeaderReusableView
-(void)setModel:(LLWarehouseSideRigthSectionModel *)model {
    _model = model;
    self.titleLable.text = [NSString stringWithFormat:@"%@   %@%@",model.batcNumber,model.number,model.unitName];
    self.arrowIV.highlighted = model.seleted;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLable = [UILabel new];
        [self addSubview:self.titleLable];
        self.titleLable.textColor = [UIColor darkGrayColor];
        self.titleLable.font = [UIFont systemFontOfSize:14];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.centerY.equalTo(self);
        }];
        self.arrowIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unfold"]];
        self.arrowIV.highlightedImage = [UIImage imageNamed:@"fold"];
        [self addSubview:self.arrowIV];
        [self.arrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
        }];
        addGestureRecognizer(self, reusableViewClick)
    }
    return self;
}

-(void)reusableViewClick{
    self.model.seleted = !self.model.seleted;
    [self.collectionView reloadData];
}
@end
