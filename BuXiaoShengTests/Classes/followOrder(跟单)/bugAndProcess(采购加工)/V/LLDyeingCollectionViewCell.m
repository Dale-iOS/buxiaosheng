//
//  LLDyeingCollectionViewCell.m
//  BuXiaoSheng
//
//  Created by 周尊贤 on 2018/5/3.
//  Copyright © 2018年 BuXiaoSheng. All rights reserved.
//

#import "LLDyeingCollectionViewCell.h"

@implementation LLDyeingCollectionViewCell
{
    UILabel * _numberLable;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numberLable = [UILabel new];
        _numberLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
        _numberLable.textAlignment = NSTextAlignmentCenter;
        _numberLable.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_numberLable];
        _numberLable.text = @"158";
        [_numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(void)setCodeModel:(LZFindCodeModel *)codeModel {
    
    _codeModel = codeModel;
    _numberLable.text = HandleNilStringToZone(codeModel.code);
}
@end
