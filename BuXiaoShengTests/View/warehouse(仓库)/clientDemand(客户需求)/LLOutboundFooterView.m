//
//  LLOutboundFooterView.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/31.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLOutboundFooterView.h"

@implementation LLOutboundFooterView
{
    //总库存量
    UILabel * _totalSaveCountLable;
    //总出库存数
    UILabel * _totalOutCountLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setModel:(LZOutboundItemListModel *)model {
    _model = model;
    if (_model.seleted) {
        _totalSaveCountLable .hidden = false;
         _totalOutCountLable .hidden = false;
    }else {
        _totalSaveCountLable .hidden = true;
        _totalOutCountLable .hidden = true;
    }
    
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setupUI {
    
    _totalSaveCountLable = [UILabel new];
    _totalSaveCountLable.text = @"总库存数:0";
    [self.contentView addSubview:_totalSaveCountLable];
    _totalSaveCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _totalSaveCountLable.font = [UIFont systemFontOfSize:14];
   
    
    _totalOutCountLable = [UILabel new];
    _totalOutCountLable.text = @"总出库数:0";
    [self.contentView addSubview:_totalOutCountLable];
    _totalOutCountLable.textColor = [UIColor colorWithHexString:@"#333333"];
    _totalOutCountLable.font = [UIFont systemFontOfSize:14];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [_totalSaveCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(80);
        make.centerY.equalTo(self.contentView);
    }];
    
    [_totalOutCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-80);
        make.centerY.equalTo(self.contentView);
    }];
}

@end
