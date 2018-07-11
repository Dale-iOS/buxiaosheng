//
//  LZPurchaseAskCell.m
//  BuXiaoSheng
//
//  Created by 罗镇浩 on 2018/6/20.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LZPurchaseAskCell.h"
#import "LZPurchaseDetailModel.h"

@implementation LZPurchaseAskCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.colorLbl = [[UILabel alloc]init];
        self.colorLbl.textAlignment = NSTextAlignmentCenter;
        self.colorLbl.font = FONT(13);
        self.colorLbl.textColor = CD_Text99;
        [self.contentView addSubview:self.colorLbl];
        [self.colorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.and.bottom.equalTo(self.contentView);
            make.width.mas_offset(APPWidth *0.25);
        }];
        
        self.needLbl = [[UILabel alloc]init];
        self.needLbl.textAlignment = NSTextAlignmentCenter;
        self.needLbl.font = FONT(13);
        self.needLbl.textColor = CD_Text99;
        [self.contentView addSubview:self.needLbl];
        [self.needLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.top.and.bottom.equalTo(self.contentView);
            make.width.mas_offset(APPWidth *0.25);
        }];
    }
    return self;
}

- (void)setModel:(LZPurchaseDetailItemListModel *)model{
    _model = model;
    self.colorLbl.text = _model.productColorName;
    self.needLbl.text = _model.number;
}

@end
