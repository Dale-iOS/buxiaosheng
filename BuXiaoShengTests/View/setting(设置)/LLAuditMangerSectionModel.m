//
//  LLAuditMangerSectionModel.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/14.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLAuditMangerSectionModel.h"

@implementation LLAuditMangerSectionModel
{
    UIImageView * _arrowImageView;
    UILabel * _nameLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

-(void)setupUI {
    _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset((15));
        make.centerY.equalTo(self.contentView);
    }];
}

@end
